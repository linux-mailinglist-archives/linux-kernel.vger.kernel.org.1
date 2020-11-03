Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41092A381A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgKCA7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:59:42 -0500
Received: from vps.xff.cz ([195.181.215.36]:42022 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgKCA7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1604365180; bh=089NW4EV+AXNBn4l7uQ4zi2lQU+TDwonIKQk0SRKAwo=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=l7HTx+tFDkVGYaCEwtciREO4kDO2rHCpmGKPlaYwA36LoNIR1q4fRJaucFoOzUSBb
         nNXxfjyoXaFvImOW0E8zUBYguDjxJWr2JJ31dKzE5jwTt8pb8UeaVEveydNnCs5Ne4
         2y9aa66IBOesQDKnE/Gj90oWYN/xt2MfVAe+ZlTE=
Date:   Tue, 3 Nov 2020 01:59:39 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v1] regulator: defer probe when trying to get voltage
 from unresolved supply
Message-ID: <20201103005939.v563wbvbzks6ecjm@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <a9041d68b4d35e4a2dd71629c8a6422662acb5ee.1604351936.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9041d68b4d35e4a2dd71629c8a6422662acb5ee.1604351936.git.mirq-linux@rere.qmqm.pl>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal,

On Mon, Nov 02, 2020 at 10:27:27PM +0100, Michał Mirosław wrote:
> regulator_get_voltage_rdev() is called in regulator probe() when
> applying machine constraints.  The "fixed" commit exposed the problem
> that non-bypassed regulators can forward the request to its parent
> (like bypassed ones) supply. Return -EPROBE_DEFER when the supply
> is expected but not resolved yet.
> 

Tested-by: Ondřej Jirman <megous@megous.com>

thank you very much,
	Ondrej

> Fixes: aea6cb99703e ("regulator: resolve supply after creating regulator")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Reported-by: Ondřej Jirman <megous@megous.com>
> Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  v1: this is a bit different solution than the hack sent earlier. It should
>      be equivalent (putting the error code at the source), but please
>      test again.
> ---
>  drivers/regulator/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index a4ffd71696da..a5ad553da8cd 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -4165,6 +4165,8 @@ int regulator_get_voltage_rdev(struct regulator_dev *rdev)
>  		ret = rdev->desc->fixed_uV;
>  	} else if (rdev->supply) {
>  		ret = regulator_get_voltage_rdev(rdev->supply->rdev);
> +	} else if (rdev->supply_name) {
> +		return -EPROBE_DEFER;
>  	} else {
>  		return -EINVAL;
>  	}
> -- 
> 2.20.1
> 
