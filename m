Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D43279BDC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 20:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgIZSZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 14:25:52 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:45102 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZSZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 14:25:51 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id BD6E48068D;
        Sat, 26 Sep 2020 20:25:49 +0200 (CEST)
Date:   Sat, 26 Sep 2020 20:25:48 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Ingenic-drm improvements + new pixel formats
Message-ID: <20200926182548.GB91317@ravnborg.org>
References: <20200926170501.1109197-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926170501.1109197-1-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=A5ZCwZeG c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=sgGEiIrZ8JUFcs7D_jkA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Sat, Sep 26, 2020 at 07:04:54PM +0200, Paul Cercueil wrote:
> Hi,
> 
> This is a V2 of my small patchset "Small improvements to ingenic-drm"
> that I sent about two weeks ago. In that time, I worked on new
> improvements, so I thought I'd just add them to the patchset, since
> I needed a V2 anyway.
> 
> Sam: the patches you acked have been all slightly modified, I kept your
> acked-by on them, please tell me if that's OK.

All patches except "Add support for paletted 8bpp" are:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>



	sam
> 
> Cheers,
> -Paul
> 
> Paul Cercueil (7):
>   drm/ingenic: Reset pixclock rate when parent clock rate changes
>   drm/ingenic: Add support for reserved memory
>   drm/ingenic: Alloc F0 and F1 DMA descriptors at once
>   drm/ingenic: Support handling different pixel formats in F0/F1 planes
>   drm/ingenic: Add support for paletted 8bpp
>   drm/ingenic: Add support for 30-bit modes
>   drm/ingenic: Add support for 24-bit modes
> 
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 262 +++++++++++++++++++---
>  drivers/gpu/drm/ingenic/ingenic-drm.h     |   3 +
>  2 files changed, 228 insertions(+), 37 deletions(-)
> 
> -- 
> 2.28.0
