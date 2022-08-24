export default {
  props: {
    context: Object,
  },
  data() {
    return {
      configValue: undefined,
    };
  },
  async created() {
    this.getInformation()
  },
  methods: {
    async getInformation(){
      let configValue = (await getConfig('static_page', 'kanoon')).text;
      this.configValue = parseHtml(configValue);
    },
  },
  components: {},
};