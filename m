Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAD92B19FD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgKMLXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgKMLW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:22:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61633C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:22:56 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kdXAL-0000Qs-Cn; Fri, 13 Nov 2020 12:22:53 +0100
Subject: Re: [PATCH RESEND 0/4] regulator: debugging and fixing supply deps
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
References: <cover.1605226675.git.mirq-linux@rere.qmqm.pl>
 <0cb181b3-d257-b7a4-56e4-0d2bb04b0387@pengutronix.de>
Message-ID: <49aaa901-041d-e803-2ec5-167d8bb6372f@pengutronix.de>
Date:   Fri, 13 Nov 2020 12:22:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <0cb181b3-d257-b7a4-56e4-0d2bb04b0387@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC += linux-stm32 as other STM32MP1 boards are also affected.

On 11/13/20 12:19 PM, Ahmad Fatoum wrote:
> Hello Michał,
> 
> On 11/13/20 1:20 AM, Michał Mirosław wrote:
>> It turns out that commit aea6cb99703e ("regulator: resolve supply
>> after creating regulator") exposed a number of issues in regulator
>> initialization and introduced a memory leak of its own. One uncovered
>> problem was already fixed by cf1ad559a20d ("regulator: defer probe when
>> trying to get voltage from unresolved supply"). This series fixes the
>> remaining ones and adds a two debugging aids to help in the future.
>>
>> The final patch adds a workaround to preexisting problem occurring with
>> regulators that have the same name as its supply_name. This worked
>> before by accident, so might be worth backporting. The error message is
>> left on purpose so that these configurations can be detected and fixed.
>>
>> (The first two patches are resends from Nov 5).
>>
>> (Series resent because of wrong arm-kernel ML address.)
> 
> lxa-mc1 (STM32MP1 board with STPMIC) now manages to boot again with following
> new warning:
> 
>   stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Supply for VREF_DDR
> 
> So for the whole series,
> Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de> # stpmic1
> 
> Thanks!
> Ahmad
> 
>>
>> Michał Mirosław (4):
>>   regulator: fix memory leak with repeated set_machine_constraints()
>>   regulator: debug early supply resolving
>>   regulator: avoid resolve_supply() infinite recursion
>>   regulator: workaround self-referent regulators
>>
>>  drivers/regulator/core.c | 40 ++++++++++++++++++++++++----------------
>>  1 file changed, 24 insertions(+), 16 deletions(-)
>>
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
