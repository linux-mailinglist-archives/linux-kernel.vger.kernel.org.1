Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D4C1BEAC8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgD2V6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 17:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD2V6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:58:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32335C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:58:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 655242A22CF
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Handle NULL EC pointer
 during probe.
To:     Daniil Lunev <dlunev@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200428110253.1.I926f6741079cafb04ecb592130aef75b24ad31ae@changeid>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c57b0892-d68d-f0f2-3cc1-b8549983227e@collabora.com>
Date:   Wed, 29 Apr 2020 23:58:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428110253.1.I926f6741079cafb04ecb592130aef75b24ad31ae@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniil,

Thank you for the patch.

On 28/4/20 3:02, Daniil Lunev wrote:
> Missing EC in device hierarchy causes NULL pointer to be returned to the
> probe function which leads to NULL pointer dereference when trying to
> send a command to the EC. This can be the case if the device is missing
> or incorrectly configured in the firmware blob. Even if the situation

There is any production device with a buggy firmware outside? Or this is just
for defensive programming while developing the firmware? Which device is
affected for this issue?

Thanks,
 Enric

> occures, the driver shall not cause a kernel panic as the condition is
> not critical for the system functions.
> 
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
> ---
> 
>  drivers/platform/chrome/cros_ec_typec.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 874269c07073..30d99c930445 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -301,6 +301,11 @@ static int cros_typec_probe(struct platform_device *pdev)
>  
>  	typec->dev = dev;
>  	typec->ec = dev_get_drvdata(pdev->dev.parent);
> +	if (!typec->ec) {
> +		dev_err(dev, "Failed to get Cros EC data\n");
> +		return -EINVAL;
> +	}
> +
>  	platform_set_drvdata(pdev, typec);
>  
>  	ret = cros_typec_get_cmd_version(typec);
> 
