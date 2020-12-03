Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC962CE078
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgLCVSl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Dec 2020 16:18:41 -0500
Received: from piie.net ([80.82.223.85]:57192 "EHLO piie.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLCVSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:18:40 -0500
Received: from mail.piie.net (_gateway [172.17.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        by piie.net (Postfix) with ESMTPSA id 967AB2A18F0;
        Thu,  3 Dec 2020 22:17:58 +0100 (CET)
MIME-Version: 1.0
Date:   Thu, 03 Dec 2020 21:17:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: RainLoop/1.14.0
From:   "=?utf-8?B?UGV0ZXIgS8Okc3RsZQ==?=" <peter@piie.net>
Message-ID: <973e8be431d60986e8257320d9acf997@piie.net>
Subject: Re: [PATCH v2 1/2] platform/x86/drivers/acerhdf: Use
 module_param_cb to set/get polling interval
To:     "Daniel Lezcano" <daniel.lezcano@linaro.org>, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201203071738.2363701-1-daniel.lezcano@linaro.org>
References: <20201203071738.2363701-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3. Dezember 2020 08:17, "Daniel Lezcano" <daniel.lezcano@linaro.org> schrieb:

> The module parameter can be set by using ops to get and set the
> values. The change will allow to check the correctness of the interval
> value everytime it is changed instead of checking in the get_temp
> function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Peter Kaestle <peter@piie.net>

> ---
> drivers/platform/x86/acerhdf.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index 44b6bfbd32df..19fc8ff2225c 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -84,8 +84,6 @@ static struct platform_device *acerhdf_dev;
> 
> module_param(kernelmode, uint, 0);
> MODULE_PARM_DESC(kernelmode, "Kernel mode fan control on / off");
> -module_param(interval, uint, 0600);
> -MODULE_PARM_DESC(interval, "Polling interval of temperature check");
> module_param(fanon, uint, 0600);
> MODULE_PARM_DESC(fanon, "Turn the fan on above this temperature");
> module_param(fanoff, uint, 0600);
> @@ -824,3 +822,11 @@ MODULE_ALIAS("dmi:*:*Acer*:pnExtensa*5420*:");
> 
> module_init(acerhdf_init);
> module_exit(acerhdf_exit);
> +
> +static const struct kernel_param_ops interval_ops = {
> + .set = param_set_uint,
> + .get = param_get_uint,
> +};
> +
> +module_param_cb(interval, &interval_ops, &interval, 0600);
> +MODULE_PARM_DESC(interval, "Polling interval of temperature check");
> -- 
> 2.25.1
