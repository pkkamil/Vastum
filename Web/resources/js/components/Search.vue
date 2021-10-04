<template>
    <article class="ecology">
        <h2 class="ecology__header">Do kórego pojemnika wyrzucić?</h2>
        <section class="ecology__search">
            <form method="POST" @submit.prevent="fetchResults" autocomplete="off">
                <input type="text" name="q" id="search" placeholder="wyszukaj odpad" v-model="q.search">
            </form>
        </section>
        <section class="ecology__results">
            <section class="ecology__results__single" v-for="result in results" :key="result.id">
                <h3>{{ result.Nazwa }}</h3>
                <p v-if="result.Synonim"><b>Podobne:</b> {{ result.Synonim }}</p>
                <h4 v-bind:class="(result.Typ).replace(/ /g, '-').toLowerCase()">{{ result.Typ }}</h4>
            </section>
            <h2 class="ecology__results__notFound" v-if="results.length == 0 && searched">Nie znaleziono podanego odpadu w bazie!</h2>
        </section>
        <p class="ecology__destination">Aplikacja działa na podstawie bazy danych zaczerpniętej z <a href="https://api.um.warszawa.pl/" target="_blank">https://api.um.warszawa.pl/</a></p>
    </article>
</template>

<script>
 export default {
        data() {
            return {
                results: [],
                result: {
                    Identyfikator: '',
                    Nazwa: '',
                    Synonim: '',
                    Typ: '',
                },
                q: {},
                searched: false,
            };
        },
        methods: {
            fetchResults() {
                fetch('https://api.um.warszawa.pl/api/action/datastore_search/?resource_id=64b9d66c-d134-4a87-9f24-258676e9e498&q=' + this.q.search)
                    .then(res => res.json())
                    .then(res => {
                        this.results = res.result.records
                    })
                    this.results.forEach(el => {
                        console.log(el.Typ)
                    })
            this.searched = true
            },
        }
    }
</script>
