Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D232A750E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbgKEBsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:48:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730986AbgKEBsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:48:12 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61CCD206FB;
        Thu,  5 Nov 2020 01:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604540891;
        bh=rxhryKZLhwfIW0weovqx1ZhbZbPI6eEEe/Iutwi8kqo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UDhKugVBWdFxsKXThC3PeaNYPAEoauEapaeLnv9eb2Pz+kjO0ueSg5wnWNiSVgTjX
         gdsMTVRve0nzhn4Wx5w05hAJwH746QeG4KTBDBcbLNUyb88/qZv0VaQR2ZAN8BikH9
         w3xERhCgq1ZRC1Yowlz90VU3YZ4Rdv5suhdJHNP0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201103141741.2511-1-mike.looijmans@topic.nl>
References: <20201103141741.2511-1-mike.looijmans@topic.nl>
Subject: Re: [PATCH] clk-si5341: Support NVM programming through sysfs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
To:     Mike Looijmans <mike.looijmans@topic.nl>, linux-clk@vger.kernel.org
Date:   Wed, 04 Nov 2020 17:48:09 -0800
Message-ID: <160454088987.3965362.6147280271557523496@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2020-11-03 06:17:41)
> Export an attribute program_nvm_bank that when read reports the current
> bank value. To program the chip's current state into NVM, write the
> magic value 0xC7 into this attribute.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---

Any chance this can be done through the nvmem framework?

>  drivers/clk/clk-si5341.c | 73 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>=20
> diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
> index e0446e66fa64..4e025a5ea2b7 100644
> --- a/drivers/clk/clk-si5341.c
> +++ b/drivers/clk/clk-si5341.c
> @@ -1199,6 +1205,69 @@ static const struct regmap_config si5341_regmap_co=
nfig =3D {
>         .volatile_table =3D &si5341_regmap_volatile,
>  };
> =20
> +static ssize_t program_nvm_bank_show(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct i2c_client *client =3D to_i2c_client(dev);
> +       struct clk_si5341 *data =3D i2c_get_clientdata(client);
> +       unsigned int regval;
> +       int ret;
> +
> +       ret =3D regmap_read(data->regmap, SI5341_ACTIVE_NVM_BANK, &regval=
);
> +       if (ret)
> +               return ret;
> +
> +       return sprintf(buf, "%#x\n", regval);
> +}
> +
> +static ssize_t program_nvm_bank_store(struct device *dev,
> +       struct device_attribute *attr,
> +       const char *buf,
> +       size_t count)
> +{
> +       struct clk_si5341 *data =3D i2c_get_clientdata(to_i2c_client(dev)=
);
> +       int ret;
> +       unsigned int value;
> +       unsigned int timeout;
> +
> +       ret =3D kstrtouint(buf, 0, &value);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* Write the magic value to this attribute to program the NVM */
> +       if (value !=3D SI5341_SI5341_NVM_WRITE_COOKIE)
> +               return -EINVAL;
> +
> +       ret =3D regmap_write(data->regmap, SI5341_NVM_WRITE,
> +                       SI5341_SI5341_NVM_WRITE_COOKIE);
> +       if (ret)
> +               return ret;
> +
> +       /* Wait for SI5341_DEVICE_READY register to become 0x0f */
> +       for (timeout =3D 10000; timeout; --timeout) {
> +               ret =3D regmap_read(data->regmap, SI5341_DEVICE_READY, &v=
alue);

This is regmap_read_poll_timeout()?

> +               if (ret)
> +                       return ret;
> +
> +               if (value =3D=3D 0x0f)
> +                       break;
> +       }
> +
> +       return count;
> +}
> +
> +static DEVICE_ATTR_RW(program_nvm_bank);
> +
> +static struct attribute *si5341_sysfs_entries[] =3D {
> +       &dev_attr_program_nvm_bank.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group si5341_attr_group =3D {
> +       .name   =3D NULL, /* put in device directory */
> +       .attrs  =3D si5341_sysfs_entries,
> +};

If not nvmem framework, then this needs to be documented in
Documentation/ABI/

> +
>  static int si5341_dt_parse_dt(struct i2c_client *client,
>         struct clk_si5341_output_config *config)
>  {
> @@ -1544,6 +1613,10 @@ static int si5341_probe(struct i2c_client *client,
>         for (i =3D 0; i < data->num_synth; ++i)
>                  devm_kfree(&client->dev, (void *)synth_clock_names[i]);
> =20
> +       err =3D sysfs_create_group(&client->dev.kobj, &si5341_attr_group);
> +       if (err)
> +               dev_err(&client->dev, "failed to create sysfs entries\n");
> +

Cool, I as a user would do what in this situation? The error message
seems sort of worthless.
