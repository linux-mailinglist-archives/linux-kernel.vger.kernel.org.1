Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA90D2B0E19
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgKLTbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:31:16 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:41996 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgKLTbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:31:16 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 55E4320026;
        Thu, 12 Nov 2020 20:31:14 +0100 (CET)
Date:   Thu, 12 Nov 2020 20:31:13 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/30] drm/savage/savage_bci: Remove set but never used
 'aper_rsrc' and 'fb_rsrc'
Message-ID: <20201112193113.GD3287572@ravnborg.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
 <20201112190039.2785914-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201112190039.2785914-2-lee.jones@linaro.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=e5mUnYsNAAAA:8 a=KKAkSRfTAAAA:8
        a=lw-3Ehi1VaNlIoHz8JQA:9 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
        a=cvBusfyB2V15izCimMoJ:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 07:00:10PM +0000, Lee Jones wrote:
> The comment about them (also removed) says:
> 
>  /* fb_rsrc and aper_rsrc aren't really used currently, but still exist
>   * in case we decide we need information on the BAR for BSD in the
>   * future.
>   */
> 
> Well that was written 12 years ago in 2008.  We are now in the future
> and they are still superfluous.  We can always add them again at a
> later date if they are ever required.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/savage/savage_bci.c: In function ‘savage_driver_firstopen’:
>  drivers/gpu/drm/savage/savage_bci.c:580:24: warning: variable ‘aper_rsrc’ set but not used [-Wunused-but-set-variable]
>  drivers/gpu/drm/savage/savage_bci.c:580:15: warning: variable ‘fb_rsrc’ set but not used [-Wunused-but-set-variable]
> 
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Thanks, applied to drm-misc-next.

        Sam

