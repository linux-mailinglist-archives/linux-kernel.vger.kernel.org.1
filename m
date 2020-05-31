Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EAB1E9A54
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 22:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgEaUYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 16:24:49 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:35058 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgEaUYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 16:24:49 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 223CD8050B;
        Sun, 31 May 2020 22:24:44 +0200 (CEST)
Date:   Sun, 31 May 2020 22:24:42 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] Documentation: Fix typo error in todo.rst
Message-ID: <20200531202442.GA138722@ravnborg.org>
References: <20200528172159.24641-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528172159.24641-1-realwakka@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=G88y7es5 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
        a=VYX68jFDfHIqEWenzyAA:9 a=CjuIK1q_8ugA:10 a=-RoEEKskQ1sA:10
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sidong
On Fri, May 29, 2020 at 02:21:59AM +0900, Sidong Yang wrote:
> Change wrong function name drm_modest_lock_all() to drm_modeset_lock_all()
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Thanks, applied to drm-misc-next.

	Sam

> ---
>  Documentation/gpu/todo.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index 658b52f7ffc6..436489b53fea 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -305,7 +305,7 @@ acquire context. Replace the boilerplate code surrounding
>  drm_modeset_lock_all_ctx() with DRM_MODESET_LOCK_ALL_BEGIN() and
>  DRM_MODESET_LOCK_ALL_END() instead.
>  
> -This should also be done for all places where drm_modest_lock_all() is still
> +This should also be done for all places where drm_modeset_lock_all() is still
>  used.
>  
>  As a reference, take a look at the conversions already completed in drm core.
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
