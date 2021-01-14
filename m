Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECD92F63D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbhANPLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:11:14 -0500
Received: from foss.arm.com ([217.140.110.172]:51262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbhANPLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:11:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A9A3ED1;
        Thu, 14 Jan 2021 07:10:28 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEF853F70D;
        Thu, 14 Jan 2021 07:10:26 -0800 (PST)
Subject: Re: [PATCH v10 3/4] drm/panfrost: devfreq: Disable devfreq when
 num_supplies > 1
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>, fshao@chromium.org,
        boris.brezillon@collabora.com, hsinyi@chromium.org,
        hoegsberg@chromium.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210113060703.3122661-1-drinkcat@chromium.org>
 <20210113140546.v10.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
From:   Steven Price <steven.price@arm.com>
Message-ID: <495a0ad3-ef01-d4b8-eb1f-e70d55fd7ddf@arm.com>
Date:   Thu, 14 Jan 2021 15:10:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113140546.v10.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2021 06:07, Nicolas Boichat wrote:
> GPUs with more than a single regulator (e.g. G72 on MT8183) will
> require platform-specific handling for devfreq, for 2 reasons:
>   1. The opp core (drivers/opp/core.c:_generic_set_opp_regulator)
>      does not support multiple regulators, so we'll need custom
>      handlers.
>   2. Generally, platforms with 2 regulators have platform-specific
>      constraints on how the voltages should be set (e.g.
>      minimum/maximum voltage difference between them), so we
>      should not just create generic handlers that simply
>      change the voltages without taking care of those constraints.
> 
> Disable devfreq for now on those GPUs.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Thanks for the clarification in the commit message.

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
> 
> (no changes since v9)
> 
> Changes in v9:
>   - Explain why devfreq needs to be disabled for GPUs with >1
>     regulators.
> 
> Changes in v8:
>   - Use DRM_DEV_INFO instead of ERROR
> 
> Changes in v7:
>   - Fix GPU ID in commit message
> 
> Changes in v6:
>   - New change
> 
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index f44d28fad085..812cfecdee3b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -92,6 +92,15 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>   	struct thermal_cooling_device *cooling;
>   	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
>   
> +	if (pfdev->comp->num_supplies > 1) {
> +		/*
> +		 * GPUs with more than 1 supply require platform-specific handling:
> +		 * continue without devfreq
> +		 */
> +		DRM_DEV_INFO(dev, "More than 1 supply is not supported yet\n");
> +		return 0;
> +	}
> +
>   	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
>   					      pfdev->comp->num_supplies);
>   	if (IS_ERR(opp_table)) {
> 

