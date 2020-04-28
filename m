Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50411BCF31
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 23:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgD1Vyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 17:54:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54814 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgD1Vyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:54:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0BD74263B50
Subject: Re: [PATCH] drm/rockchip: cdn-dp-core: Make
 cdn_dp_core_suspend/resume __maybe_unused
To:     Arnd Bergmann <arnd@arndb.de>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <treding@nvidia.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200428213138.3171708-1-arnd@arndb.de>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8ad960b2-0c32-5043-7170-71b46fc150c3@collabora.com>
Date:   Tue, 28 Apr 2020 23:54:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428213138.3171708-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 28/4/20 23:31, Arnd Bergmann wrote:
> With the new static annotation, the compiler warns when the functions
> are actually unused:
> 

Right, thank you for the patch.

> drivers/gpu/drm/rockchip/cdn-dp-core.c:1123:12: error: 'cdn_dp_resume' defined but not used [-Werror=unused-function]
>  1123 | static int cdn_dp_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~
> 
> Mark them __maybe_unused to suppress that warning as well.
> 
> Fixes: 7c49abb4c2f8 ("drm/rockchip: cdn-dp-core: Make cdn_dp_core_suspend/resume static")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/gpu/drm/rockchip/cdn-dp-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> index c634b95b50f7..1cde98c6b0e6 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -1106,7 +1106,7 @@ static const struct component_ops cdn_dp_component_ops = {
>  	.unbind = cdn_dp_unbind,
>  };
>  
> -static int cdn_dp_suspend(struct device *dev)
> +static __maybe_unused int cdn_dp_suspend(struct device *dev)
>  {
>  	struct cdn_dp_device *dp = dev_get_drvdata(dev);
>  	int ret = 0;
> @@ -1120,7 +1120,7 @@ static int cdn_dp_suspend(struct device *dev)
>  	return ret;
>  }
>  
> -static int cdn_dp_resume(struct device *dev)
> +static __maybe_unused int cdn_dp_resume(struct device *dev)
>  {
>  	struct cdn_dp_device *dp = dev_get_drvdata(dev);
>  
> 
