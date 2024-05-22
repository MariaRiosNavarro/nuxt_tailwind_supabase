import About from './about.vue';
<script setup>
import { ref, onMounted, provide } from 'vue';
// import { createClient } from "@supabase/supabase-js";
import { supabase } from '../utils/supabase.js';

const homeSection = ref([]);

const getHomeData = async () => {
  try {
    const { data, error } = await supabase.from('home_section1').select();
    if (error) {
      throw error;
    }
    homeSection.value = data;
    console.log(data);
  } catch (error) {
    console.error('Error fetching todos:', error.message);
    console.log(error);
  }
};

onMounted(() => {
  getHomeData();
});

provide('supabaseClient', supabase);
</script>

<template>
  <section
    class="h-screen w-screen flex justify-center items-center bg-base-100 gap-4"
  >
    <article
      v-for="(section, index) in homeSection"
      :key="section.id"
      class="card w-96 glass h-[70%] shadow-2xl"
    >
      <figure>
        <img :src="section.image" alt="car!" />
      </figure>
      <div class="card-body">
        <h2 class="card-title">
          {{ section.title }}
        </h2>
        <p>
          {{ section.subtitle }}
        </p>
        <p>{{ section.description }}</p>

        <div class="card-actions justify-end">
          <a :href="section.input_link" class="btn btn-primary">{{
            section.input_text
          }}</a>
        </div>
      </div>
    </article>
  </section>
</template>
