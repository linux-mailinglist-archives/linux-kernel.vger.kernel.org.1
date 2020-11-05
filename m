Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E4A2A88CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbgKEVRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:17:46 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:34168 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:17:46 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id E0F5520068;
        Thu,  5 Nov 2020 22:17:43 +0100 (CET)
Date:   Thu, 5 Nov 2020 22:17:42 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 16/19] gpu: drm: panel: panel-ilitek-ili9322: Demote
 non-conformant kernel-doc header
Message-ID: <20201105211742.GD216923@ravnborg.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-17-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105144517.1826692-17-lee.jones@linaro.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8 a=KKAkSRfTAAAA:8
        a=e5mUnYsNAAAA:8 a=-dKZvmfMDusZ7wBAw4gA:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=cvBusfyB2V15izCimMoJ:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee.

On Thu, Nov 05, 2020 at 02:45:14PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_SRGB_THROUGH' not described in enum 'ili9322_input'
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_SRGB_ALIGNED' not described in enum 'ili9322_input'
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_SRGB_DUMMY_320X240' not described in enum 'ili9322_input'
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_SRGB_DUMMY_360X240' not described in enum 'ili9322_input'
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_DISABLED_1' not described in enum 'ili9322_input'
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_PRGB_THROUGH' not described in enum 'ili9322_input'
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_PRGB_ALIGNED' not described in enum 'ili9322_input'
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_YUV_640X320_YCBCR' not described in enum 'ili9322_input'
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_YUV_720X360_YCBCR' not described in enum 'ili9322_input'
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_DISABLED_2' not described in enum 'ili9322_input'
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_ITU_R_BT656_720X360_YCBCR' not described in enum 'ili9322_input'
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_ITU_R_BT656_640X320_YCBCR' not described in enum 'ili9322_input'
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c:177: warning: Enum value 'ILI9322_INPUT_UNKNOWN' not described in enum 'ili9322_input'
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to drm-misc-next.

	Sam
