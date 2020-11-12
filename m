Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF122B0EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgKLUWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:22:09 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:47186 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgKLUWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:22:08 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id D4ACB20023;
        Thu, 12 Nov 2020 21:22:05 +0100 (CET)
Date:   Thu, 12 Nov 2020 21:22:04 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Vincent Abriou <vincent.abriou@st.com>
Subject: Re: [PATCH 27/30] drm/sti/sti_hdmi: Move 'colorspace_mode_names'
 array to where its used
Message-ID: <20201112202204.GE3287572@ravnborg.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
 <20201112190039.2785914-28-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201112190039.2785914-28-lee.jones@linaro.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=KKAkSRfTAAAA:8 a=8b9GpE9nAAAA:8 a=e5mUnYsNAAAA:8
        a=sZ_kP7L1YpjpdGNb6c8A:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
        a=T3LWEMljR5ZiDmsYVIUa:22 a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,
On Thu, Nov 12, 2020 at 07:00:36PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/sti/sti_hdmi.h:36:40: warning: ‘colorspace_mode_names’ defined but not used [-Wunused-const-variable=]
>  36 | static const struct drm_prop_enum_list colorspace_mode_names[] = {
>  | ^~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Vincent Abriou <vincent.abriou@st.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to drm-misc-next,

	Sam
