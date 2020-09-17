Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B899526D936
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIQKhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:37:34 -0400
Received: from foss.arm.com ([217.140.110.172]:44308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgIQKfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:35:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAF6013D5;
        Thu, 17 Sep 2020 03:29:08 -0700 (PDT)
Received: from [192.168.1.79] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 666F73F8C6;
        Thu, 17 Sep 2020 03:29:07 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] drm/panfrost: add amlogic reset quirk callback
To:     Neil Armstrong <narmstrong@baylibre.com>, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20200916150147.25753-1-narmstrong@baylibre.com>
 <20200916150147.25753-3-narmstrong@baylibre.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <65d87f20-6dce-adeb-4d32-7a73462dd575@arm.com>
Date:   Thu, 17 Sep 2020 11:29:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916150147.25753-3-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2020 16:01, Neil Armstrong wrote:
> The T820, G31 & G52 GPUs integratewd by Amlogic in the respective GXM, G12A/SM1 & G12B

NIT: s/integratewd/integrated/

> SoCs needs a quirk in the PWR registers at the GPU reset time.
> 
> Since the Amlogic's integration of the GPU cores with the SoC is not
> publicly documented we do not know what does these
> values, but they permit having a fully functional GPU running with Panfrost.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_gpu.c  | 11 +++++++++++
>   drivers/gpu/drm/panfrost/panfrost_gpu.h  |  2 ++
>   drivers/gpu/drm/panfrost/panfrost_regs.h |  4 ++++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index a6de78bc1fa8..e1b2a3376624 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -76,6 +76,17 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
>   	return 0;
>   }
>   
> +void panfrost_gpu_amlogic_quirk(struct panfrost_device *pfdev)
> +{
> +	/*
> +	 * The Amlogic integrated Mali-T820, Mali-G31 & Mali-G52 needs
> +	 * these undocumented bits in GPU_PWR_OVERRIDE1 to be set in order
> +	 * to operate correctly.
> +	 */
> +	gpu_write(pfdev, GPU_PWR_KEY, GPU_PWR_KEY_UNLOCK);
> +	gpu_write(pfdev, GPU_PWR_OVERRIDE1, 0xfff | (0x20 << 16));
> +}
> +
>   static void panfrost_gpu_init_quirks(struct panfrost_device *pfdev)
>   {
>   	u32 quirks = 0;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.h b/drivers/gpu/drm/panfrost/panfrost_gpu.h
> index 4112412087b2..468c51e7e46d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.h
> @@ -16,4 +16,6 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev);
>   void panfrost_gpu_power_on(struct panfrost_device *pfdev);
>   void panfrost_gpu_power_off(struct panfrost_device *pfdev);
>   
> +void panfrost_gpu_amlogic_quirk(struct panfrost_device *pfdev);
> +
>   #endif
> diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
> index ea38ac60581c..eddaa62ad8b0 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_regs.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
> @@ -51,6 +51,10 @@
>   #define GPU_STATUS			0x34
>   #define   GPU_STATUS_PRFCNT_ACTIVE	BIT(2)
>   #define GPU_LATEST_FLUSH_ID		0x38
> +#define GPU_PWR_KEY			0x50	/* (WO) Power manager key register */
> +#define  GPU_PWR_KEY_UNLOCK		0x2968A819
> +#define GPU_PWR_OVERRIDE0		0x54	/* (RW) Power manager override settings */
> +#define GPU_PWR_OVERRIDE1		0x58	/* (RW) Power manager override settings */
>   #define GPU_FAULT_STATUS		0x3C
>   #define GPU_FAULT_ADDRESS_LO		0x40
>   #define GPU_FAULT_ADDRESS_HI		0x44
> 

