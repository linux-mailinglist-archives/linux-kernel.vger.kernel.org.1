Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A72B0E10
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgKLT3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:29:51 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:41814 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKLT3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:29:51 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 49DAE20023;
        Thu, 12 Nov 2020 20:29:49 +0100 (CET)
Date:   Thu, 12 Nov 2020 20:29:48 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 17/30] drm/atmel-hlcdc/atmel_hlcdc_plane: Fix
 documentation formatting and add missing description
Message-ID: <20201112192948.GC3287572@ravnborg.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
 <20201112190039.2785914-18-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201112190039.2785914-18-lee.jones@linaro.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=7gkXJVJtAAAA:8 a=VwQbUJbxAAAA:8 a=XYAwZIGsAAAA:8
        a=P-IC7800AAAA:8 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
        a=KdOmdPirR01RspIZuJ8A:9 a=QEXdDO2ut3YA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=AjGcO6oz07-iQ99wixmX:22 a=E8ToXWR_bxluHZ7gmE-Z:22
        a=d3PnA9EDa4IxuAV0gXij:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=1CNFftbPRP8L7MoqJWF3:22 a=cvBusfyB2V15izCimMoJ:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 07:00:26PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c:283:6: warning: no previous prototype for ‘atmel_hlcdc_plane_setup_scaler’ [-Wmissing-prototypes]
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c:44: warning: cannot understand function prototype: 'struct atmel_hlcdc_plane_state '
> 
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Boris Brezillon <bbrezillon@kernel.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Thanks, applied to drm-misc-next.

        Sam

