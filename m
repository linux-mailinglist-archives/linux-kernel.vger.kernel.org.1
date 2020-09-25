Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E227278C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 17:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgIYPLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 11:11:18 -0400
Received: from out28-145.mail.aliyun.com ([115.124.28.145]:47547 "EHLO
        out28-145.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbgIYPLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:11:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0448385-0.00253698-0.952625;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03273;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.IcA4rwc_1601046662;
Received: from 192.168.10.195(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IcA4rwc_1601046662)
          by smtp.aliyun-inc.com(10.147.42.22);
          Fri, 25 Sep 2020 23:11:03 +0800
Subject: Re: [PATCH v6 2/2] PHY: Ingenic: Add USB PHY driver using generic PHY
 framework.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     vkoul@kernel.org, kishon@ti.com, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
References: <20200923162600.44105-1-zhouyanjie@wanyeetech.com>
 <20200923162600.44105-3-zhouyanjie@wanyeetech.com>
 <ALG4HQ.B464DNP6PON2@crapouillou.net>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <cdbc5304-a272-c00f-0609-54a2de298cb8@wanyeetech.com>
Date:   Fri, 25 Sep 2020 23:10:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <ALG4HQ.B464DNP6PON2@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

在 2020/9/24 上午1:29, Paul Cercueil 写道:
> Hi Zhou,
>
> Le jeu. 24 sept. 2020 à 0:26, 周琰杰 (Zhou Yanjie) 
> <zhouyanjie@wanyeetech.com> a écrit :
>> Used the generic PHY framework API to create the PHY, this driver
>> supoorts USB OTG PHY used in JZ4770 SoC, JZ4780 SoC, X1000 SoC,
>> and X1830 SoC.
>>
>> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
>> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Co-developed-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
>> Signed-off-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
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
>>     v3->v4:
>>     Only add new generic-PHY driver, without removing the old one. 
>> Because the
>>     jz4740-musb driver is not ready to use the generic PHY framework. 
>> When the
>>     jz4740-musb driver is modified to use the generic PHY framework, 
>> the old
>>     jz4770-phy driver can be "retired".
>>
>>     v4->v5:
>>     1.Add an extra blank line between "devm_of_phy_provider_register" 
>> and "return".
>>     2.Remove unnecessary "phy_set_drvdata".
>>     3.Add Paul Cercueil's Reviewed-by.
>>
>>     v5->v6:
>>     1.Revert the removal of "phy_set_drvdata" in v5, removing 
>> "phy_set_drvdata" will
>>       cause a kernel panic on CI20.
>>       Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
>
> My bad, I overlooked the code of phy_set_drvdata(), indeed phy->dev 
> and pdev->dev are different. Sorry about that.
>
> With that said, you should then be able to remove the 
> platform_set_drvdata() call.
>

Sure.

>>     2.Rewrite the macro definitions, replace the original code with 
>> "FIELD_PREP()"
>>       and "u32p_replace_bits()" according to Vinod Koul's suggestion.
>>
>>  drivers/phy/Kconfig                   |   1 +
>>  drivers/phy/Makefile                  |   1 +
>>  drivers/phy/ingenic/Kconfig           |  12 ++
>>  drivers/phy/ingenic/Makefile          |   2 +
>>  drivers/phy/ingenic/phy-ingenic-usb.c | 378 
>> ++++++++++++++++++++++++++++++++++
>>  5 files changed, 394 insertions(+)
>>  create mode 100644 drivers/phy/ingenic/Kconfig
>>  create mode 100644 drivers/phy/ingenic/Makefile
>>  create mode 100644 drivers/phy/ingenic/phy-ingenic-usb.c
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
>> diff --git a/drivers/phy/ingenic/phy-ingenic-usb.c 
>> b/drivers/phy/ingenic/phy-ingenic-usb.c
>> new file mode 100644
>> index 000000000000..55da6ca8faf7
>> --- /dev/null
>> +++ b/drivers/phy/ingenic/phy-ingenic-usb.c
>> @@ -0,0 +1,378 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Ingenic SoCs USB PHY driver
>> + * Copyright (c) Paul Cercueil <paul@crapouillou.net>
>> + * Copyright (c) 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
>> + * Copyright (c) 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +/* OTGPHY register offsets */
>> +#define REG_USBPCR_OFFSET            0x00
>> +#define REG_USBRDT_OFFSET            0x04
>> +#define REG_USBVBFIL_OFFSET            0x08
>> +#define REG_USBPCR1_OFFSET            0x0c
>> +
>> +/* bits within the USBPCR register */
>> +#define USBPCR_USB_MODE                BIT(31)
>> +#define USBPCR_AVLD_REG                BIT(30)
>> +#define USBPCR_COMMONONN            BIT(25)
>> +#define USBPCR_VBUSVLDEXT            BIT(24)
>> +#define USBPCR_VBUSVLDEXTSEL        BIT(23)
>> +#define USBPCR_POR                    BIT(22)
>> +#define USBPCR_SIDDQ                BIT(21)
>> +#define USBPCR_OTG_DISABLE            BIT(20)
>> +#define USBPCR_TXPREEMPHTUNE        BIT(6)
>> +
>> +#define USBPCR_IDPULLUP_MASK        GENMASK(29, 28)
>> +#define USBPCR_IDPULLUP_ALWAYS        0x2
>> +#define USBPCR_IDPULLUP_SUSPEND        0x1
>> +#define USBPCR_IDPULLUP_OTG            0x0
>> +
>> +#define USBPCR_COMPDISTUNE_MASK        GENMASK(19, 17)
>> +#define USBPCR_COMPDISTUNE_DFT        0x4
>> +
>> +#define USBPCR_OTGTUNE_MASK            GENMASK(16, 14)
>> +#define USBPCR_OTGTUNE_DFT            0x4
>> +
>> +#define USBPCR_SQRXTUNE_MASK        GENMASK(13, 11)
>> +#define USBPCR_SQRXTUNE_DCR_20PCT    0x7
>> +#define USBPCR_SQRXTUNE_DFT            0x3
>> +
>> +#define USBPCR_TXFSLSTUNE_MASK        GENMASK(10, 7)
>> +#define USBPCR_TXFSLSTUNE_DCR_50PPT    0xf
>> +#define USBPCR_TXFSLSTUNE_DCR_25PPT    0x7
>> +#define USBPCR_TXFSLSTUNE_DFT        0x3
>> +#define USBPCR_TXFSLSTUNE_INC_25PPT    0x1
>> +#define USBPCR_TXFSLSTUNE_INC_50PPT    0x0
>> +
>> +#define USBPCR_TXHSXVTUNE_MASK        GENMASK(5, 4)
>> +#define USBPCR_TXHSXVTUNE_DFT        0x3
>> +#define USBPCR_TXHSXVTUNE_DCR_15MV    0x1
>> +
>> +#define USBPCR_TXRISETUNE_MASK        GENMASK(5, 4)
>> +#define USBPCR_TXRISETUNE_DFT        0x3
>> +
>> +#define USBPCR_TXVREFTUNE_MASK        GENMASK(3, 0)
>> +#define USBPCR_TXVREFTUNE_INC_25PPT    0x7
>> +#define USBPCR_TXVREFTUNE_DFT        0x5
>> +
>> +/* bits within the USBRDTR register */
>> +#define USBRDT_UTMI_RST                BIT(27)
>> +#define USBRDT_HB_MASK                BIT(26)
>> +#define USBRDT_VBFIL_LD_EN            BIT(25)
>> +#define USBRDT_IDDIG_EN                BIT(24)
>> +#define USBRDT_IDDIG_REG            BIT(23)
>> +#define USBRDT_VBFIL_EN                BIT(2)
>> +
>> +/* bits within the USBPCR1 register */
>> +#define USBPCR1_BVLD_REG            BIT(31)
>> +#define USBPCR1_DPPD                BIT(29)
>> +#define USBPCR1_DMPD                BIT(28)
>> +#define USBPCR1_USB_SEL                BIT(28)
>> +#define USBPCR1_WORD_IF_16BIT        BIT(19)
>> +
>> +enum ingenic_usb_phy_version {
>> +    ID_JZ4770,
>> +    ID_JZ4780,
>> +    ID_X1000,
>> +    ID_X1830,
>> +};
>> +
>> +struct ingenic_soc_info {
>> +    enum ingenic_usb_phy_version version;
>> +
>> +    void (*usb_phy_init)(struct phy *phy);
>> +};
>> +
>> +struct ingenic_usb_phy {
>> +    const struct ingenic_soc_info *soc_info;
>> +
>> +    struct phy *phy;
>> +    struct device *dev;
>> +    void __iomem *base;
>> +    struct clk *clk;
>> +    struct regulator *vcc_supply;
>> +};
>> +
>> +static int ingenic_usb_phy_init(struct phy *phy)
>> +{
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>> +    int err;
>> +    u32 reg;
>> +
>> +    err = clk_prepare_enable(priv->clk);
>> +    if (err) {
>> +        dev_err(priv->dev, "Unable to start clock: %d\n", err);
>> +        return err;
>> +    }
>> +
>> +    priv->soc_info->usb_phy_init(phy);
>> +
>> +    /* Wait for PHY to reset */
>> +    usleep_range(30, 300);
>> +    reg = readl(priv->base + REG_USBPCR_OFFSET);
>> +    writel(reg & ~USBPCR_POR, priv->base + REG_USBPCR_OFFSET);
>> +    usleep_range(300, 1000);
>> +
>> +    return 0;
>> +}
>> +
>> +static int ingenic_usb_phy_exit(struct phy *phy)
>> +{
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>> +
>> +    clk_disable_unprepare(priv->clk);
>> +    regulator_disable(priv->vcc_supply);
>> +
>> +    return 0;
>> +}
>> +
>> +static int ingenic_usb_phy_power_on(struct phy *phy)
>> +{
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>> +    int err;
>> +
>> +    err = regulator_enable(priv->vcc_supply);
>> +    if (err) {
>> +        dev_err(priv->dev, "Unable to enable VCC: %d\n", err);
>> +        return err;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int ingenic_usb_phy_power_off(struct phy *phy)
>> +{
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>> +
>> +    regulator_disable(priv->vcc_supply);
>> +
>> +    return 0;
>> +}
>> +
>> +static int ingenic_usb_phy_set_mode(struct phy *phy,
>> +                  enum phy_mode mode, int submode)
>> +{
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>> +    u32 reg;
>> +
>> +    switch (mode) {
>> +    case PHY_MODE_USB_HOST:
>> +        reg = readl(priv->base + REG_USBPCR_OFFSET);
>> +        u32p_replace_bits(&reg, 1, USBPCR_USB_MODE);
>> +        u32p_replace_bits(&reg, 0, USBPCR_VBUSVLDEXT);
>> +        u32p_replace_bits(&reg, 0, USBPCR_VBUSVLDEXTSEL);
>> +        u32p_replace_bits(&reg, 0, USBPCR_OTG_DISABLE);
>> +        writel(reg, priv->base + REG_USBPCR_OFFSET);
>> +
>> +        break;
>> +    case PHY_MODE_USB_DEVICE:
>> +        if (priv->soc_info->version >= ID_X1000) {
>> +            reg = readl(priv->base + REG_USBPCR1_OFFSET);
>> +            u32p_replace_bits(&reg, 1, USBPCR1_BVLD_REG);
>> +            writel(reg, priv->base + REG_USBPCR1_OFFSET);
>> +        }
>> +
>> +        reg = readl(priv->base + REG_USBPCR_OFFSET);
>> +        u32p_replace_bits(&reg, 0, USBPCR_USB_MODE);
>> +        u32p_replace_bits(&reg, 1, USBPCR_VBUSVLDEXT);
>> +        u32p_replace_bits(&reg, 1, USBPCR_VBUSVLDEXTSEL);
>> +        u32p_replace_bits(&reg, 1, USBPCR_OTG_DISABLE);
>> +        writel(reg, priv->base + REG_USBPCR_OFFSET);
>> +
>> +        break;
>> +    case PHY_MODE_USB_OTG:
>> +        reg = readl(priv->base + REG_USBPCR_OFFSET);
>> +        u32p_replace_bits(&reg, 1, USBPCR_USB_MODE);
>> +        u32p_replace_bits(&reg, 1, USBPCR_VBUSVLDEXT);
>> +        u32p_replace_bits(&reg, 1, USBPCR_VBUSVLDEXTSEL);
>> +        u32p_replace_bits(&reg, 0, USBPCR_OTG_DISABLE);
>> +        writel(reg, priv->base + REG_USBPCR_OFFSET);
>> +
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
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
>> +{
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>> +    u32 reg;
>> +
>> +    reg = USBPCR_AVLD_REG | USBPCR_COMMONONN | USBPCR_POR |
>> +        FIELD_PREP(USBPCR_IDPULLUP_MASK, USBPCR_IDPULLUP_ALWAYS) |
>> +        FIELD_PREP(USBPCR_COMPDISTUNE_MASK, USBPCR_COMPDISTUNE_DFT) |
>> +        FIELD_PREP(USBPCR_OTGTUNE_MASK, USBPCR_OTGTUNE_DFT) |
>> +        FIELD_PREP(USBPCR_SQRXTUNE_MASK, USBPCR_SQRXTUNE_DFT) |
>> +        FIELD_PREP(USBPCR_TXFSLSTUNE_MASK, USBPCR_TXFSLSTUNE_DFT) |
>> +        FIELD_PREP(USBPCR_TXRISETUNE_MASK, USBPCR_TXRISETUNE_DFT) |
>> +        FIELD_PREP(USBPCR_TXVREFTUNE_MASK, USBPCR_TXVREFTUNE_DFT);
>> +    writel(reg, priv->base + REG_USBPCR_OFFSET);
>> +}
>> +
>> +static void jz4780_usb_phy_init(struct phy *phy)
>> +{
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>> +    u32 reg;
>> +
>> +    reg = readl(priv->base + REG_USBPCR1_OFFSET) | USBPCR1_USB_SEL |
>> +        USBPCR1_WORD_IF_16BIT;
>> +    writel(reg, priv->base + REG_USBPCR1_OFFSET);
>> +
>> +    reg = USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
>> +    writel(reg, priv->base + REG_USBPCR_OFFSET);
>> +}
>> +
>> +static void x1000_usb_phy_init(struct phy *phy)
>> +{
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>> +    u32 reg;
>> +
>> +    reg = readl(priv->base + REG_USBPCR1_OFFSET) | 
>> USBPCR1_WORD_IF_16BIT;
>> +    writel(reg, priv->base + REG_USBPCR1_OFFSET);
>> +
>> +    reg = USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR |
>> +        FIELD_PREP(USBPCR_SQRXTUNE_MASK, USBPCR_SQRXTUNE_DCR_20PCT) |
>> +        FIELD_PREP(USBPCR_TXHSXVTUNE_MASK, 
>> USBPCR_TXHSXVTUNE_DCR_15MV) |
>> +        FIELD_PREP(USBPCR_TXVREFTUNE_MASK, 
>> USBPCR_TXVREFTUNE_INC_25PPT);
>> +    writel(reg, priv->base + REG_USBPCR_OFFSET);
>> +}
>> +
>> +static void x1830_usb_phy_init(struct phy *phy)
>> +{
>> +    struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>> +    u32 reg;
>> +
>> +    /* rdt */
>> +    writel(USBRDT_VBFIL_EN | USBRDT_UTMI_RST, priv->base + 
>> REG_USBRDT_OFFSET);
>> +
>> +    reg = readl(priv->base + REG_USBPCR1_OFFSET) | 
>> USBPCR1_WORD_IF_16BIT |
>> +        USBPCR1_DMPD | USBPCR1_DPPD;
>> +    writel(reg, priv->base + REG_USBPCR1_OFFSET);
>> +
>> +    reg = USBPCR_VBUSVLDEXT |    USBPCR_TXPREEMPHTUNE | 
>> USBPCR_COMMONONN | USBPCR_POR |
>
> There's a stray tab character here.
>

I will fix this in v7.

>> +        FIELD_PREP(USBPCR_IDPULLUP_MASK, USBPCR_IDPULLUP_OTG);
>> +    writel(reg, priv->base + REG_USBPCR_OFFSET);
>> +}
>> +
>> +static const struct ingenic_soc_info jz4770_soc_info = {
>> +    .version = ID_JZ4770,
>> +
>> +    .usb_phy_init = jz4770_usb_phy_init,
>> +};
>> +
>> +static const struct ingenic_soc_info jz4780_soc_info = {
>> +    .version = ID_JZ4780,
>> +
>> +    .usb_phy_init = jz4780_usb_phy_init,
>> +};
>> +
>> +static const struct ingenic_soc_info x1000_soc_info = {
>> +    .version = ID_X1000,
>> +
>> +    .usb_phy_init = x1000_usb_phy_init,
>> +};
>> +
>> +static const struct ingenic_soc_info x1830_soc_info = {
>> +    .version = ID_X1830,
>> +
>> +    .usb_phy_init = x1830_usb_phy_init,
>> +};
>> +
>> +static int ingenic_usb_phy_probe(struct platform_device *pdev)
>> +{
>> +    struct ingenic_usb_phy *priv;
>> +    struct phy_provider *provider;
>> +    struct device *dev = &pdev->dev;
>> +    int err;
>> +
>> +    priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +    if (!priv)
>> +        return -ENOMEM;
>> +
>> +    priv->soc_info = device_get_match_data(dev);
>> +    if (!priv->soc_info) {
>> +        dev_err(dev, "Error: No device match found\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    platform_set_drvdata(pdev, priv);
>
> You should be able to remove the platform_set_drvdata() here. Not the 
> phy_set_drvdata() ;)
>

Sure.

>> +    priv->dev = dev;
>
> You may also remove the "dev" field in your priv structure, and use 
> &phy->dev instead, from what I can see it's only used in your 
> dev_err() calls. Not a deal-breaker though, I'm fine with both.
>

Sure.

>> +
>> +    priv->base = devm_platform_ioremap_resource(pdev, 0);
>> +    if (IS_ERR(priv->base)) {
>> +        dev_err(dev, "Failed to map registers\n");
>> +        return PTR_ERR(priv->base);
>> +    }
>> +
>> +    priv->clk = devm_clk_get(dev, NULL);
>> +    if (IS_ERR(priv->clk)) {
>> +        err = PTR_ERR(priv->clk);
>> +        if (err != -EPROBE_DEFER)
>> +            dev_err(dev, "Failed to get clock\n");
>> +        return err;
>
> You can do:
>
> if (IS_ERR(priv->clk))
>    return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get 
> clock\n");
>
> if Vinod is okay with that (I know some maintainers don't like it).
>

Sure, if Vinod feel it is okay, I will make changes in v7.

Thanks and best regards!

>> +    }
>> +
>> +    priv->vcc_supply = devm_regulator_get(dev, "vcc");
>> +    if (IS_ERR(priv->vcc_supply)) {
>> +        err = PTR_ERR(priv->vcc_supply);
>> +        if (err != -EPROBE_DEFER)
>> +            dev_err(dev, "Failed to get regulator\n");
>> +        return err;
>
> Same here.
>
> These are nitpicks though and I'm happy with the V6 being merged.
>
> Cheers,
> -Paul
>
>> +    }
>> +
>> +    priv->phy = devm_phy_create(dev, NULL, &ingenic_usb_phy_ops);
>> +    if (IS_ERR(priv))
>> +        return PTR_ERR(priv);
>> +
>> +    phy_set_drvdata(priv->phy, priv);
>> +
>> +    provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +
>> +    return PTR_ERR_OR_ZERO(provider);
>> +}
>> +
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
>> +    .driver        = {
>> +        .name    = "ingenic-usb-phy",
>> +        .of_match_table = ingenic_usb_phy_of_matches,
>> +    },
>> +};
>> +module_platform_driver(ingenic_usb_phy_driver);
>> +
>> +MODULE_AUTHOR("周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>");
>> +MODULE_AUTHOR("漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>");
>> +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
>> +MODULE_DESCRIPTION("Ingenic SoCs USB PHY driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.11.0
>>
>
