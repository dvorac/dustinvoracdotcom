/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{html,jsx,js,tsx,ts,astro,md}",
    "./public/**/*.html",
  ],
  theme: {
    colors: {
      'black': '#0D1321',
      'prussianblue': '#1D2D44',
      'electricblue': '#3E5C76',
      'shadowblue': '#748CAB',
      'eggshell': '#F0EBD8',
    },
    extend: {},
  },
  plugins: [

  ],
}
