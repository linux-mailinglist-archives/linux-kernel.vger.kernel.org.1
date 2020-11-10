Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19122AD1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgKJI5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:57:05 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:48830 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJI5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:57:05 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 09C9F20038;
        Tue, 10 Nov 2020 09:56:59 +0100 (CET)
Date:   Tue, 10 Nov 2020 09:56:58 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ingenic: ipu: Search for scaling coefs up to 102%
 of?? the screen
Message-ID: <20201110085658.GA2027451@ravnborg.org>
References: <20201105083905.8780-1-paul@crapouillou.net>
 <20201107193311.GB1039949@ravnborg.org>
 <YJOKJQ.8KD9M5MU0NTP2@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YJOKJQ.8KD9M5MU0NTP2@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=7gkXJVJtAAAA:8 a=ER_8r6IbAAAA:8
        a=9CIfjzEbJXW8LZeqSngA:9 a=wPNLvfGTeEIA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=9LHmKk7ezEChjTCyhBa9:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,
On Tue, Nov 10, 2020 at 08:50:22AM +0000, Paul Cercueil wrote:
> Hi,
> 
> Le sam. 7 nov. 2020 � 20:33, Sam Ravnborg <sam@ravnborg.org> a �crit :
> > Hi Paul.
> > 
> > On Thu, Nov 05, 2020 at 08:39:05AM +0000, Paul Cercueil wrote:
> > >  Increase the scaled image's theorical width/height until we find a
> > >  configuration that has valid scaling coefficients, up to 102% of the
> > >  screen's resolution. This makes sure that we can scale from almost
> > >  every resolution possible at the cost of a very small distorsion.
> > >  The CRTC_W / CRTC_H are not modified.
> > > 
> > >  This algorithm was already in place but would not try to go above
> > > the
> > >  screen's resolution, and as a result would only work if the CRTC_W /
> > >  CRTC_H were smaller than the screen resolution. It will now try
> > > until it
> > >  reaches 102% of the screen's resolution.
> > > 
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > 
> > Looks like the patch does what the descriptions says.
> > So in other words - look OK to me. I am not confident enogh for a r-b
> > but my code reading is enough to warrant an a-b:
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Note that this algorithm exists mostly as a band-aid for a missing
> functionality: it is not possible for userspace to request the closest mode
> that would encapsulate the provided one, because the GEM buffer is created
> beforehand. If there was a way to let the kernel tweak the mode, I could
> write a better algorithm that would result in a better looking picture.

Could you add this nice explanation to the changelog so when we wonder
why this was done in some years we can dig up this from git history.

	Sam
