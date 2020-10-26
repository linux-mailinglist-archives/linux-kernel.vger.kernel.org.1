Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5902998C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 22:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbgJZVaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 17:30:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36391 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733222AbgJZVaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:30:21 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kXA4J-00088d-AK; Mon, 26 Oct 2020 22:30:19 +0100
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: stm32: add simple-mfd compatible
 for tamp node
To:     Rob Herring <robh@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Christophe Roullier <christophe.roullier@st.com>,
        kernel@pengutronix.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201021102855.18026-1-a.fatoum@pengutronix.de>
 <20201026143656.GA118160@bogus>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <23e423ba-25f2-c3ed-ea65-2c2d86ae9522@pengutronix.de>
Date:   Mon, 26 Oct 2020 22:30:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026143656.GA118160@bogus>
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

Hello Rob,

On 10/26/20 3:36 PM, Rob Herring wrote:
> On Wed, Oct 21, 2020 at 12:28:55PM +0200, Ahmad Fatoum wrote:
>> The stm32mp1 TAMP (Tamper and backup registers) does tamper detection
>> and features 32 backup registers that, being in the RTC domain, may
>> survive even with Vdd switched off.
>>
>> This makes it suitable for use to communicate a reboot mode from OS
>> to bootloader via the syscon-reboot-mode binding. Add a "simple-mfd"
>> to support probing such a child node. The actual reboot mode
>> node could then be defined in a board.dts or fixed up by the bootloader.
> 
> 'simple-mfd' implies there is no dependency on the parent node for the 
> child (such as the regmap perhaps). Is that the case here?

No, there's a dependency and the Linux driver does syscon_node_to_regmap
on the device tree node's parent but that's how the syscon-reboot-mode binding
is documented:

  The SYSCON mapped register is retrieved from the
  parental dt-node plus the offset. So the SYSCON reboot-mode node
  should be represented as a sub-node of a "syscon", "simple-mfd" node.

How would you prefer this being done instead?

Cheers,
Ahmad

> 
>>
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> ---
>> v1 available here:
>> https://lore.kernel.org/linux-arm-kernel/20200916142216.25142-1-a.fatoum@pengutronix.de/
>>
>> v1 -> v2:
>>  - new patch, rebased on top of
>>    https://lore.kernel.org/r/20201014125441.2457-1-arnaud.pouliquen@st.com
>> ---
>>  .../devicetree/bindings/arm/stm32/st,stm32-syscon.yaml       | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
>> index 6634b3e0853e..4684017a42e4 100644
>> --- a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
>> +++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
>> @@ -19,8 +19,11 @@ properties:
>>                - st,stm32mp151-pwr-mcu
>>                - st,stm32-syscfg
>>                - st,stm32-power-config
>> -              - st,stm32-tamp
>>            - const: syscon
>> +      - items:
>> +          - const: st,stm32-tamp
>> +          - const: syscon
>> +          - const: simple-mfd
>>  
>>    reg:
>>      maxItems: 1
>> -- 
>> 2.28.0
>>
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
