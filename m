Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D79B2AD3C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgKJK2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730164AbgKJK17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:27:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625DDC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:27:59 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kcQsX-0000Gu-S8; Tue, 10 Nov 2020 11:27:57 +0100
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: stm32: add simple-mfd compatible
 for tamp node
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Christophe Roullier <christophe.roullier@st.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20201021102855.18026-1-a.fatoum@pengutronix.de>
 <20201026143656.GA118160@bogus>
 <23e423ba-25f2-c3ed-ea65-2c2d86ae9522@pengutronix.de>
 <CAL_JsqL8sjw1o6PzCSRM9FtRx7XLDQg2bWXxo4Yw5t6fnroudw@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <20d5ccf8-c98f-fe3c-767b-1ad99be9dd19@pengutronix.de>
Date:   Tue, 10 Nov 2020 11:27:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL8sjw1o6PzCSRM9FtRx7XLDQg2bWXxo4Yw5t6fnroudw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alex,

On 10/27/20 1:15 PM, Rob Herring wrote:
> On Mon, Oct 26, 2020 at 4:30 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>
>> Hello Rob,
>>
>> On 10/26/20 3:36 PM, Rob Herring wrote:
>>> On Wed, Oct 21, 2020 at 12:28:55PM +0200, Ahmad Fatoum wrote:
>>>> The stm32mp1 TAMP (Tamper and backup registers) does tamper detection
>>>> and features 32 backup registers that, being in the RTC domain, may
>>>> survive even with Vdd switched off.
>>>>
>>>> This makes it suitable for use to communicate a reboot mode from OS
>>>> to bootloader via the syscon-reboot-mode binding. Add a "simple-mfd"
>>>> to support probing such a child node. The actual reboot mode
>>>> node could then be defined in a board.dts or fixed up by the bootloader.
>>>
>>> 'simple-mfd' implies there is no dependency on the parent node for the
>>> child (such as the regmap perhaps). Is that the case here?
>>
>> No, there's a dependency and the Linux driver does syscon_node_to_regmap
>> on the device tree node's parent but that's how the syscon-reboot-mode binding
>> is documented:
>>
>>   The SYSCON mapped register is retrieved from the
>>   parental dt-node plus the offset. So the SYSCON reboot-mode node
>>   should be represented as a sub-node of a "syscon", "simple-mfd" node.
>>
>> How would you prefer this being done instead?
> 
> Well, probably the syscon driver could just probe any children, but
> I'm not sure if that would break anyone. So I guess fine as-is.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Gentle ping.

> 
> Rob
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
