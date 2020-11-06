Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7C32AA053
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 23:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgKFWXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 17:23:17 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:43524 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgKFWXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 17:23:11 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 5F16E2006F;
        Fri,  6 Nov 2020 23:23:07 +0100 (CET)
Date:   Fri, 6 Nov 2020 23:23:06 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        by <jhartmann@precisioninsight.com>, Faith <faith@valinux.com>,
        dri-devel@lists.freedesktop.org,
        Keith Whitwell <keith@tungstengraphics.com>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>
Subject: Re: [PATCH 04/19] drm/mga/mga_dma: Demote kernel-doc abusers to
 standard comment blocks
Message-ID: <20201106222306.GB826715@ravnborg.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106214949.2042120-5-lee.jones@linaro.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=UyPj0cawAAAA:8 a=UYoTZ2hgAAAA:8 a=977SQLHdAAAA:8
        a=e5mUnYsNAAAA:8 a=KKAkSRfTAAAA:8 a=79bEBMrwVnvcwRRDuU8A:9
        a=CjuIK1q_8ugA:10 a=Y6pI1GxSO5a61sAuGrKI:22 a=V6L1DCqn-8WKw3iEt1hp:22
        a=X9mgP9w9NIdro0Z1KHhB:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=cvBusfyB2V15izCimMoJ:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 09:49:34PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/mga/mga_dma.c:29: warning: Cannot understand  * file mga_dma.c
>  drivers/gpu/drm/mga/mga_dma.c:455: warning: Function parameter or member 'dev' not described in 'mga_do_agp_dma_bootstrap'
>  drivers/gpu/drm/mga/mga_dma.c:455: warning: Function parameter or member 'dma_bs' not described in 'mga_do_agp_dma_bootstrap'
>  drivers/gpu/drm/mga/mga_dma.c:629: warning: Function parameter or member 'dev' not described in 'mga_do_pci_dma_bootstrap'
>  drivers/gpu/drm/mga/mga_dma.c:629: warning: Function parameter or member 'dma_bs' not described in 'mga_do_pci_dma_bootstrap'
>  drivers/gpu/drm/mga/mga_dma.c:1150: warning: Function parameter or member 'dev' not described in 'mga_driver_unload'
>  drivers/gpu/drm/mga/mga_dma.c:1159: warning: Function parameter or member 'dev' not described in 'mga_driver_lastclose'
> 
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: by <jhartmann@precisioninsight.com>
> Cc: Faith <faith@valinux.com>
> Cc: Jeff Hartmann <jhartmann@valinux.com>
> Cc: Keith Whitwell <keith@tungstengraphics.com>
> Cc: Gareth Hughes <gareth@valinux.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Thanks, apllied to drm-misc-next.

	Sam
