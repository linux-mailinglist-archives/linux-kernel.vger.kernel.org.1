Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82B2A2AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgKBMtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgKBMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:49:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1374CC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 04:49:01 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kZZGa-0001Yb-0n; Mon, 02 Nov 2020 13:48:56 +0100
Subject: Re: [BUG] Error applying setting, reverse things back on lot of
 devices
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     lgirdwood@gmail.com, mripard@kernel.org,
        linux-kernel@vger.kernel.org, wens@csie.org, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20201021183149.GA8436@Red> <20201023134201.GA533@Red>
 <20201023203943.GA21435@Red> <20201024115307.GA2745@qmqm.qmqm.pl>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <8a580d12-fa4a-6cd8-4d82-3e3b784e348b@pengutronix.de>
Date:   Mon, 2 Nov 2020 13:48:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201024115307.GA2745@qmqm.qmqm.pl>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Micha³,

CC += linux-stm32

On 10/24/20 1:53 PM, Micha³ Miros³aw wrote:
> On Fri, Oct 23, 2020 at 10:39:43PM +0200, Corentin Labbe wrote:
>> On Fri, Oct 23, 2020 at 03:42:01PM +0200, Corentin Labbe wrote:
>>> On Wed, Oct 21, 2020 at 08:31:49PM +0200, Corentin Labbe wrote:
>>> I have just saw thoses 3 lines which are probably the real problem.
>>> I have started a new bisect with this error, but it is hitting the same "crash range" the first one.
>>>
>>
>> I have bisected the problem to commit aea6cb99703e17019e025aa71643b4d3e0a24413 ("regulator: resolve supply after creating regulator")
>> Reverting this fix my problem.

The change broke boot on all the STM32MP1 boards, because the STPMIC driver
has a vref_ddr regulator, which does not have a dedicated supply, but without
a vref_ddr-supply property the system now no longer boots.

> Can you try the hack below?
> 
> Best Regards,
> Micha³ Miros³aw
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index a4ffd71696da..9ad091f5f1ab 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -1169,6 +1169,9 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
>  		}
>  
>  		if (current_uV < 0) {
> +			if (current_uV == -EINVAL && rdev->supply_name)
> +				return -EPROBE_DEFER;
> +

This doesn't fix the issue for the STM32MP1 boards (tested on LXA MC-1).
Seeing that the patch is already in stable, I think this patch should be
reverted until the issues are solved in Linus' master.

Cheers,
Ahmad


>  			rdev_err(rdev,
>  				 "failed to get the current voltage: %pe\n",
>  				 ERR_PTR(current_uV));
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
