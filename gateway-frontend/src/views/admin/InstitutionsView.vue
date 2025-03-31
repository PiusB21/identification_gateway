<template>
  <section class="bg-[var(--sec)] h-full flex flex-col items-center justify-center gap-4">
    <div class="flex justify-between bg-white w-full md:w-[70%] py-8 rounded px-4">
      <h1 class="text-2xl text-[var(--pri)]">Registered Institutions</h1>
      <v-btn flat color="primary">REGISTER</v-btn>
    </div>

    <v-table height="80%" fixed-header class="md:w-[70%]">
      <thead>
        <tr class="text-xl font-bold">
          <th class="text-left">Institution Name</th>
          <th class="text-left">Calories</th>
          <th class="text-left">Calories</th>
          <th class="text-left">Calories</th>
          <th class="text-left">Calories</th>
          <th class="text-left">Calories</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="item in desserts" :key="item.name">
          <td>{{ item.name }}</td>
          <td>{{ item.calories }}</td>
          <td>{{ item.calories }}</td>
          <td>{{ item.calories }}</td>
          <td>{{ item.calories }}</td>
          <td>{{ item.calories }}</td>
        </tr>
      </tbody>
    </v-table>
  </section>
</template>

<script setup>
const desserts = [
  {
    name: 'Frozen Yogurt',
    calories: 159,
  },
  {
    name: 'Ice cream sandwich',
    calories: 237,
  },
  {
    name: 'Eclair',
    calories: 262,
  },
  {
    name: 'Cupcake',
    calories: 305,
  },
  {
    name: 'Gingerbread',
    calories: 356,
  },
  {
    name: 'Jelly bean',
    calories: 375,
  },
  {
    name: 'Lollipop',
    calories: 392,
  },
  {
    name: 'Honeycomb',
    calories: 408,
  },
  {
    name: 'Donut',
    calories: 452,
  },
  {
    name: 'KitKat',
    calories: 518,
  },
]
</script>
