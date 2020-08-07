Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A91A23EFFA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 17:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgHGPZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 11:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGPZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:25:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D35C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 08:25:12 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1k44F4-0007jd-Se; Fri, 07 Aug 2020 17:25:10 +0200
Subject: Re: [PATCH] ARM: dts: stm32: lxa-mc1: Fix kernel warning about PHY
 delays
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Holger Assmann <h.assmann@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200807150355.6116-1-h.assmann@pengutronix.de>
 <83fb8c55-7ea6-8212-9e67-30e24d14faa6@pengutronix.de>
Message-ID: <4ad3919e-46da-4fd5-d297-a696d96eb0b7@pengutronix.de>
Date:   Fri, 7 Aug 2020 17:25:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <83fb8c55-7ea6-8212-9e67-30e24d14faa6@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/20 5:24 PM, Ahmad Fatoum wrote:
> On 8/7/20 5:03 PM, Holger Assmann wrote:
>> The KSZ9031 PHY skew timings for rxc/txc, originally set to achieve
>> the desired phase shift between clock- and data-signal, now trigger a
>> kernel warning when used in rgmii-id mode:
>>
>>  *-skew-ps values should be used only with phy-mode = "rgmii"
>>
>> This is because commit bcf3440c6dd7 ("net: phy: micrel: add phy-mode
>> support for the KSZ9031 PHY") now configures own timings when
>> phy-mode = "rgmii-id". Device trees wanting to set their own delays
>> should use phy-mode "rgmii" instead as the warning prescribes.
>>
>> The "standard" timings now used with "rgmii-id" work fine on this
>> board, so drop the explicit timings in the device tree and thereby
>> silence the warning.
>>
>> Fixes: 666b5ca85cd3 ("ARM: dts: stm32: add STM32MP1-based Linux Automation MC-1 board")
>> Signed-off-by: Holger Assmann <h.assmann@pengutronix.de>
> 
> Acked-by: Ahmad Fatoum <a.fatoum@pengutronic.de>

Typo Correction: Acked-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

:-)

> 
>> ---
>>  arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
>> index 5700e6b700d3..b85025d00943 100644
>> --- a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
>> +++ b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
>> @@ -121,8 +121,6 @@
>>  			reset-gpios = <&gpiog 0 GPIO_ACTIVE_LOW>; /* ETH_RST# */
>>  			interrupt-parent = <&gpioa>;
>>  			interrupts = <6 IRQ_TYPE_EDGE_FALLING>; /* ETH_MDINT# */
>> -			rxc-skew-ps = <1860>;
>> -			txc-skew-ps = <1860>;
>>  			reset-assert-us = <10000>;
>>  			reset-deassert-us = <300>;
>>  			micrel,force-master;
>>
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
