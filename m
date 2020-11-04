Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0FD2A63A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgKDLxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:53:41 -0500
Received: from foss.arm.com ([217.140.110.172]:35842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKDLxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:53:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ACD61474;
        Wed,  4 Nov 2020 03:53:34 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AA383F719;
        Wed,  4 Nov 2020 03:53:32 -0800 (PST)
Subject: Re: [PATCH] drm/panfrost: Replace devm_reset_control_array_get()
To:     Yejune Deng <yejune.deng@gmail.com>, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1604368082-6032-1-git-send-email-yejune.deng@gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <0de60b2e-fdff-f2f1-f734-1b1aa949b6fb@arm.com>
Date:   Wed, 4 Nov 2020 11:53:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604368082-6032-1-git-send-email-yejune.deng@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2020 01:48, Yejune Deng wrote:
> devm_reset_control_array_get_optional_exclusive() looks more readable
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks, I'll push this to drm-misc-next.

Steve

> ---
>   drivers/gpu/drm/panfrost/panfrost_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index ea8d318..1daf932 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -18,7 +18,7 @@
>   
>   static int panfrost_reset_init(struct panfrost_device *pfdev)
>   {
> -	pfdev->rstc = devm_reset_control_array_get(pfdev->dev, false, true);
> +	pfdev->rstc = devm_reset_control_array_get_optional_exclusive(pfdev->dev);
>   	if (IS_ERR(pfdev->rstc)) {
>   		dev_err(pfdev->dev, "get reset failed %ld\n", PTR_ERR(pfdev->rstc));
>   		return PTR_ERR(pfdev->rstc);
> 

