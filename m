Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2538526CC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgIPUqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:46:12 -0400
Received: from out28-75.mail.aliyun.com ([115.124.28.75]:56297 "EHLO
        out28-75.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgIPRCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:02:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0609419-0.0391797-0.899878;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.IXz.H1c_1600273661;
Received: from 192.168.10.195(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IXz.H1c_1600273661)
          by smtp.aliyun-inc.com(10.147.41.158);
          Thu, 17 Sep 2020 00:27:42 +0800
Subject: Re: [PATCH v3 2/2] USB: PHY: JZ4770: Use the generic PHY framework.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com,
        vkoul@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
References: <20200913063430.9622-1-zhouyanjie@wanyeetech.com>
 <20200913063430.9622-3-zhouyanjie@wanyeetech.com>
 <EY1QGQ.TFKG10DQWSQP@crapouillou.net>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <9e5c8a6d-0e9e-7124-a3a6-b09a46717bf0@wanyeetech.com>
Date:   Thu, 17 Sep 2020 00:27:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <EY1QGQ.TFKG10DQWSQP@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

在 2020/9/16 上午6:47, Paul Cercueil 写道:
> Hi Zhou,
>
> Le dim. 13 sept. 2020 à 14:34, 周琰杰 (Zhou Yanjie) 
> <zhouyanjie@wanyeetech.com> a écrit :
>> Used the generic PHY framework API to create the PHY,
>> and move the driver to driver/phy/ingenic. And adjust
>> the position of some codes to make it consistent with
>> the style of other USB PHY drivers.
>>
>> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
>> Co-developed-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
>> Signed-off-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> ---
>>
>> Notes:
>>     v1->v2:
>>     Fix bug, ".of_match_table = 
>> of_match_ptr(ingenic_usb_phy_of_matches)" is wrong
>>     and should be replaced with ".of_match_table = 
>> ingenic_usb_phy_of_matches".
>>
>>     v2->v3:
>>     1.Change "depends on (MACH_INGENIC && MIPS) || COMPILE_TEST" to
>>       "depends on MIPS || COMPILE_TEST".
>>     2.Keep the adjustments of "ingenic_usb_phy_init()" and 
>> "ingenic_usb_phu_exit()"
>>       positions in v2 to make them consistent with the order in 
>> "ingenic_usb_phy_ops",
>>       keep the adjustments to the positions of 
>> "ingenic_usb_phy_of_matches[]" in v2
>>       to keep them consistent with the styles of other USB PHY 
>> drivers. And remove
>>       some unnecessary changes to reduce the diff size, from the 
>> original 256 lines
>>       change to the current 209 lines.
>>
>>  drivers/phy/Kconfig                                |   1 +
>>  drivers/phy/Makefile                               |   1 +
>>  drivers/phy/ingenic/Kconfig                        |  12 ++
>>  drivers/phy/ingenic/Makefile                       |   2 +
>>  .../phy-jz4770.c => phy/ingenic/phy-ingenic-usb.c} | 209 
>> +++++++++++----------
>>  drivers/usb/phy/Kconfig                            |   8 -
>>  drivers/usb/phy/Makefile                           |   1 -
>>  7 files changed, 128 insertions(+), 106 deletions(-)
>>  create mode 100644 drivers/phy/ingenic/Kconfig
>>  create mode 100644 drivers/phy/ingenic/Makefile
>>  rename drivers/{usb/phy/phy-jz4770.c => 
>> phy/ingenic/phy-ingenic-usb.c} (71%)
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index de9362c25c07..0534b0fdd057 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -55,6 +55,7 @@ source "drivers/phy/broadcom/Kconfig"
>>  source "drivers/phy/cadence/Kconfig"
>>  source "drivers/phy/freescale/Kconfig"
>>  source "drivers/phy/hisilicon/Kconfig"
>> +source "drivers/phy/ingenic/Kconfig"
>>  source "drivers/phy/lantiq/Kconfig"
>>  source "drivers/phy/marvell/Kconfig"
>>  source "drivers/phy/mediatek/Kconfig"
>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>> index c27408e4daae..ab24f0d20763 100644
>> --- a/drivers/phy/Makefile
>> +++ b/drivers/phy/Makefile
>> @@ -14,6 +14,7 @@ obj-y                    += allwinner/    \
>>                         cadence/    \
>>                         freescale/    \
>>                         hisilicon/    \
>> +                       ingenic/    \
>>                         intel/    \
>>                         lantiq/    \
>>                         marvell/    \
>> diff --git a/drivers/phy/ingenic/Kconfig b/drivers/phy/ingenic/Kconfig
>> new file mode 100644
>> index 000000000000..912b14e512cb
>> --- /dev/null
>> +++ b/drivers/phy/ingenic/Kconfig
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Phy drivers for Ingenic platforms
>> +#
>> +config PHY_INGENIC_USB
>> +    tristate "Ingenic SoCs USB PHY Driver"
>> +    depends on MIPS || COMPILE_TEST
>> +    depends on USB_SUPPORT
>> +    select GENERIC_PHY
>> +    help
>> +      This driver provides USB PHY support for the USB controller found
>> +      on the JZ-series and X-series SoCs from Ingenic.
>> diff --git a/drivers/phy/ingenic/Makefile b/drivers/phy/ingenic/Makefile
>> new file mode 100644
>> index 000000000000..65d5ea00fc9d
>> --- /dev/null
>> +++ b/drivers/phy/ingenic/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-y        += phy-ingenic-usb.o
>> diff --git a/drivers/usb/phy/phy-jz4770.c 
>> b/drivers/phy/ingenic/phy-ingenic-usb.c
>> similarity index 71%
>> rename from drivers/usb/phy/phy-jz4770.c
>> rename to drivers/phy/ingenic/phy-ingenic-usb.c
>> index 4025da20b3fd..1f2e811c9125 100644
>> --- a/drivers/usb/phy/phy-jz4770.c
>> +++ b/drivers/phy/ingenic/phy-ingenic-usb.c
>> @@ -7,12 +7,12 @@
>>   */
>>
>>  #include <linux/clk.h>
>> +#include <linux/delay.h>
>>  #include <linux/io.h>
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/regulator/consumer.h>
>> -#include <linux/usb/otg.h>
>> -#include <linux/usb/phy.h>
>> +#include <linux/phy/phy.h>
>>
>>  /* OTGPHY register offsets */
>>  #define REG_USBPCR_OFFSET            0x00
>> @@ -97,68 +97,56 @@ enum ingenic_usb_phy_version {
>>  struct ingenic_soc_info {
>>      enum ingenic_usb_phy_version version;
>>
>> -    void (*usb_phy_init)(struct usb_phy *phy);
>> +    void (*usb_phy_init)(struct phy *phy);
>>  };
>>
>> -struct jz4770_phy {
>> +struct ingenic_usb_phy {
>>      const struct ingenic_soc_info *soc_info;
>>
>> -    struct usb_phy phy;
>> -    struct usb_otg otg;
>> +    struct phy *phy;
>>      struct device *dev;
>>      void __iomem *base;
>>      struct clk *clk;
>>      struct regulator *vcc_supply;
>>  };
>>
>> -static inline struct jz4770_phy *otg_to_jz4770_phy(struct usb_otg *otg)
>> +static int ingenic_usb_phy_init(struct phy *phy)
>>  {
>> -    return container_of(otg, struct jz4770_phy, otg);
>> -}
>> -
>> -static inline struct jz4770_phy *phy_to_jz4770_phy(struct usb_phy *phy)
>> -{
>> -    return container_of(phy, struct jz4770_phy, phy);
>> -}
>> -
>> -static int ingenic_usb_phy_set_peripheral(struct usb_otg *otg,
>> -                     struct usb_gadget *gadget)
>> -{
>> -    struct jz4770_phy *priv = otg_to_jz4770_phy(otg);
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>> +    int err;
>>      u32 reg;
>>
>> -    if (priv->soc_info->version >= ID_X1000) {
>> -        reg = readl(priv->base + REG_USBPCR1_OFFSET);
>> -        reg |= USBPCR1_BVLD_REG;
>> -        writel(reg, priv->base + REG_USBPCR1_OFFSET);
>> +    err = clk_prepare_enable(priv->clk);
>> +    if (err) {
>> +        dev_err(priv->dev, "Unable to start clock: %d\n", err);
>> +        return err;
>>      }
>>
>> +    priv->soc_info->usb_phy_init(phy);
>> +
>> +    /* Wait for PHY to reset */
>> +    usleep_range(30, 300);
>>      reg = readl(priv->base + REG_USBPCR_OFFSET);
>> -    reg &= ~USBPCR_USB_MODE;
>> -    reg |= USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | 
>> USBPCR_OTG_DISABLE;
>> -    writel(reg, priv->base + REG_USBPCR_OFFSET);
>> +    writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
>> +    usleep_range(300, 1000);
>>
>>      return 0;
>>  }
>>
>> -static int ingenic_usb_phy_set_host(struct usb_otg *otg, struct 
>> usb_bus *host)
>> +static int ingenic_usb_phy_exit(struct phy *phy)
>>  {
>> -    struct jz4770_phy *priv = otg_to_jz4770_phy(otg);
>> -    u32 reg;
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>>
>> -    reg = readl(priv->base + REG_USBPCR_OFFSET);
>> -    reg &= ~(USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | 
>> USBPCR_OTG_DISABLE);
>> -    reg |= USBPCR_USB_MODE;
>> -    writel(reg, priv->base + REG_USBPCR_OFFSET);
>> +    clk_disable_unprepare(priv->clk);
>> +    regulator_disable(priv->vcc_supply);
>>
>>      return 0;
>>  }
>
> That part is still messy. You remove ingenic_usb_phy_set_peripheral() 
> and ingenic_usb_phy_set_host(), then add ingenic_usb_phy_init() and 
> ingenic_usb_phy_exit(). Why were the two first functions removed? Just 
> keep these around, and call them from ingenic_usb_phy_set_mode(). That 
> will automatically make the diff much smaller.
>
> And by making the diff smaller, we can spot the actual differences. 
> Like how support for PHY_MODE_USB_OTG was added, without any notice.
>

Indeed, after following your suggestion, the diff can be reduced a lot. 
I was too entangled in trying to be consistent with the order and style 
in orther phy drivers. :(

>>
>> -static int ingenic_usb_phy_init(struct usb_phy *phy)
>> +static int ingenic_usb_phy_power_on(struct phy *phy)
>>  {
>> -    struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>>      int err;
>> -    u32 reg;
>>
>>      err = regulator_enable(priv->vcc_supply);
>>      if (err) {
>> @@ -166,39 +154,71 @@ static int ingenic_usb_phy_init(struct usb_phy 
>> *phy)
>>          return err;
>>      }
>>
>> -    err = clk_prepare_enable(priv->clk);
>> -    if (err) {
>> -        dev_err(priv->dev, "Unable to start clock: %d\n", err);
>> -        return err;
>> -    }
>> -
>> -    priv->soc_info->usb_phy_init(phy);
>> -
>> -    /* Wait for PHY to reset */
>> -    usleep_range(30, 300);
>> -    reg = readl(priv->base + REG_USBPCR_OFFSET);
>> -    writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
>> -    usleep_range(300, 1000);
>> -
>>      return 0;
>>  }
>>
>> -static void ingenic_usb_phy_shutdown(struct usb_phy *phy)
>> +static int ingenic_usb_phy_power_off(struct phy *phy)
>>  {
>> -    struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>>
>> -    clk_disable_unprepare(priv->clk);
>>      regulator_disable(priv->vcc_supply);
>> +
>> +    return 0;
>>  }
>>
>> -static void ingenic_usb_phy_remove(void *phy)
>> +static int ingenic_usb_phy_set_mode(struct phy *phy,
>> +                  enum phy_mode mode, int submode)
>>  {
>> -    usb_remove_phy(phy);
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>> +    u32 reg;
>> +
>> +    switch (mode) {
>> +    case PHY_MODE_USB_HOST:
>> +        reg = readl(priv->base + REG_USBPCR_OFFSET);
>> +        reg &= ~(USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | 
>> USBPCR_OTG_DISABLE);
>> +        reg |= USBPCR_USB_MODE;
>> +        writel(reg, priv->base + REG_USBPCR_OFFSET);
>> +
>> +        break;
>> +    case PHY_MODE_USB_DEVICE:
>> +        if (priv->soc_info->version >= ID_X1000) {
>> +            reg = readl(priv->base + REG_USBPCR1_OFFSET);
>> +            reg |= USBPCR1_BVLD_REG;
>> +            writel(reg, priv->base + REG_USBPCR1_OFFSET);
>> +        }
>> +
>> +        reg = readl(priv->base + REG_USBPCR_OFFSET);
>> +        reg &= ~USBPCR_USB_MODE;
>> +        reg |= USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | 
>> USBPCR_OTG_DISABLE;
>> +        writel(reg, priv->base + REG_USBPCR_OFFSET);
>> +
>> +        break;
>> +    case PHY_MODE_USB_OTG:
>> +        reg = readl(priv->base + REG_USBPCR_OFFSET);
>> +        reg &= ~USBPCR_OTG_DISABLE;
>> +        reg |= USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | 
>> USBPCR_USB_MODE;
>> +        writel(reg, priv->base + REG_USBPCR_OFFSET);
>> +
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>>  }
>>
>> -static void jz4770_usb_phy_init(struct usb_phy *phy)
>> +static const struct phy_ops ingenic_usb_phy_ops = {
>> +    .init        = ingenic_usb_phy_init,
>> +    .exit        = ingenic_usb_phy_exit,
>> +    .power_on    = ingenic_usb_phy_power_on,
>> +    .power_off    = ingenic_usb_phy_power_off,
>> +    .set_mode    = ingenic_usb_phy_set_mode,
>> +    .owner        = THIS_MODULE,
>> +};
>> +
>> +static void jz4770_usb_phy_init(struct phy *phy)
>>  {
>> -    struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>>      u32 reg;
>>
>>      reg = USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_IDPULLUP_ALWAYS |
>> @@ -208,9 +228,9 @@ static void jz4770_usb_phy_init(struct usb_phy *phy)
>>      writel(reg, priv->base + REG_USBPCR_OFFSET);
>>  }
>>
>> -static void jz4780_usb_phy_init(struct usb_phy *phy)
>> +static void jz4780_usb_phy_init(struct phy *phy)
>>  {
>> -    struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>>      u32 reg;
>>
>>      reg = readl(priv->base + REG_USBPCR1_OFFSET) | USBPCR1_USB_SEL |
>> @@ -221,9 +241,9 @@ static void jz4780_usb_phy_init(struct usb_phy *phy)
>>      writel(reg, priv->base + REG_USBPCR_OFFSET);
>>  }
>>
>> -static void x1000_usb_phy_init(struct usb_phy *phy)
>> +static void x1000_usb_phy_init(struct phy *phy)
>>  {
>> -    struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>>      u32 reg;
>>
>>      reg = readl(priv->base + REG_USBPCR1_OFFSET) | 
>> USBPCR1_WORD_IF_16BIT;
>> @@ -235,9 +255,9 @@ static void x1000_usb_phy_init(struct usb_phy *phy)
>>      writel(reg, priv->base + REG_USBPCR_OFFSET);
>>  }
>>
>> -static void x1830_usb_phy_init(struct usb_phy *phy)
>> +static void x1830_usb_phy_init(struct phy *phy)
>>  {
>> -    struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>>      u32 reg;
>>
>>      /* rdt */
>> @@ -276,43 +296,25 @@ static const struct ingenic_soc_info 
>> x1830_soc_info = {
>>      .usb_phy_init = x1830_usb_phy_init,
>>  };
>>
>> -static const struct of_device_id ingenic_usb_phy_of_matches[] = {
>> -    { .compatible = "ingenic,jz4770-phy", .data = &jz4770_soc_info },
>> -    { .compatible = "ingenic,jz4780-phy", .data = &jz4780_soc_info },
>> -    { .compatible = "ingenic,x1000-phy", .data = &x1000_soc_info },
>> -    { .compatible = "ingenic,x1830-phy", .data = &x1830_soc_info },
>> -    { /* sentinel */ }
>> -};
>> -MODULE_DEVICE_TABLE(of, ingenic_usb_phy_of_matches);
>
> Why move that array?
>

This is the same as before, too entangled in keeping consistent with the 
order in other phy drivers :(

>> -
>> -static int jz4770_phy_probe(struct platform_device *pdev)
>> +static int ingenic_usb_phy_probe(struct platform_device *pdev)
>>  {
>> +    struct ingenic_usb_phy *priv;
>> +    struct phy_provider *provider;
>>      struct device *dev = &pdev->dev;
>> -    struct jz4770_phy *priv;
>>      int err;
>>
>>      priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>      if (!priv)
>>          return -ENOMEM;
>>
>> -    priv->soc_info = device_get_match_data(&pdev->dev);
>> +    priv->soc_info = device_get_match_data(dev);
>>      if (!priv->soc_info) {
>> -        dev_err(&pdev->dev, "Error: No device match found\n");
>> +        dev_err(dev, "Error: No device match found\n");
>>          return -ENODEV;
>>      }
>>
>>      platform_set_drvdata(pdev, priv);
>>      priv->dev = dev;
>> -    priv->phy.dev = dev;
>> -    priv->phy.otg = &priv->otg;
>> -    priv->phy.label = "ingenic-usb-phy";
>> -    priv->phy.init = ingenic_usb_phy_init;
>> -    priv->phy.shutdown = ingenic_usb_phy_shutdown;
>> -
>> -    priv->otg.state = OTG_STATE_UNDEFINED;
>> -    priv->otg.usb_phy = &priv->phy;
>> -    priv->otg.set_host = ingenic_usb_phy_set_host;
>> -    priv->otg.set_peripheral = ingenic_usb_phy_set_peripheral;
>>
>>      priv->base = devm_platform_ioremap_resource(pdev, 0);
>>      if (IS_ERR(priv->base)) {
>> @@ -336,27 +338,40 @@ static int jz4770_phy_probe(struct 
>> platform_device *pdev)
>>          return err;
>>      }
>>
>> -    err = usb_add_phy(&priv->phy, USB_PHY_TYPE_USB2);
>> -    if (err) {
>> -        if (err != -EPROBE_DEFER)
>> -            dev_err(dev, "Unable to register PHY\n");
>> -        return err;
>> -    }
>> +    priv->phy = devm_phy_create(priv->dev, NULL, &ingenic_usb_phy_ops);
>
> You can use 'dev' directly.
>

Sure.

>> +    if (IS_ERR(priv))
>> +        return PTR_ERR(priv);
>> +
>> +    phy_set_drvdata(priv->phy, priv);
>>
>> -    return devm_add_action_or_reset(dev, ingenic_usb_phy_remove, 
>> &priv->phy);
>> +    provider = devm_of_phy_provider_register(priv->dev, 
>> of_phy_simple_xlate);
>> +    if (IS_ERR(provider))
>> +        return PTR_ERR(provider);
>> +
>> +    return 0;
>
> return demv_of_phy_provider_register(dev, ...)
>

Sure.

>>  }
>>
>> -static struct platform_driver ingenic_phy_driver = {
>> -    .probe        = jz4770_phy_probe,
>> +static const struct of_device_id ingenic_usb_phy_of_matches[] = {
>> +    { .compatible = "ingenic,jz4770-phy", .data = &jz4770_soc_info },
>> +    { .compatible = "ingenic,jz4780-phy", .data = &jz4780_soc_info },
>> +    { .compatible = "ingenic,x1000-phy", .data = &x1000_soc_info },
>> +    { .compatible = "ingenic,x1830-phy", .data = &x1830_soc_info },
>> +    { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, ingenic_usb_phy_of_matches);
>> +
>> +static struct platform_driver ingenic_usb_phy_driver = {
>> +    .probe        = ingenic_usb_phy_probe,
>>      .driver        = {
>> -        .name    = "jz4770-phy",
>> +        .name    = "ingenic-usb-phy",
>>          .of_match_table = ingenic_usb_phy_of_matches,
>>      },
>>  };
>> -module_platform_driver(ingenic_phy_driver);
>> +module_platform_driver(ingenic_usb_phy_driver);
>>
>>  MODULE_AUTHOR("周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>");
>>  MODULE_AUTHOR("漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>");
>>  MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
>>  MODULE_DESCRIPTION("Ingenic SoCs USB PHY driver");
>> +MODULE_ALIAS("jz4770-phy");
>
> So I first thought this generic PHY driver would be a drop-in 
> replacement for the old jz4770-phy driver, that's why I suggested to 
> add the jz4770-phy alias. But it turns out that it's a completely 
> different framework, so we can drop the alias.
>
> That also means that this patch, without any change to the JZ4740 MUSB 
> driver, breaks USB on all Ingenic SoCs I can test with.
>
> So unless you have a patch to the jz4740-musb driver in this series, 
> you can't remove the old jz4770-phy driver yet. Just modify this patch 
> so that the new generic-PHY driver is added, without removing the old 
> one. It will be much easier to review (one new driver vs lots of +/- 
> lines) and you can move the code around if you want to. Then when the 
> jz4740-musb driver is modified to use the generic PHY framework, the 
> old jz4770-phy driver can be "retired".
>

Sure, this also just solves the problem of order and style that I 
entangled before.

Thanks and best regards!

> Cheers,
> -Paul
>
>>  MODULE_LICENSE("GPL");
>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>> index ef4787cd3d37..ff24fca0a2d9 100644
>> --- a/drivers/usb/phy/Kconfig
>> +++ b/drivers/usb/phy/Kconfig
>> @@ -184,12 +184,4 @@ config USB_ULPI_VIEWPORT
>>        Provides read/write operations to the ULPI phy register set for
>>        controllers with a viewport register (e.g. Chipidea/ARC 
>> controllers).
>>
>> -config JZ4770_PHY
>> -    tristate "Ingenic SoCs Transceiver Driver"
>> -    depends on MIPS || COMPILE_TEST
>> -    select USB_PHY
>> -    help
>> -      This driver provides PHY support for the USB controller found
>> -      on the JZ-series and X-series SoCs from Ingenic.
>> -
>>  endmenu
>> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
>> index b352bdbe8712..df1d99010079 100644
>> --- a/drivers/usb/phy/Makefile
>> +++ b/drivers/usb/phy/Makefile
>> @@ -24,4 +24,3 @@ obj-$(CONFIG_USB_MXS_PHY)        += phy-mxs-usb.o
>>  obj-$(CONFIG_USB_ULPI)            += phy-ulpi.o
>>  obj-$(CONFIG_USB_ULPI_VIEWPORT)        += phy-ulpi-viewport.o
>>  obj-$(CONFIG_KEYSTONE_USB_PHY)        += phy-keystone.o
>> -obj-$(CONFIG_JZ4770_PHY)        += phy-jz4770.o
>> -- 
>> 2.11.0
>>
>
