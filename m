Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9432CFE5C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 20:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgLETZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 14:25:37 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:54074 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgLETZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 14:25:36 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id BAF51804C8;
        Sat,  5 Dec 2020 20:24:48 +0100 (CET)
Date:   Sat, 5 Dec 2020 20:24:47 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: panel: Fully transition panel_desc kerneldoc to
 inline style
Message-ID: <20201205192447.GD332836@ravnborg.org>
References: <20201201125822.1.I3c4191336014bd57364309439e56f600c94bb12b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201125822.1.I3c4191336014bd57364309439e56f600c94bb12b@changeid>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8
        a=e5mUnYsNAAAA:8 a=z3ztCu_kXq1d7hxwpHYA:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=xmb-EsYY8bH0VWELuYED:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

On Tue, Dec 01, 2020 at 12:59:12PM -0800, Douglas Anderson wrote:
> In commit 131f909ad55f ("drm: panel: simple: Fixup the struct
> panel_desc kernel doc") I transitioned the more deeply nested
> kerneldoc comments into the inline style.  Apparently it is desirable
> to continue the job and move _everything_ in this struct to inline.
> Let's do it.
> 
> While doing this, we also add a short summary for the whole struct to
> fix a warning when we run with extra warnings, AKA:
>   scripts/kernel-doc -v -rst drivers/gpu/drm/panel/panel-simple.c
> 
> The warning was:
>   drivers/gpu/drm/panel/panel-simple.c:42: warning: missing initial short description on line:
>    * struct panel_desc
> 
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> ---
> 
>  drivers/gpu/drm/panel/panel-simple.c | 43 +++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 216cde33b5c4..33d53abdb1fb 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -39,31 +39,36 @@
>  #include <drm/drm_panel.h>
>  
>  /**
> - * struct panel_desc
> - * @modes: Pointer to array of fixed modes appropriate for this panel.  If
> - *         only one mode then this can just be the address of this the mode.
While applying I fixed this up like this:
> - *         only one mode then this can just be the address of the mode.

Applied to drm-misc-next - thanks for doing this. Much nicer now.

	Sam
