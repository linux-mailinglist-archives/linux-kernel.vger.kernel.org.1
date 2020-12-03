Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8282C2CE091
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgLCVWo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Dec 2020 16:22:44 -0500
Received: from piie.net ([80.82.223.85]:57382 "EHLO piie.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbgLCVWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:22:44 -0500
Received: from mail.piie.net (_gateway [172.17.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        by piie.net (Postfix) with ESMTPSA id 970A22A18F0;
        Thu,  3 Dec 2020 22:22:02 +0100 (CET)
MIME-Version: 1.0
Date:   Thu, 03 Dec 2020 21:22:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: RainLoop/1.14.0
From:   "=?utf-8?B?UGV0ZXIgS8Okc3RsZQ==?=" <peter@piie.net>
Message-ID: <92e330ff28a10b1fb92d91c083fa3cac@piie.net>
Subject: Re: [PATCH v2 2/2] platform/x86/drivers/acerhdf: Check the
 interval value when it is set
To:     "Daniel Lezcano" <daniel.lezcano@linaro.org>, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201203071738.2363701-2-daniel.lezcano@linaro.org>
References: <20201203071738.2363701-2-daniel.lezcano@linaro.org>
 <20201203071738.2363701-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3. Dezember 2020 08:17, "Daniel Lezcano" <daniel.lezcano@linaro.org> schrieb:

> Currently the code checks the interval value when the temperature is
> read which is bad for two reasons:
> 
> - checking and setting the interval in the get_temp callback is
> inaccurate and awful, that can be done when changing the value.
> 
> - Changing the thermal zone structure internals is an abuse of the
> exported structure, moreover no lock is taken here.
> 
> The goal of this patch is to solve the first item by using the 'set'
> function called when changing the interval. The check is done there
> and removed from the get_temp function. If the thermal zone was not
> initialized yet, the interval is not updated in this case as that will
> happen in the init function when registering the thermal zone device.

Thanks for your effort.  This improves the code, good finding.

 
> I don't have any hardware to test the changes.

Tests successfully executed on my good old AOA110.


> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Peter Kaestle <peter@piie.net>


> ---
> V2:
> - Fixed static function annotation
> ---
> drivers/platform/x86/acerhdf.c | 22 ++++++++++++++++++----
> 1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index 19fc8ff2225c..b6aa6e5514f4 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -334,7 +334,10 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
> }
> if (verbose)
> pr_notice("interval changed to: %d\n", interval);
> - thermal->polling_delay = interval*1000;
> +
> + if (thermal)
> + thermal->polling_delay = interval*1000;
> +
> prev_interval = interval;
> }
> }
> @@ -349,8 +352,6 @@ static int acerhdf_get_ec_temp(struct thermal_zone_device *thermal, int *t)
> {
> int temp, err = 0;
> 
> - acerhdf_check_param(thermal);
> -
> err = acerhdf_get_temp(&temp);
> if (err)
> return err;
> @@ -823,8 +824,21 @@ MODULE_ALIAS("dmi:*:*Acer*:pnExtensa*5420*:");
> module_init(acerhdf_init);
> module_exit(acerhdf_exit);
> 
> +static int interval_set_uint(const char *val, const struct kernel_param *kp)
> +{
> + int ret;
> +
> + ret = param_set_uint(val, kp);
> + if (ret)
> + return ret;
> +
> + acerhdf_check_param(thz_dev);
> +
> + return 0;
> +}
> +
> static const struct kernel_param_ops interval_ops = {
> - .set = param_set_uint,
> + .set = interval_set_uint,
> .get = param_get_uint,
> };
> 
> -- 
> 2.25.1
