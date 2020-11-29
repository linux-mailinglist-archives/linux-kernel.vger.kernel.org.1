Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24CA2C7B86
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 23:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgK2WAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 17:00:15 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:40618 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgK2WAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 17:00:15 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 9B40C20034;
        Sun, 29 Nov 2020 22:59:27 +0100 (CET)
Date:   Sun, 29 Nov 2020 22:59:26 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/3] drm/ingenic: Add support for delta-RGB panels
Message-ID: <20201129215926.GF1162850@ravnborg.org>
References: <20201119155559.14112-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119155559.14112-1-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=jAYXITO5OE7wJCMQ_rkA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Thu, Nov 19, 2020 at 03:55:56PM +0000, Paul Cercueil wrote:
> Hi,
> 
> This patchset adds support for delta-RGB panels to the ingenic-drm
> driver. Delta-RGB panels have diamond-pattern subpixel layout, and
> expect odd lines to have RGB subpixel ordering, and even lines to have
> GBR subpixel ordering.
> 
> Such panel is used in the YLM (aka. Anbernic) RG-99, RG-300, RG-280M
> and RG-280V handheld gaming consoles.
> 
> Cheers,
> -Paul
> 
> Paul Cercueil (3):
>   drm/ingenic: Compute timings according to adjusted_mode->crtc_*
>   drm/ingenic: Properly compute timings when using a 3x8-bit panel
>   drm/ingenic: Add support for serial 8-bit delta-RGB panels

Strange panel, at least strange bit order.
Patches looks good and are all:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
