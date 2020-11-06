Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DB92AA051
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 23:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgKFWWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 17:22:45 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:43476 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgKFWWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 17:22:41 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id AA3B420068;
        Fri,  6 Nov 2020 23:22:36 +0100 (CET)
Date:   Fri, 6 Nov 2020 23:22:35 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Gareth Hughes <gareth@valinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/19] drm/r128/ati_pcigart: Source file headers are not
 good candidates for kernel-doc
Message-ID: <20201106222235.GA826715@ravnborg.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-3-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106214949.2042120-3-lee.jones@linaro.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=UYoTZ2hgAAAA:8 a=e5mUnYsNAAAA:8 a=KKAkSRfTAAAA:8
        a=M3wnNZ1jaQZwqKYIB2kA:9 a=CjuIK1q_8ugA:10 a=V6L1DCqn-8WKw3iEt1hp:22
        a=Vxmtnl_E_bksehYqCbjh:22 a=cvBusfyB2V15izCimMoJ:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 09:49:32PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/r128/ati_pcigart.c:2: warning: Cannot understand  * file ati_pcigart.c
> 
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Gareth Hughes <gareth@valinux.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Thanks, applied to drm-misc-next.

	Sam

> ---
>  drivers/gpu/drm/r128/ati_pcigart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/r128/ati_pcigart.c b/drivers/gpu/drm/r128/ati_pcigart.c
> index 3e76ae5a17eea..1234ec60c0aff 100644
> --- a/drivers/gpu/drm/r128/ati_pcigart.c
> +++ b/drivers/gpu/drm/r128/ati_pcigart.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * \file ati_pcigart.c
>   * ATI PCI GART support
>   *
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
