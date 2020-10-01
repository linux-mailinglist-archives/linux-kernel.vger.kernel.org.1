Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5A727FDED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 12:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbgJAK6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 06:58:47 -0400
Received: from foss.arm.com ([217.140.110.172]:59112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732020AbgJAK6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 06:58:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30DC730E;
        Thu,  1 Oct 2020 03:58:46 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 250DD3F70D;
        Thu,  1 Oct 2020 03:58:45 -0700 (PDT)
Subject: Re: [PATCH -next] drm/panfrost: simplify the return expression of
 panfrost_devfreq_target()
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200921131021.91604-1-miaoqinglang@huawei.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <8ae8a758-23ee-a413-5b25-b7beb8f4e254@arm.com>
Date:   Thu, 1 Oct 2020 11:58:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921131021.91604-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2020 14:10, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 8ab025d00..913eaa6d0 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -29,18 +29,13 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
>   				   u32 flags)
>   {
>   	struct dev_pm_opp *opp;
> -	int err;
>   
>   	opp = devfreq_recommended_opp(dev, freq, flags);
>   	if (IS_ERR(opp))
>   		return PTR_ERR(opp);
>   	dev_pm_opp_put(opp);
>   
> -	err = dev_pm_opp_set_rate(dev, *freq);
> -	if (err)
> -		return err;
> -
> -	return 0;
> +	return dev_pm_opp_set_rate(dev, *freq);
>   }
>   
>   static void panfrost_devfreq_reset(struct panfrost_devfreq *pfdevfreq)
> 

