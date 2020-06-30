Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EFB20F493
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 14:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbgF3M0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 08:26:49 -0400
Received: from out28-171.mail.aliyun.com ([115.124.28.171]:57286 "EHLO
        out28-171.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730689AbgF3M0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:26:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.759732-0.00248346-0.237784;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03297;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HvD2QLd_1593520001;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HvD2QLd_1593520001)
          by smtp.aliyun-inc.com(10.147.40.7);
          Tue, 30 Jun 2020 20:26:42 +0800
Subject: Re: [PATCH 2/2] clk: X1000: Add support for calculat REFCLK of USB
 PHY.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
References: <20200626164844.25436-1-zhouyanjie@wanyeetech.com>
 <20200626164844.25436-3-zhouyanjie@wanyeetech.com>
 <AKNJCQ.6UUHR0DBDE8E2@crapouillou.net>
 <b0a3a0b0-4ae8-3905-8d0c-50e44511fa95@wanyeetech.com>
 <IEBNCQ.EWU8F7SNWRJK2@crapouillou.net>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <3b5bb36a-964f-3d12-08cf-f094c593cd2b@wanyeetech.com>
Date:   Tue, 30 Jun 2020 20:26:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <IEBNCQ.EWU8F7SNWRJK2@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

在 2020/6/29 上午1:03, Paul Cercueil 写道:
> Hi Zhou,
>
> Le lun. 29 juin 2020 à 0:18, Zhou Yanjie <zhouyanjie@wanyeetech.com> a 
> écrit :
>> Hi Paul,
>>
>> 在 2020/6/27 上午1:36, Paul Cercueil 写道:
>>> Hi Zhou,
>>>
>>> Le sam. 27 juin 2020 à 0:48, 周琰杰 (Zhou Yanjie) 
>>> <zhouyanjie@wanyeetech.com> a écrit :
>>>> Add new functions to "x1000_otg_phy_ops" to calculat the rate of 
>>>> REFCLK,
>>>> which is needed by USB PHY in the Ingenic X1000 SoC.
>>>>
>>>> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
>>>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>>>> ---
>>>>  drivers/clk/ingenic/x1000-cgu.c | 113 
>>>> ++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 113 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/ingenic/x1000-cgu.c 
>>>> b/drivers/clk/ingenic/x1000-cgu.c
>>>> index 453f3323cb99..a61c16f98a11 100644
>>>> --- a/drivers/clk/ingenic/x1000-cgu.c
>>>> +++ b/drivers/clk/ingenic/x1000-cgu.c
>>>> @@ -48,8 +48,114 @@
>>>>  #define USBPCR_SIDDQ        BIT(21)
>>>>  #define USBPCR_OTG_DISABLE    BIT(20)
>>>>
>>>> +/* bits within the USBPCR1 register */
>>>> +#define USBPCR1_REFCLKSEL_SHIFT    26
>>>> +#define USBPCR1_REFCLKSEL_MASK    (0x3 << USBPCR1_REFCLKSEL_SHIFT)
>>>> +#define USBPCR1_REFCLKSEL_CORE    (0x2 << USBPCR1_REFCLKSEL_SHIFT)
>>>> +#define USBPCR1_REFCLKDIV_SHIFT    24
>>>> +#define USBPCR1_REFCLKDIV_MASK    (0x3 << USBPCR1_REFCLKDIV_SHIFT)
>>>> +#define USBPCR1_REFCLKDIV_48    (0x2 << USBPCR1_REFCLKDIV_SHIFT)
>>>> +#define USBPCR1_REFCLKDIV_24    (0x1 << USBPCR1_REFCLKDIV_SHIFT)
>>>> +#define USBPCR1_REFCLKDIV_12    (0x0 << USBPCR1_REFCLKDIV_SHIFT)
>>>> +
>>>>  static struct ingenic_cgu *cgu;
>>>>
>>>> +static u8 x1000_otg_phy_get_parent(struct clk_hw *hw)
>>>> +{
>>>> +    /* we only use CLKCORE, revisit if that ever changes */
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int x1000_otg_phy_set_parent(struct clk_hw *hw, u8 idx)
>>>> +{
>>>> +    unsigned long flags;
>>>> +    u32 usbpcr1;
>>>> +
>>>> +    if (idx > 0)
>>>> +        return -EINVAL;
>>>> +
>>>> +    spin_lock_irqsave(&cgu->lock, flags);
>>>> +
>>>> +    usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
>>>> +    usbpcr1 &= ~USBPCR1_REFCLKSEL_MASK;
>>>> +    /* we only use CLKCORE */
>>>> +    usbpcr1 |= USBPCR1_REFCLKSEL_CORE;
>>>> +    writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
>>>> +
>>>> +    spin_unlock_irqrestore(&cgu->lock, flags);
>>>> +    return 0;
>>>> +}
>>>
>>> If you only support one parent, maybe set that bit in the 
>>> x1000_cgu_init(), then you can drop the get_parent/set_parent.
>>>
>>
>> Sure.
>>
>>
>>>> +
>>>> +static unsigned long x1000_otg_phy_recalc_rate(struct clk_hw *hw,
>>>> +                        unsigned long parent_rate)
>>>> +{
>>>> +    u32 usbpcr1;
>>>> +    unsigned refclk_div;
>>>> +
>>>> +    usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
>>>> +    refclk_div = usbpcr1 & USBPCR1_REFCLKDIV_MASK;
>>>> +
>>>> +    switch (refclk_div) {
>>>> +    case USBPCR1_REFCLKDIV_12:
>>>> +        return 12000000;
>>>> +
>>>> +    case USBPCR1_REFCLKDIV_24:
>>>> +        return 24000000;
>>>> +
>>>> +    case USBPCR1_REFCLKDIV_48:
>>>> +        return 48000000;
>>>> +    }
>>>
>>> On your setup, what frequency is configured for the "otg" clock? Is 
>>> it 48 MHz?
>>>
>>> I believe CLKCORE is the OTG core's clock (aka "otg"), and I'm 
>>> pretty sure that these fields only represent CLKCORE/4, CLKCORE/2, 
>>> CLKCORE/1, but the doc expects CLKCORE==48MHz.
>>>
>>
>> This is the REFCLKDIV in USBPCR1 reg, it's for the usb phy, so it is 
>> not the otg clock. In X1000 and X1500 it is 24MHz, in JZ4780 it is 
>> 48MHz.
>
> I know it is for the OTG PHY clock, what I'm saying is that the OTG 
> PHY clock is derived from CLKCORE which I believe is the "otg" clock. 
> Unless the clock represents a crystal, it is derived from another 
> clock, and as a result the clock rate should be computed from the 
> parent clock rate.
>

In the current Ingenic SoCs I have in hand, only JZ4780/X1000/X1500 has 
this REFCLKDIV.

At present, the relevant drivers in X1000 are written with reference to 
the drivers in jz4780-cgu.c ( the author is Paul Burton ). I have 
already tested on X1000 and JZ4780 today, the driver is effective and 
can be configured by setting assigned-clock-rates in DT ( 48000000 for 
JZ4780, 24000000 for X1000 and X1500 ).

Thanks and best regards!


> -Paul
>
>>
>>> In that case the "otg_phy" should be parented to "otg", and the rate 
>>> should be computed according to the parent rate and the divider 
>>> configured.
>>>
>>>> +
>>>> +    BUG();
>>>
>>> Don't use BUG() - it pisses off Linus :)
>>> And it's reserved for bugs that will take the whole system down, I 
>>> think. Better use WARN().
>>>
>>
>> Sure, I will change it in the next version.
>>
>> Thanks and best regards!
>>
>>
>>> Cheers,
>>> -Paul
>>>
>>>> +    return parent_rate;
>>>> +}
>>>> +
>>>> +static long x1000_otg_phy_round_rate(struct clk_hw *hw, unsigned 
>>>> long req_rate,
>>>> +                      unsigned long *parent_rate)
>>>> +{
>>>> +    if (req_rate < 18000000)
>>>> +        return 12000000;
>>>> +
>>>> +    if (req_rate < 36000000)
>>>> +        return 24000000;
>>>> +
>>>> +    return 48000000;
>>>> +}
>>>> +
>>>> +static int x1000_otg_phy_set_rate(struct clk_hw *hw, unsigned long 
>>>> req_rate,
>>>> +                   unsigned long parent_rate)
>>>> +{
>>>> +    unsigned long flags;
>>>> +    u32 usbpcr1, div_bits;
>>>> +
>>>> +    switch (req_rate) {
>>>> +    case 12000000:
>>>> +        div_bits = USBPCR1_REFCLKDIV_12;
>>>> +        break;
>>>> +
>>>> +    case 24000000:
>>>> +        div_bits = USBPCR1_REFCLKDIV_24;
>>>> +        break;
>>>> +
>>>> +    case 48000000:
>>>> +        div_bits = USBPCR1_REFCLKDIV_48;
>>>> +        break;
>>>> +
>>>> +    default:
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    spin_lock_irqsave(&cgu->lock, flags);
>>>> +
>>>> +    usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
>>>> +    usbpcr1 &= ~USBPCR1_REFCLKDIV_MASK;
>>>> +    usbpcr1 |= div_bits;
>>>> +    writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
>>>> +
>>>> +    spin_unlock_irqrestore(&cgu->lock, flags);
>>>> +    return 0;
>>>> +}
>>>> +
>>>>  static int x1000_usb_phy_enable(struct clk_hw *hw)
>>>>  {
>>>>      void __iomem *reg_opcr        = cgu->base + CGU_REG_OPCR;
>>>> @@ -80,6 +186,13 @@ static int x1000_usb_phy_is_enabled(struct 
>>>> clk_hw *hw)
>>>>  }
>>>>
>>>>  static const struct clk_ops x1000_otg_phy_ops = {
>>>> +    .get_parent = x1000_otg_phy_get_parent,
>>>> +    .set_parent = x1000_otg_phy_set_parent,
>>>> +
>>>> +    .recalc_rate = x1000_otg_phy_recalc_rate,
>>>> +    .round_rate = x1000_otg_phy_round_rate,
>>>> +    .set_rate = x1000_otg_phy_set_rate,
>>>> +
>>>>      .enable        = x1000_usb_phy_enable,
>>>>      .disable    = x1000_usb_phy_disable,
>>>>      .is_enabled    = x1000_usb_phy_is_enabled,
>>>> -- 
>>>> 2.11.0
>>>>
>>>
>
