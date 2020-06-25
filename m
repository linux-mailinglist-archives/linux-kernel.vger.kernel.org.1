Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06499209B42
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390624AbgFYI0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 04:26:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33578 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389747AbgFYI0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:26:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 427D72A5107
Subject: Re: [PATCH] platform/chrome: fix a double-unlock issue
To:     wu000273@umn.edu, bleung@chromium.org
Cc:     groeck@chromium.org, linux-kernel@vger.kernel.org, kjlu@umn.edu,
        Jett Rink <jettrink@chromium.org>,
        Mathew King <mathewk@chromium.org>,
        Enrico Granata <egranata@chromium.org>
References: <20200523031608.17918-1-wu000273@umn.edu>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8d81a91b-4c1d-d0e1-60d0-a68f6ef65bd0@collabora.com>
Date:   Thu, 25 Jun 2020 10:26:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200523031608.17918-1-wu000273@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiushi,

Thank you for your patch.

On 23/5/20 5:16, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> In function cros_ec_ishtp_probe(), "up_write" is already called
> before function "cros_ec_dev_init". But "up_write" will be called
> again after the calling of the function "cros_ec_dev_init" failed.
> Thus add a call of the function “down_write” in this if branch
> for the completion of the exception handling.
> 
> Fixes: 26a14267aff2 ("platform/chrome: Add ChromeOS EC ISHTP driver")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>

The change looks good to me, but I'd like someone having the hardware giving a
Tested-by tag, so cc'ing some chromeos people. They must be also interested on
backport this patch.

> ---
>  drivers/platform/chrome/cros_ec_ishtp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
> index 93a71e93a2f1..41d60af618c9 100644
> --- a/drivers/platform/chrome/cros_ec_ishtp.c
> +++ b/drivers/platform/chrome/cros_ec_ishtp.c
> @@ -660,8 +660,10 @@ static int cros_ec_ishtp_probe(struct ishtp_cl_device *cl_device)
>  
>  	/* Register croc_ec_dev mfd */
>  	rv = cros_ec_dev_init(client_data);
> -	if (rv)
> +	if (rv) {
> +		down_write(&init_lock);
>  		goto end_cros_ec_dev_init_error;
> +	}
>  
>  	return 0;
>  
> 
