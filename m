Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6932DE16F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 11:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389264AbgLRKpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 05:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733203AbgLRKpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 05:45:02 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F0CC0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 02:44:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1491F1F461AC
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_sysfs: Add cold-ap-off to
 sysfs reboot.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201217081423.896862-1-pihsun@chromium.org>
 <20201217081423.896862-2-pihsun@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <eb669446-3874-b5c5-f943-3d6131eec4b2@collabora.com>
Date:   Fri, 18 Dec 2020 11:44:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201217081423.896862-2-pihsun@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pi-Hsun,

Thank you for your patch. I don't accept patches with an empty commit
description. Can you add it? (maybe you could just explain more what cold-ap-off
means here. Apart from this, the patch LGTM.

Thanks,
  Enric


On 17/12/20 9:14, Pi-Hsun Shih wrote:
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> index f521a5c65091..8210fb10e839 100644
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -28,7 +28,7 @@ static ssize_t reboot_show(struct device *dev,
>  	int count = 0;
>  
>  	count += scnprintf(buf + count, PAGE_SIZE - count,
> -			   "ro|rw|cancel|cold|disable-jump|hibernate");
> +			   "ro|rw|cancel|cold|disable-jump|hibernate|cold-ap-off");
>  	count += scnprintf(buf + count, PAGE_SIZE - count,
>  			   " [at-shutdown]\n");
>  	return count;
> @@ -46,6 +46,7 @@ static ssize_t reboot_store(struct device *dev,
>  		{"cancel",       EC_REBOOT_CANCEL, 0},
>  		{"ro",           EC_REBOOT_JUMP_RO, 0},
>  		{"rw",           EC_REBOOT_JUMP_RW, 0},
> +		{"cold-ap-off",  EC_REBOOT_COLD_AP_OFF, 0},
>  		{"cold",         EC_REBOOT_COLD, 0},
>  		{"disable-jump", EC_REBOOT_DISABLE_JUMP, 0},
>  		{"hibernate",    EC_REBOOT_HIBERNATE, 0},
> 
