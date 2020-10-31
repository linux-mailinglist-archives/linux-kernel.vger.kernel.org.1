Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0812A1312
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 03:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgJaCmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 22:42:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6675 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaCmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 22:42:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CNNk70yFHz15NwZ;
        Sat, 31 Oct 2020 10:42:07 +0800 (CST)
Received: from [10.174.176.180] (10.174.176.180) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 31 Oct 2020 10:42:05 +0800
Subject: Re: [PATCH -next] drm/rockchip: cdn-dp: Mark
 cdn_dp_core_suspend/resume __maybe_unused
To:     <hjc@rock-chips.com>, <heiko@sntech.de>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
References: <20200811021225.50296-1-yuehaibing@huawei.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <4fa1e3fe-c254-6924-ed3b-a6fd4ca88e41@huawei.com>
Date:   Sat, 31 Oct 2020 10:42:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200811021225.50296-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.180]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

On 2020/8/11 10:12, YueHaibing wrote:
> If CONFIG_PM is not set, gcc warns:
> 
> drivers/gpu/drm/rockchip/cdn-dp-core.c:1124:12:
>  warning: ‘cdn_dp_resume’ defined but not used [-Wunused-function]
> 
> Mark them __maybe_unused to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/rockchip/cdn-dp-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> index a4a45daf93f2..413b0e90f10f 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -1107,7 +1107,7 @@ static const struct component_ops cdn_dp_component_ops = {
>  	.unbind = cdn_dp_unbind,
>  };
>  
> -static int cdn_dp_suspend(struct device *dev)
> +static __maybe_unused int cdn_dp_suspend(struct device *dev)
>  {
>  	struct cdn_dp_device *dp = dev_get_drvdata(dev);
>  	int ret = 0;
> @@ -1121,7 +1121,7 @@ static int cdn_dp_suspend(struct device *dev)
>  	return ret;
>  }
>  
> -static int cdn_dp_resume(struct device *dev)
> +static __maybe_unused int cdn_dp_resume(struct device *dev)
>  {
>  	struct cdn_dp_device *dp = dev_get_drvdata(dev);
>  
> 
