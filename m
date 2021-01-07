Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EC82ECBC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbhAGIci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbhAGIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:32:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD90C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 00:31:57 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tomeu)
        with ESMTPSA id 8D1F61F462FA
Subject: Re: [PATCH v7 3/4] drm/panfrost: devfreq: Disable devfreq when
 num_supplies > 1
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     hoegsberg@chromium.org, fshao@chromium.org, hsinyi@chromium.org,
        boris.brezillon@collabora.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210107082653.3519337-1-drinkcat@chromium.org>
 <20210107162632.v7.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <a1367c40-7c30-95c2-0c7f-7eec58f04b9e@collabora.com>
Date:   Thu, 7 Jan 2021 09:31:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210107162632.v7.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/21 9:26 AM, Nicolas Boichat wrote:
> GPUs with more than a single regulator (e.g. G72 on MT8183) will
> require platform-specific handling, disable devfreq for now.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
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

Should this be info instead?

Regards,

Tomeu

> +		return 0;
> +	}
> +
>   	opp_table = dev_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
>   					      pfdev->comp->num_supplies);
>   	if (IS_ERR(opp_table)) {
> 
