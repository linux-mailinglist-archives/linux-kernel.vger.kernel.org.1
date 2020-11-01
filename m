Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718FE2A1B9C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 02:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgKABbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 21:31:17 -0400
Received: from vps.xff.cz ([195.181.215.36]:56900 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgKABbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 21:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1604194275; bh=H89e9NhotYsOSduIL8y0NwGbsc/k6/4q0Jhr0fSLbcU=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=Ve3/ooPOfdl4wiiwYvtMny/B8moovnRmooTBHvPGD5lFAC8U5zQMQVMxkwZfAINij
         G1TA0T9G7FD6PHgbn5PapVLg9z9+hZ5cE0ztF583YQ422UyNTWBa1tZsZy9e29XjSJ
         IQkOkPmE8aGNFGDPPILw8LZFvcukPf0adtJL/OQs=
Date:   Sun, 1 Nov 2020 02:31:15 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>, mripard@kernel.org,
        wens@csie.org, broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [BUG] Error applying setting, reverse things back on lot of
 devices
Message-ID: <20201101013115.espxyxbnqgj3j4tg@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Corentin Labbe <clabbe.montjoie@gmail.com>, mripard@kernel.org,
        wens@csie.org, broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20201021183149.GA8436@Red>
 <20201023134201.GA533@Red>
 <20201023203943.GA21435@Red>
 <20201024115307.GA2745@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201024115307.GA2745@qmqm.qmqm.pl>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michał,

On Sat, Oct 24, 2020 at 01:53:07PM +0200, Michał Mirosław wrote:
> On Fri, Oct 23, 2020 at 10:39:43PM +0200, Corentin Labbe wrote:
> > On Fri, Oct 23, 2020 at 03:42:01PM +0200, Corentin Labbe wrote:
> > > On Wed, Oct 21, 2020 at 08:31:49PM +0200, Corentin Labbe wrote:
> > > > [    5.796585] dcdc4: supplied by regulator-dummy
> > > > [    5.801647] vcc-dram: supplied by regulator-dummy
> > > > [    5.806470] vcc-gmac-phy: failed to get the current voltage: -EINVAL
> > > > [    5.812839] axp20x-regulator axp20x-regulator: Failed to register dc1sw
> > > > [    5.820291] axp20x-regulator: probe of axp20x-regulator failed with error -22
> > > 
> > > I have just saw thoses 3 lines which are probably the real problem.
> > > I have started a new bisect with this error, but it is hitting the same "crash range" the first one.
> > > 
> > 
> > I have bisected the problem to commit aea6cb99703e17019e025aa71643b4d3e0a24413 ("regulator: resolve supply after creating regulator")
> > Reverting this fix my problem.
> 
> Can you try the hack below?
> 
> Best Regards,
> Michał Mirosław
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
>  			rdev_err(rdev,
>  				 "failed to get the current voltage: %pe\n",
>  				 ERR_PTR(current_uV));

I did hit the same problem on sun8i-a83t-tbs-a711.dts tablet.

The patch helps on top of v5.9.2, and on linus/master.

regards,
	o.
