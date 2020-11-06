Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1752AA054
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 23:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgKFWXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 17:23:34 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:43564 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbgKFWXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 17:23:31 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 9EDD020068;
        Fri,  6 Nov 2020 23:23:29 +0100 (CET)
Date:   Fri, 6 Nov 2020 23:23:28 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        by <jhartmann@precisioninsight.com>,
        dri-devel@lists.freedesktop.org,
        Keith Whitwell <keith@tungstengraphics.com>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>
Subject: Re: [PATCH 05/19] drm/mga/mga_state: Remove unused variable
 'buf_priv'
Message-ID: <20201106222328.GC826715@ravnborg.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-6-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106214949.2042120-6-lee.jones@linaro.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=UyPj0cawAAAA:8 a=UYoTZ2hgAAAA:8 a=977SQLHdAAAA:8
        a=e5mUnYsNAAAA:8 a=KKAkSRfTAAAA:8 a=gqZkrEa1Z6pZK_9Cb08A:9
        a=QEXdDO2ut3YA:10 a=Y6pI1GxSO5a61sAuGrKI:22 a=V6L1DCqn-8WKw3iEt1hp:22
        a=X9mgP9w9NIdro0Z1KHhB:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=cvBusfyB2V15izCimMoJ:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 09:49:35PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/mga/mga_state.c: In function ‘mga_dma_iload’:
>  drivers/gpu/drm/mga/mga_state.c:945:22: warning: variable ‘buf_priv’ set but not used [-Wunused-but-set-variable]
> 
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: by <jhartmann@precisioninsight.com>
> Cc: Jeff Hartmann <jhartmann@valinux.com>
> Cc: Keith Whitwell <keith@tungstengraphics.com>
> Cc: Gareth Hughes <gareth@valinux.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Likewise applied,

	Sam
