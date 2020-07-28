Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445792313BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 22:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgG1URl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 16:17:41 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:33902 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgG1URl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:17:41 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id AAA7A2003E;
        Tue, 28 Jul 2020 22:17:37 +0200 (CEST)
Date:   Tue, 28 Jul 2020 22:17:36 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] Small cleanups to ingenic-drm driver
Message-ID: <20200728201736.GA1277651@ravnborg.org>
References: <20200728151641.26124-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728151641.26124-1-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8
        a=ka3XCdlgjjhfOtT7UF0A:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Tue, Jul 28, 2020 at 05:16:39PM +0200, Paul Cercueil wrote:
> Here are a few cleanups to the ingenic-drm driver.
> - some error paths were missing and have been added;
> - the mode validation has been moved to the .mode_valid helper callback.
> 
> Cheers,
> -Paul
> 
> Paul Cercueil (2):
>   drm/ingenic: Handle errors of drm_atomic_get_plane_state
>   drm/ingenic: Validate mode in a .mode_valid callback

Both looks fine, you can add my:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I assume you will apply the patches.
Maybe wait for Daniel to take a look, he had some feedback on where
to add checks. I assume this is covered by the second patch.

	Sam

> 
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 41 +++++++++++++++--------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
