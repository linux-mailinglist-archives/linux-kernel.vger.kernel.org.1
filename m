Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFC3277A82
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIXUev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:34:51 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:55378 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXUev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:34:51 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 1B48A20079;
        Thu, 24 Sep 2020 22:34:47 +0200 (CEST)
Date:   Thu, 24 Sep 2020 22:34:46 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] MAINTAINERS: mark FRAMEBUFFER LAYER as Orphan
Message-ID: <20200924203446.GL1223313@ravnborg.org>
References: <CGME20200924112530eucas1p13af17d649767ed51c619d303392fa1e1@eucas1p1.samsung.com>
 <7b709254-9412-8473-250c-0c4e006259b3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b709254-9412-8473-250c-0c4e006259b3@samsung.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=hD80L64hAAAA:8 a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8
        a=VwQbUJbxAAAA:8 a=KIuVEvK59YeNV9IdMJ8A:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=AjGcO6oz07-iQ99wixmX:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej

On Thu, Sep 24, 2020 at 01:25:30PM +0200, Bartlomiej Zolnierkiewicz wrote:
> It has been a fun ride since 2017 but unfortunately I don't have
> enough time to look after it properly anymore.

Thanks for all your work on fbdev, and other stuff.

I hope you have fun in the current job with whatever you do or
even better manage to find something else so we can get you back.

I could see that Daniel thinks we shall keep fbdev in drm-misc
but we shall no longer rely on you sweeping the mailing list
for all the pending patches :-( So I will likely start breaking
fbdev some more (read: applying a few more fbdev patches).

> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Sam Ravnborg <sam@ravnborg.org>

Please consider a proper entry in CREDITS too!

	Sam

> ---
>  MAINTAINERS |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Index: b/MAINTAINERS
> ===================================================================
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6894,10 +6894,9 @@ F:	drivers/net/wan/dlci.c
>  F:	drivers/net/wan/sdla.c
>  
>  FRAMEBUFFER LAYER
> -M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>  L:	dri-devel@lists.freedesktop.org
>  L:	linux-fbdev@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/fb/
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
