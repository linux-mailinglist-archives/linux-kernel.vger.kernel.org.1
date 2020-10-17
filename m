Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1701A29117B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 12:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437385AbgJQKro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 06:47:44 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:37362 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437227AbgJQKrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 06:47:42 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id ECE2E2001E;
        Sat, 17 Oct 2020 12:47:37 +0200 (CEST)
Date:   Sat, 17 Oct 2020 12:47:36 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm/panel: mantix panel reset fixes
Message-ID: <20201017104736.GA2822081@ravnborg.org>
References: <cover.1602584953.git.agx@sigxcpu.org>
 <20201016142916.GA1184974@ravnborg.org>
 <20201017091307.GA2885@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201017091307.GA2885@bogon.m.sigxcpu.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=S433PrkP c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
        a=PFafjgERKE-Fj2KKUhgA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.

On Sat, Oct 17, 2020 at 11:13:07AM +0200, Guido Günther wrote:
> Hi Sam,
> On Fri, Oct 16, 2020 at 04:29:16PM +0200, Sam Ravnborg wrote:
> > Hi Guido.
> > On Tue, Oct 13, 2020 at 12:32:45PM +0200, Guido Günther wrote:
> [..snip..]
> > > 
> > > Changes from v1:
> > >  - As per review comments by Fabio Estevam
> > >    https://lore.kernel.org/dri-devel/CAOMZO5B5ECcConvKej=RcaF8wvOxgq7nUzKJ-ad0aSAOzUqtbQ@mail.gmail.com/
> > >    - Fix typo in commit messages
> > >  - As per review comments by Rob Herring
> > >    https://lore.kernel.org/dri-devel/20200929174624.GA832332@bogus/
> > >    - Don't use an array of reset lines
> > > 
> > > Guido Günther (3):
> > >   drm/panel: mantix: Don't dereference NULL mode
> > >   drm/panel: mantix: Fix panel reset
> > >   dt-binding: display: Require two resets on mantix panel
> > 
> > All applied to drm-misc-next and pushed out.
> > And then I remembered you had commit right - sigh.
> 
> Thanks! Is there any special care needed to get that into 5.10? The
> driver landed there in 72967d5616d3f0c714f8eb6c4e258179a9031c45.

As the patches was applied to drm-misc-next the easiet path would
be to cherry-pick them and apply to drm-misc-fixes.
dim has cherry-pick support - try to use it rahter than doing it by
hand.

When you apply to drm-misc-fixes include a Fixes: tag so the tooling
will pick the patches automagically.

In hindsight the patches should have carried a Fixes: tag from a start
and should have been applied to drm-misc-fixes from a start too.

I have done something like above once or twice but anyway reach out if
you have questions. Or ask at #dri-devel.

	Sam
