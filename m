Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EEA2B4275
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgKPLSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:18:55 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:37742 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbgKPLSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:18:55 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 86E0720056;
        Mon, 16 Nov 2020 12:18:51 +0100 (CET)
Date:   Mon, 16 Nov 2020 12:18:50 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 12/40] drm/pl111/pl111_display: Make local function static
Message-ID: <20201116111850.GA68743@ravnborg.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-13-lee.jones@linaro.org>
 <20201114191127.GB3797389@ravnborg.org>
 <20201116084023.GL3718728@dell>
 <20201116101734.GA65688@ravnborg.org>
 <20201116102530.GN3718728@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201116102530.GN3718728@dell>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=-VAfIpHNAAAA:8 a=e5mUnYsNAAAA:8 a=KKAkSRfTAAAA:8
        a=VwQbUJbxAAAA:8 a=xQzvdHlxAAAA:20 a=YYAp68AnUQjD0k_29DoA:9
        a=QEXdDO2ut3YA:10 a=srlwD-8ojaedGGhPAyx8:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,
On Mon, Nov 16, 2020 at 10:25:30AM +0000, Lee Jones wrote:
> On Mon, 16 Nov 2020, Sam Ravnborg wrote:
> 
> > Hi Lee,
> > On Mon, Nov 16, 2020 at 08:40:23AM +0000, Lee Jones wrote:
> > > On Sat, 14 Nov 2020, Sam Ravnborg wrote:
> > > 
> > > > Hi Lee,
> > > > On Fri, Nov 13, 2020 at 01:49:10PM +0000, Lee Jones wrote:
> > > > > Fixes the following W=1 kernel build warning(s):
> > > > > 
> > > > >  drivers/gpu/drm/pl111/pl111_display.c:356:6: warning: no previous prototype for ‘pl111_display_disable’ [-Wmissing-prototypes]
> > > > > 
> > > > > Cc: Eric Anholt <eric@anholt.net>
> > > > > Cc: David Airlie <airlied@linux.ie>
> > > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > 
> > > > Eric's was not copied on this or the other pl111 patch.
> > > > Added Eric so he can be aware of this fix.
> > > 
> > > Eric Anholt?
> > > 
> > > He's on Cc?
> > Not on the original mail I received.
> 
> Looks fine to me:
> 
> Date: Fri, 13 Nov 2020 13:49:10 +0000
> From: Lee Jones <lee.jones@linaro.org>
> To: lee.jones@linaro.org
> Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org
> Subject: [PATCH 12/40] drm/pl111/pl111_display: Make local function static
> 
> Also reflected in Gmail:
> 
>  https://i.imgur.com/d69YTzz.png

Strange indeed. In lore Eric is not included:
https://lore.kernel.org/dri-devel/20201113134938.4004947-13-lee.jones@linaro.org/

I consider this a fluke in the force, and will not worry more about it.

	Sam
