Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE82F63D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbhANPLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:11:20 -0500
Received: from foss.arm.com ([217.140.110.172]:51284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbhANPLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:11:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C5641042;
        Thu, 14 Jan 2021 07:10:33 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CF6A3F70D;
        Thu, 14 Jan 2021 07:10:31 -0800 (PST)
Subject: Re: [PATCH v10 4/4] drm/panfrost: Add mt8183-mali compatible string
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>, fshao@chromium.org,
        boris.brezillon@collabora.com, hsinyi@chromium.org,
        hoegsberg@chromium.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20210113060703.3122661-1-drinkcat@chromium.org>
 <20210113140546.v10.4.I5f6b04431828ec9c3e41e65f3337cec6a127480d@changeid>
From:   Steven Price <steven.price@arm.com>
Message-ID: <6e2a6e89-1b5b-eb75-df91-d0f243ab7ec5@arm.com>
Date:   Thu, 14 Jan 2021 15:10:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113140546.v10.4.I5f6b04431828ec9c3e41e65f3337cec6a127480d@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2021 06:07, Nicolas Boichat wrote:
> Add support for MT8183's G72 Bifrost.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

LGTM

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
> 
> (no changes since v7)
> 
> Changes in v7:
>   - Fix GPU ID in commit message
> 
> Changes in v6:
>   - Context conflicts, reflow the code.
>   - Use ARRAY_SIZE for power domains too.
> 
> Changes in v5:
>   - Change power domain name from 2d to core2.
> 
> Changes in v4:
>   - Add power domain names.
> 
> Changes in v3:
>   - Match mt8183-mali instead of bifrost, as we require special
>     handling for the 2 regulators and 3 power domains.
> 
>   drivers/gpu/drm/panfrost/panfrost_drv.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 83a461bdeea8..ca07098a6141 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -665,6 +665,15 @@ static const struct panfrost_compatible amlogic_data = {
>   	.vendor_quirk = panfrost_gpu_amlogic_quirk,
>   };
>   
> +const char * const mediatek_mt8183_supplies[] = { "mali", "sram" };
> +const char * const mediatek_mt8183_pm_domains[] = { "core0", "core1", "core2" };
> +static const struct panfrost_compatible mediatek_mt8183_data = {
> +	.num_supplies = ARRAY_SIZE(mediatek_mt8183_supplies),
> +	.supply_names = mediatek_mt8183_supplies,
> +	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
> +	.pm_domain_names = mediatek_mt8183_pm_domains,
> +};
> +
>   static const struct of_device_id dt_match[] = {
>   	/* Set first to probe before the generic compatibles */
>   	{ .compatible = "amlogic,meson-gxm-mali",
> @@ -681,6 +690,7 @@ static const struct of_device_id dt_match[] = {
>   	{ .compatible = "arm,mali-t860", .data = &default_data, },
>   	{ .compatible = "arm,mali-t880", .data = &default_data, },
>   	{ .compatible = "arm,mali-bifrost", .data = &default_data, },
> +	{ .compatible = "mediatek,mt8183-mali", .data = &mediatek_mt8183_data },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, dt_match);
> 

