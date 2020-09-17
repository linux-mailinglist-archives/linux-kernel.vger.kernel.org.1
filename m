Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0103F26D92A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgIQKft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:35:49 -0400
Received: from foss.arm.com ([217.140.110.172]:44306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgIQKf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:35:27 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 06:35:27 EDT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2886012FC;
        Thu, 17 Sep 2020 03:29:08 -0700 (PDT)
Received: from [192.168.1.79] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A97B13F68F;
        Thu, 17 Sep 2020 03:29:06 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] drm/panfrost: add support for vendor quirk
To:     Neil Armstrong <narmstrong@baylibre.com>, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20200916150147.25753-1-narmstrong@baylibre.com>
 <20200916150147.25753-2-narmstrong@baylibre.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <370802ea-5f21-7a62-cf84-0dc5f5020667@arm.com>
Date:   Thu, 17 Sep 2020 11:29:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916150147.25753-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2020 16:01, Neil Armstrong wrote:
> The T820, G31 & G52 GPUs integratewd by Amlogic in the respective GXM, G12A/SM1 & G12B

NIT: s/integratewd/integrated/

> SoCs needs a quirk in the PWR registers after each reset.
> 
> This adds a callback in the device compatible struct of permit this.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_device.h | 3 +++
>   drivers/gpu/drm/panfrost/panfrost_gpu.c    | 4 ++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index abfc78db193a..140e004a3790 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -70,6 +70,9 @@ struct panfrost_compatible {
>   	int num_pm_domains;
>   	/* Only required if num_pm_domains > 1. */
>   	const char * const *pm_domain_names;
> +
> +	/* Vendor implementation quirks callback */
> +	void (*vendor_quirk)(struct panfrost_device *pfdev);
>   };
>   
>   struct panfrost_device {
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index c7c5da5a31d4..a6de78bc1fa8 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -136,6 +136,10 @@ static void panfrost_gpu_init_quirks(struct panfrost_device *pfdev)
>   
>   	if (quirks)
>   		gpu_write(pfdev, GPU_JM_CONFIG, quirks);
> +
> +	/* Here goes platform specific quirks */
> +	if (pfdev->comp->vendor_quirk)
> +		pfdev->comp->vendor_quirk(pfdev);
>   }
>   
>   #define MAX_HW_REVS 6
> 

