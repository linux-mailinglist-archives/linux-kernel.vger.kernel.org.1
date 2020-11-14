Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408832B3000
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 20:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKNTLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 14:11:32 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:54958 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKNTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 14:11:31 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id D60F080560;
        Sat, 14 Nov 2020 20:11:28 +0100 (CET)
Date:   Sat, 14 Nov 2020 20:11:27 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>, Eric Anholt <eric@anholt.net>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/40] drm/pl111/pl111_display: Make local function static
Message-ID: <20201114191127.GB3797389@ravnborg.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-13-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201113134938.4004947-13-lee.jones@linaro.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=-VAfIpHNAAAA:8 a=e5mUnYsNAAAA:8 a=KKAkSRfTAAAA:8
        a=Cwvp4g05kwjmXd1pErQA:9 a=QEXdDO2ut3YA:10 a=srlwD-8ojaedGGhPAyx8:22
        a=Vxmtnl_E_bksehYqCbjh:22 a=cvBusfyB2V15izCimMoJ:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,
On Fri, Nov 13, 2020 at 01:49:10PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/pl111/pl111_display.c:356:6: warning: no previous prototype for ‘pl111_display_disable’ [-Wmissing-prototypes]
> 
> Cc: Eric Anholt <eric@anholt.net>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Eric's was not copied on this or the other pl111 patch.
Added Eric so he can be aware of this fix.

	Sam

> ---
>  drivers/gpu/drm/pl111/pl111_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
> index b3e8697cafcf1..69c02e7c82b7e 100644
> --- a/drivers/gpu/drm/pl111/pl111_display.c
> +++ b/drivers/gpu/drm/pl111/pl111_display.c
> @@ -353,7 +353,7 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
>  		drm_crtc_vblank_on(crtc);
>  }
>  
> -void pl111_display_disable(struct drm_simple_display_pipe *pipe)
> +static void pl111_display_disable(struct drm_simple_display_pipe *pipe)
>  {
>  	struct drm_crtc *crtc = &pipe->crtc;
>  	struct drm_device *drm = crtc->dev;
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
