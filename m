Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260732ED3D5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbhAGQAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:00:45 -0500
Received: from foss.arm.com ([217.140.110.172]:35256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbhAGQAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:00:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CA2B31B;
        Thu,  7 Jan 2021 07:59:59 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78C533F719;
        Thu,  7 Jan 2021 07:59:57 -0800 (PST)
Subject: Re: [PATCH v6 3/4] drm/panfrost: devfreq: Disable devfreq when
 num_supplies > 1
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     hsinyi@chromium.org, hoegsberg@chromium.org, fshao@chromium.org,
        boris.brezillon@collabora.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210105001119.2129559-1-drinkcat@chromium.org>
 <20210105081111.v6.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
From:   Steven Price <steven.price@arm.com>
Message-ID: <a373044b-3e24-4e00-432f-46b0bd91b213@arm.com>
Date:   Thu, 7 Jan 2021 15:59:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210105081111.v6.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2021 00:11, Nicolas Boichat wrote:
> GPUs with more than a single regulator (e.g. G-57 on MT8183) will
> require platform-specific handling, disable devfreq for now.

Can you explain what actually goes wrong here? AFAICT the existing code 
does support controlling multiple regulators - but clearly this is the 
first platform that exercises that code with num_supplies>1.

Steve

> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> Changes in v6:
>   - New change
> 
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index f44d28fad085..1f49043aae73 100644
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
> +		DRM_DEV_ERROR(dev, "More than 1 supply is not supported yet\n");
> +		return 0;
> +	}
> +
>   	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
>   					      pfdev->comp->num_supplies);
>   	if (IS_ERR(opp_table)) {
> 

