Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81DE2A28C5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgKBLKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgKBLKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:10:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9201C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:10:21 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kZXjA-00056c-EY; Mon, 02 Nov 2020 12:10:20 +0100
Subject: Re: [Linux-stm32] [PATCH v7 10/12] ARM: dts: stm32: Fix schema
 warnings for pwm-leds
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alexander Dahl <ada@thorsis.com>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        hardware@linux-automation.com
References: <20201005203451.9985-1-post@lespocky.de>
 <20201005203451.9985-11-post@lespocky.de>
 <b387bda8-3643-1d27-4996-2aa4dc94d69f@pengutronix.de>
 <20201027100536.cpfizc67gwrolp2z@falbala.internal.home.lespocky.de>
 <f6ed201d-51b6-f278-7a95-3e3e49dc19ee@pengutronix.de>
 <20201031135408.lgpiy5goa7l4cg2k@falbala.internal.home.lespocky.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <786c297d-d3c5-4a5c-ffc1-f6a8af1b7758@pengutronix.de>
Date:   Mon, 2 Nov 2020 12:10:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201031135408.lgpiy5goa7l4cg2k@falbala.internal.home.lespocky.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 10/31/20 2:54 PM, Alexander Dahl wrote:
> Hei hei,
> 
> On Tue, Oct 27, 2020 at 11:58:10AM +0100, Ahmad Fatoum wrote:
>> Hello,
>>
>> On 10/27/20 11:05 AM, Alexander Dahl wrote:
>>> Hello Ahmad,
>>>
>>> thanks for your feedback, comments below.
>>>
>>
>>>>> -	led-rgb {
>>>>> +	led-controller-2 {
>>>>
>>>> Is a single RGB LED really a controller?
>>>
>>> I just followed the recommendations by Rob here.
>>
>> Do you happen to know if the new multicolor LED support could be used here?
>>
>> I find it unfortunate that the device tree loses information relevant to humans
>> to adhere to a fixed nomenclature. Apparently led-controller isn't even codified
>> in the YAML binding (It's just in the examples). If you respin, please add a
>> comment that this is a single RGB led. I'd prefer to keep the information
>> in the DTB as well though.
> 
> Slightly off-topic, but while I was working on the patch based on your
> feedback I tried to find some information on that Linux Automation
> MC-1 board.  However I could not find any? Is there some website, some
> datasheet or maybe a schematic online?  The vendor prefix says "Linux
> Automation GmbH", but I find only that USB-SD-Mux on their page?
Besides the test automation gadgets, Linux Automation offers engineering services
("Design for mainline"; custom design with off-the-shelf components well-supported
by mainline Linux) and the MC-1 was the Embedded World fair demonstrator for the
concept.

There is a blog post[0], a BSP[1] and even a Youtube video[2] on it,
but as the MC-1 itself is not what's being sold, there is no technical documentation
of the HW publicly available.

If you got any questions regarding the device tree though, just send me an email. :-)

[0]: https://www.pengutronix.de/en/software/distrokit.html
[1]: https://www.pengutronix.de/de/blog/2020-02-26-embedded_world_2020.html
[2]: https://www.youtube.com/watch?v=qs0ljuH3ZkQ

Cheers,
Ahmad


> 
> Greets
> Alex
> 
>>
>>
>>
>>>
>>>>>  		compatible = "pwm-leds";
>>>>>  
>>>>> -		led-red {
>>>>> +		led-2 {
>>>>
>>>> Shouldn't this have been led-1 as well or is the numbering "global" ?
>>>
>>> Also good question. This numbering is for dts only, it usually does
>>> not correspond with LEDs on the board, so it could be numbered per
>>> led-controller as well?
>>
>> I'd prefer that it starts by 1. That way it's aligned with PWM channel
>> ID.
>>
>> Thanks for fixing the dtschema warnings by the way!
>>
>> Cheers,
>> Ahmad
>>
>>>
>>> Greets
>>> Alex
>>>
>>>>
>>>>>  			label = "mc1:red:rgb";
>>>>>  			pwms = <&leds_pwm 1 1000000 0>;
>>>>>  			max-brightness = <255>;
>>>>>  			active-low;
>>>>>  		};
>>>>>  
>>>>> -		led-green {
>>>>> +		led-3 {
>>>>>  			label = "mc1:green:rgb";
>>>>>  			pwms = <&leds_pwm 2 1000000 0>;
>>>>>  			max-brightness = <255>;
>>>>>  			active-low;
>>>>>  		};
>>>>>  
>>>>> -		led-blue {
>>>>> +		led-4 {
>>>>>  			label = "mc1:blue:rgb";
>>>>>  			pwms = <&leds_pwm 3 1000000 0>;
>>>>>  			max-brightness = <255>;
>>>>>
>>>>
>>>> -- 
>>>> Pengutronix e.K.                           |                             |
>>>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>>>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>>>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>>>
>>
>> -- 
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
