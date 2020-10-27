Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E60E29A7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894586AbgJ0Jfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:35:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40493 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409421AbgJ0Jfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:35:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id f97so550832otb.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IGshFFTXhBMJZj+oIimI9I+L/2SGCYIcZp/aHudl99M=;
        b=BvUEyPB8bpW0T4Os1k1hnQdCKy+ptMPYIudXPu7+vrg3Q60T6803A5lCXczld92/7L
         gzAkI/+T4iGNu++Ii1J+XDd4xTuIqyZJavwdZw0yEtZMX9bbySGDz10U1vd3v8ofaajL
         s2RtjuXufaFZRQ5FBBFFeT8nVlO3+KGc10WytBD/yArHfCRw+EsaHkDf20CUmKCQ0KFo
         +yCyCjuqqA/nm/mc3rlHwX5eXvnUaqKH6MraXDBAthJYLqgv/PG52RMpwDBTbWqRsKHR
         elvOfvUpy1WESfQcgjnSxdHN6g63iB9+xMTrBbYPJnbOLxGhaY+iEHdYpMn23i+9PKrw
         oZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IGshFFTXhBMJZj+oIimI9I+L/2SGCYIcZp/aHudl99M=;
        b=V4zVeDRxv5Wd1p7cY9nmhz0zmFgNppwcGK8duAEWbSCess6LVOd7e24oiq5/2ikiw+
         NWig9QpvzNiMiysBUxp2aKAiYHgAAgPi/QNLOfYLJOBDzRVm5m8Zw99XCrX9ya1lt9FD
         1AZcpZ1R3rtRy+/G4lyjSMywLEfGX9afCw7Bk5dPZHXAcQ5oxj5k1mW+zz9vE5FwJmtt
         ZqKpEI+4wRO5u7IZflf1vJ6aZSeHj3jEI2XaSvd6xSMVlUA4uXaSyFGUXTKw8fCnTGwC
         F/LnxX2ld3ABPX7MPc1o9LRqNd41nq1+k86NodkBQVQfzMFUwe3uBidAkE7mgBd7WxNr
         bOAw==
X-Gm-Message-State: AOAM531jI5WDGYhXVOhEmyAOujNIOZLQEFdHZuCuabwVQBQCBwHD4oo3
        R/M00CWIYcFFqaAkAHU/dEppQPmKp2BLRVlDBac=
X-Google-Smtp-Source: ABdhPJx3uysfOp4rLB9Ih6WFlFCYJfgQWtSMeTjf5SQ3RJkjw9j3XDeGuCEM1goAlgePLg8ZyCgV4LEcDCBxEWYd3VI=
X-Received: by 2002:a9d:65c7:: with SMTP id z7mr825262oth.327.1603791335242;
 Tue, 27 Oct 2020 02:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com> <1600770019-11585-11-git-send-email-gene.chen.richtek@gmail.com>
In-Reply-To: <1600770019-11585-11-git-send-email-gene.chen.richtek@gmail.com>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 27 Oct 2020 17:35:23 +0800
Message-ID: <CAE+NS376SZdkaQTSJ_MRgrhpFr4VPHNWYc+r5QgWENfuPZ7-Uw@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] mfd: mt6360: Merge different sub-devices I2C read/write
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Reviewers,

    Does any comments about this patch v5 10/10?

Gene Chen <gene.chen.richtek@gmail.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8822=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:21=E5=AF=AB=E9=81=93=EF=BC=
=9A


