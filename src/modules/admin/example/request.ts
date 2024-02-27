export const registerAdminRequestBody = {
  description: "create admin with email and password",
  examples: {
    example: {
      summary: "create admin",
      value: {
        firstname: "staffnene",
        lastname: "haha",
        citizen_id: "1234",
        officer_id: "1234",
        officer_card_img: "12321321",
        email: "n@gmail.com",
        password: "password",
      },
    },
  },
};
