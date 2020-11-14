Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8FB2B3024
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 20:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgKNT1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 14:27:45 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:56072 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgKNT1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 14:27:44 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 76A93804B4;
        Sat, 14 Nov 2020 20:27:42 +0100 (CET)
Date:   Sat, 14 Nov 2020 20:27:41 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 13/40] drm/panel/panel-tpo-tpg110: Correct misnaming and
 supply missing param description
Message-ID: <20201114192741.GC3797389@ravnborg.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-14-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113134938.4004947-14-lee.jones@linaro.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=7gkXJVJtAAAA:8
        a=e5mUnYsNAAAA:8 a=w_2A2TIFj400J4mqsGYA:9 a=CjuIK1q_8ugA:10
        a=cvBusfyB2V15izCimMoJ:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,
On Fri, Nov 13, 2020 at 01:49:11PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/panel/panel-tpo-tpg110.c:94: warning: Function parameter or member 'panel_mode' not described in 'tpg110'
>  drivers/gpu/drm/panel/panel-tpo-tpg110.c:372: warning: Function parameter or member 'connector' not described in 'tpg110_get_modes'
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Thanks, applied to drm-misc-next. Only one warning left in drm/panel/,
which I will submit a patch for in a minute.

	Sam
