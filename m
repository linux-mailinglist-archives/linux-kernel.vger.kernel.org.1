Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD25F22E1A8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 19:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgGZRZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 13:25:53 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:58994 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgGZRZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 13:25:53 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id D2D0220023;
        Sun, 26 Jul 2020 19:25:50 +0200 (CEST)
Date:   Sun, 26 Jul 2020 19:25:49 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/2] drm/fourcc: fix Amlogic Video Framebuffer
 Compression macro
Message-ID: <20200726172549.GH3275923@ravnborg.org>
References: <20200723090551.27529-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723090551.27529-1-narmstrong@baylibre.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=IpJZQVW2AAAA:8 a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8
        a=lB4rwjMMMp82C4b3nNAA:9 a=CjuIK1q_8ugA:10 a=IawgGOuG5U0WyFbmm1f5:22
        a=E9Po1WZjFZOl8hwRPBS3:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil.

On Thu, Jul 23, 2020 at 11:05:50AM +0200, Neil Armstrong wrote:
> Fix the Amlogic Video Framebuffer Compression modifier macro to
> correctly add the layout options, a pair of parenthesis was missing.
> 
> Fixes: d6528ec88309 ("drm/fourcc: Add modifier definitions for describing Amlogic Video Framebuffer Compression")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Looks correct just looking at the patch below.
Acked-by: Sam Ravnborg <sam@ravnborg.org>

I assume you will apply the patch.

	Sam

> ---
>  include/uapi/drm/drm_fourcc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 4bee7de5f306..82f327801267 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -1004,7 +1004,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
>  #define DRM_FORMAT_MOD_AMLOGIC_FBC(__layout, __options) \
>  	fourcc_mod_code(AMLOGIC, \
>  			((__layout) & __fourcc_mod_amlogic_layout_mask) | \
> -			((__options) & __fourcc_mod_amlogic_options_mask \
> +			(((__options) & __fourcc_mod_amlogic_options_mask) \
>  			 << __fourcc_mod_amlogic_options_shift))
>  
>  /* Amlogic FBC Layouts */
> -- 
> 2.22.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