>
> From: Gene Chen <gene_chen@richtek.com>
>
> Merge different sub-devices I2C read/write functions into one Regmap,
> because PMIC and LDO part need CRC bits for access protection.
>
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/Kconfig       |   1 +
>  drivers/mfd/mt6360-core.c | 224 ++++++++++++++++++++++++++++++++++++++--=
------
>  2 files changed, 190 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 33df083..1dfe446 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -913,6 +913,7 @@ config MFD_MT6360
>         select MFD_CORE
>         select REGMAP_I2C
>         select REGMAP_IRQ
> +       select CRC8
>         depends on I2C
>         help
>           Say Y here to enable MT6360 PMU/PMIC/LDO functional support.
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index 075b466..2ec9559 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -62,6 +62,18 @@ struct mt6360_ddata {
>
>  #define MT6360_CRC8_POLYNOMIAL         0x7
>
> +#define MT6360_CRC_I2C_ADDR_SIZE       1
> +#define MT6360_CRC_REG_ADDR_SIZE       1
> +/* prealloca read size =3D i2c device addr + i2c reg addr + val ... + cr=
c8 */
> +#define MT6360_ALLOC_READ_SIZE(_size)  (_size + 3)
> +/* prealloca write size =3D i2c device addr + i2c reg addr + val ... + c=
rc8 + dummy byte */
> +#define MT6360_ALLOC_WRITE_SIZE(_size) (_size + 4)
> +#define MT6360_CRC_PREDATA_OFFSET      (MT6360_CRC_I2C_ADDR_SIZE + MT636=
0_CRC_REG_ADDR_SIZE)
> +#define MT6360_CRC_CRC8_SIZE           1
> +#define MT6360_CRC_DUMMY_BYTE_SIZE     1
> +#define MT6360_REGMAP_REG_BYTE_SIZE    2
> +#define I2C_ADDR_XLATE_8BIT(_addr, _rw)        (((_addr & 0x7F) << 1) + =
_rw)
> +
>  /* reg 0 -> 0 ~ 7 */
>  #define MT6360_CHG_TREG_EVT            4
>  #define MT6360_CHG_AICR_EVT            5
> @@ -266,12 +278,6 @@ static const struct regmap_irq_chip mt6360_irq_chip =
=3D {
>         .use_ack =3D true,
>  };
>
> -static const struct regmap_config mt6360_pmu_regmap_config =3D {
> -       .reg_bits =3D 8,
> -       .val_bits =3D 8,
> -       .max_register =3D MT6360_PMU_MAXREG,
> -};
> -
>  static const struct resource mt6360_adc_resources[] =3D {
>         DEFINE_RES_IRQ_NAMED(MT6360_ADC_DONEI, "adc_donei"),
>  };
> @@ -334,7 +340,7 @@ static const struct mfd_cell mt6360_devs[] =3D {
>         OF_MFD_CELL("mt6360-led", mt6360_led_resources,
>                     NULL, 0, 0, "mediatek,mt6360-led"),
>         OF_MFD_CELL("mt6360-regulator", mt6360_regulator_resources,
> -                   NULL, 0, 0, "mediatek,mt6360-regulator"),
> +                   NULL, 0, 0, NULL),
>         OF_MFD_CELL("mt6360-tcpc", NULL,
>                     NULL, 0, 0, "mediatek,mt6360-tcpc"),
>  };
> @@ -349,7 +355,7 @@ static int mt6360_check_vendor_info(struct mt6360_dda=
ta *ddata)
>                 return ret;
>
>         if ((info & CHIP_VEN_MASK) !=3D CHIP_VEN_MT6360) {
> -               dev_err(&client->dev, "Device not supported\n");
> +               dev_err(ddata->dev, "Device not supported\n");
>                 return -ENODEV;
>         }
>
> @@ -358,11 +364,161 @@ static int mt6360_check_vendor_info(struct mt6360_=
ddata *ddata)
>         return 0;
>  }
>
> -static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] =3D {
> -       MT6360_PMU_SLAVEID,
> +static const unsigned short mt6360_slave_addrs[MT6360_SLAVE_MAX] =3D {
> +       MT6360_TCPC_SLAVEID,
>         MT6360_PMIC_SLAVEID,
>         MT6360_LDO_SLAVEID,
> -       MT6360_TCPC_SLAVEID,
> +       MT6360_PMU_SLAVEID,
> +};
> +
> +static int mt6360_xlate_pmicldo_addr(u8 *addr, int rw_size)
> +{
> +       /* Address is already in encoded [5:0] */
> +       *addr &=3D MT6360_ADDRESS_MASK;
> +
> +       switch (rw_size) {
> +       case 1:
> +               *addr |=3D MT6360_DATA_SIZE_1_BYTE;
> +               break;
> +       case 2:
> +               *addr |=3D MT6360_DATA_SIZE_2_BYTES;
> +               break;
> +       case 3:
> +               *addr |=3D MT6360_DATA_SIZE_3_BYTES;
> +               break;
> +       case 4:
> +               *addr |=3D MT6360_DATA_SIZE_4_BYTES;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int mt6360_regmap_read(void *context, const void *reg, size_t reg=
_size,
> +                             void *val, size_t val_size)
> +{
> +       struct mt6360_ddata *ddata =3D context;
> +       u8 bank =3D *(u8 *)reg;
> +       u8 reg_addr =3D *(u8 *)(reg + 1);
> +       struct i2c_client *i2c =3D ddata->i2c[bank];
> +       bool crc_needed =3D false;
> +       u8 *buf;
> +       int buf_len =3D MT6360_ALLOC_READ_SIZE(val_size);
> +       int read_size =3D val_size;
> +       u8 crc;
> +       int ret;
> +
> +       if (bank =3D=3D MT6360_SLAVE_PMIC || bank =3D=3D MT6360_SLAVE_LDO=
) {
> +               crc_needed =3D true;
> +               ret =3D mt6360_xlate_pmicldo_addr(&reg_addr, val_size);
> +               if (ret < 0)
> +                       return ret;
> +               read_size +=3D MT6360_CRC_CRC8_SIZE;
> +       }
> +
> +       buf =3D kzalloc(buf_len, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       buf[0] =3D I2C_ADDR_XLATE_8BIT(i2c->addr, I2C_SMBUS_READ);
> +       buf[1] =3D reg_addr;
> +
> +       ret =3D i2c_smbus_read_i2c_block_data(i2c, reg_addr, read_size,
> +                                           buf + MT6360_CRC_PREDATA_OFFS=
ET);
> +       if (ret < 0)
> +               goto out;
> +       else if (ret !=3D read_size) {
> +               ret =3D -EIO;
> +               goto out;
> +       }
> +
> +       if (crc_needed) {
> +               crc =3D crc8(ddata->crc8_tbl, buf, val_size + MT6360_CRC_=
PREDATA_OFFSET, 0);
> +               if (crc !=3D buf[val_size + MT6360_CRC_PREDATA_OFFSET]) {
> +                       ret =3D -EIO;
> +                       goto out;
> +               }
> +       }
> +
> +       memcpy(val, buf + MT6360_CRC_PREDATA_OFFSET, val_size);
> +out:
> +       kfree(buf);
> +       return (ret < 0) ? ret : 0;
> +}
> +
> +static int mt6360_regmap_write(void *context, const void *val, size_t va=
l_size)
> +{
> +       struct mt6360_ddata *ddata =3D context;
> +       u8 bank =3D *(u8 *)val;
> +       u8 reg_addr =3D *(u8 *)(val + 1);
> +       struct i2c_client *i2c =3D ddata->i2c[bank];
> +       bool crc_needed =3D false;
> +       u8 *buf;
> +       int buf_len =3D MT6360_ALLOC_WRITE_SIZE(val_size);
> +       int write_size =3D val_size - MT6360_REGMAP_REG_BYTE_SIZE;
> +       int ret;
> +
> +       if (bank =3D=3D MT6360_SLAVE_PMIC || bank =3D=3D MT6360_SLAVE_LDO=
) {
> +               crc_needed =3D true;
> +               ret =3D mt6360_xlate_pmicldo_addr(&reg_addr, val_size - M=
T6360_REGMAP_REG_BYTE_SIZE);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       buf =3D kzalloc(buf_len, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       buf[0] =3D I2C_ADDR_XLATE_8BIT(i2c->addr, I2C_SMBUS_WRITE);
> +       buf[1] =3D reg_addr;
> +       memcpy(buf + MT6360_CRC_PREDATA_OFFSET, val + MT6360_REGMAP_REG_B=
YTE_SIZE, write_size);
> +
> +       if (crc_needed) {
> +               buf[val_size] =3D crc8(ddata->crc8_tbl, buf, val_size, 0)=
;
> +               write_size +=3D (MT6360_CRC_CRC8_SIZE + MT6360_CRC_DUMMY_=
BYTE_SIZE);
> +       }
> +
> +       ret =3D i2c_smbus_write_i2c_block_data(i2c, reg_addr, write_size,
> +                                            buf + MT6360_CRC_PREDATA_OFF=
SET);
> +
> +       kfree(buf);
> +       return ret;
> +}
> +
> +static const struct regmap_bus mt6360_regmap_bus =3D {
> +       .read           =3D mt6360_regmap_read,
> +       .write          =3D mt6360_regmap_write,
> +
> +       /* Due to PMIC and LDO CRC access size limit */
> +       .max_raw_read   =3D 4,
> +       .max_raw_write  =3D 4,
> +};
> +
> +static bool mt6360_is_readwrite_reg(struct device *dev, unsigned int reg=
)
> +{
> +       switch (reg) {
> +       case MT6360_REG_TCPCSTART ... MT6360_REG_TCPCEND:
> +               fallthrough;
> +       case MT6360_REG_PMICSTART ... MT6360_REG_PMICEND:
> +               fallthrough;
> +       case MT6360_REG_LDOSTART ... MT6360_REG_LDOEND:
> +               fallthrough;
> +       case MT6360_REG_PMUSTART ... MT6360_REG_PMUEND:
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static const struct regmap_config mt6360_regmap_config =3D {
> +       .reg_bits               =3D 16,
> +       .val_bits               =3D 8,
> +       .reg_format_endian      =3D REGMAP_ENDIAN_BIG,
> +       .max_register           =3D MT6360_REG_PMUEND,
> +       .writeable_reg          =3D mt6360_is_readwrite_reg,
> +       .readable_reg           =3D mt6360_is_readwrite_reg,
>  };
>
>  static int mt6360_probe(struct i2c_client *client)
> @@ -375,9 +531,23 @@ static int mt6360_probe(struct i2c_client *client)
>                 return -ENOMEM;
>
>         ddata->dev =3D &client->dev;
> -       i2c_set_clientdata(client, ddata);
>
> -       ddata->regmap =3D devm_regmap_init_i2c(client, &mt6360_pmu_regmap=
_config);
> +       for (i =3D 0; i < MT6360_SLAVE_MAX - 1; i++) {
> +               ddata->i2c[i] =3D devm_i2c_new_dummy_device(&client->dev,
> +                                                         client->adapter=
,
> +                                                         mt6360_slave_ad=
drs[i]);
> +               if (IS_ERR(ddata->i2c[i])) {
> +                       dev_err(&client->dev,
> +                               "Failed to get new dummy I2C device for a=
ddress 0x%x",
> +                               mt6360_slave_addrs[i]);
> +                       return PTR_ERR(ddata->i2c[i]);
> +               }
> +       }
> +       ddata->i2c[MT6360_SLAVE_MAX - 1] =3D client;
> +
> +       crc8_populate_msb(ddata->crc8_tbl, MT6360_CRC8_POLYNOMIAL);
> +       ddata->regmap =3D devm_regmap_init(ddata->dev, &mt6360_regmap_bus=
, ddata,
> +                                        &mt6360_regmap_config);
>         if (IS_ERR(ddata->regmap)) {
>                 dev_err(&client->dev, "Failed to register regmap\n");
>                 return PTR_ERR(ddata->regmap);
> @@ -387,34 +557,18 @@ static int mt6360_probe(struct i2c_client *client)
>         if (ret)
>                 return ret;
>
> -       ret =3D devm_regmap_add_irq_chip(&client->dev, ddata->regmap, cli=
ent->irq,
> -                                      0, 0, &mt6360_irq_chip,
> -                                      &ddata->irq_data);
> +       ret =3D devm_regmap_add_irq_chip(&client->dev, ddata->regmap, cli=
ent->irq, 0, 0,
> +                                      &mt6360_irq_chip, &ddata->irq_data=
);
>         if (ret) {
>                 dev_err(&client->dev, "Failed to add Regmap IRQ Chip\n");
>                 return ret;
>         }
>
> -       ddata->i2c[0] =3D client;
> -       for (i =3D 1; i < MT6360_SLAVE_MAX; i++) {
> -               ddata->i2c[i] =3D devm_i2c_new_dummy_device(&client->dev,
> -                                                       client->adapter,
> -                                                       mt6360_slave_addr=
[i]);
> -               if (IS_ERR(ddata->i2c[i])) {
> -                       dev_err(&client->dev,
> -                               "Failed to get new dummy I2C device for a=
ddress 0x%x",
> -                               mt6360_slave_addr[i]);
> -                       return PTR_ERR(ddata->i2c[i]);
> -               }
> -               i2c_set_clientdata(ddata->i2c[i], ddata);
> -       }
> -
> -       ret =3D devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
> -                                  mt6360_devs, ARRAY_SIZE(mt6360_devs), =
NULL,
> -                                  0, regmap_irq_get_domain(ddata->irq_da=
ta));
> +       ret =3D devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO, m=
t6360_devs,
> +                                  ARRAY_SIZE(mt6360_devs), NULL, 0,
> +                                  regmap_irq_get_domain(ddata->irq_data)=
);
>         if (ret) {
> -               dev_err(&client->dev,
> -                       "Failed to register subordinate devices\n");
> +               dev_err(&client->dev, "Failed to register subordinate dev=
ices\n");
>                 return ret;
>         }
>
> --
> 2.7.4
>
