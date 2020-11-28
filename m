Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3BD2C717F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391189AbgK1VwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:52:12 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:44830 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732153AbgK1S7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:59:10 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 5D02C2003A;
        Sat, 28 Nov 2020 19:58:22 +0100 (CET)
Date:   Sat, 28 Nov 2020 19:58:20 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/ingenic: Add basic PM support
Message-ID: <20201128185820.GA1001988@ravnborg.org>
References: <20201128171606.132830-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128171606.132830-1-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=7gkXJVJtAAAA:8
        a=_LUwhb1OVfxuG1nTQZAA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Sat, Nov 28, 2020 at 05:16:06PM +0000, Paul Cercueil wrote:
> Call drm_mode_config_helper_suspend() and
> drm_mode_config_helper_resume() on suspend and resume, respectively.
> 
> This makes sure that the display stack is properly disabled when the
> hardware is put to sleep.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

As discussed on irc, with resume fixed to return the result of the
drm_mode_config_helper_resume() call.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
