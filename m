Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1851C79F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 21:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgEFTJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 15:09:51 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:47680 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgEFTJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:09:51 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id C4C6480502;
        Wed,  6 May 2020 21:09:47 +0200 (CEST)
Date:   Wed, 6 May 2020 21:09:46 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     airlied@redhat.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm/udl: Make udl_handle_damage static
Message-ID: <20200506190946.GF8227@ravnborg.org>
References: <1588248797-70568-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588248797-70568-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=i0EeH86SAAAA:8 a=e5mUnYsNAAAA:8
        a=mHTzVa-qg5FCAHh-PYMA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zou Wei.

On Thu, Apr 30, 2020 at 08:13:17PM +0800, Zou Wei wrote:
> Fix the following sparse warning:
> 
> drivers/gpu/drm/udl/udl_modeset.c:269:5: warning: symbol 'udl_handle_damage'
> was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Thanks, applied to drm-misc-next.

	Sam

> ---
>  drivers/gpu/drm/udl/udl_modeset.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
> index 99518a8..fef43f4 100644
> --- a/drivers/gpu/drm/udl/udl_modeset.c
> +++ b/drivers/gpu/drm/udl/udl_modeset.c
> @@ -266,8 +266,8 @@ static int udl_aligned_damage_clip(struct drm_rect *clip, int x, int y,
>  	return 0;
>  }
>  
> -int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
> -		      int width, int height)
> +static int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
> +			     int width, int height)
>  {
>  	struct drm_device *dev = fb->dev;
>  	struct dma_buf_attachment *import_attach = fb->obj[0]->import_attach;
> -- 
> 2.6.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
