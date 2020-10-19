Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E2729299E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgJSOjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:39:48 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:50458 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbgJSOjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:39:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 03021FB03;
        Mon, 19 Oct 2020 16:39:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xiKoeGkOLVvO; Mon, 19 Oct 2020 16:39:44 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 435AF420E6; Mon, 19 Oct 2020 16:39:44 +0200 (CEST)
Date:   Mon, 19 Oct 2020 16:39:44 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/3] drm/panel: mantix panel reset fixes
Message-ID: <20201019143944.GA52950@bogon.m.sigxcpu.org>
References: <cover.1602584953.git.agx@sigxcpu.org>
 <20201016142916.GA1184974@ravnborg.org>
 <20201017091307.GA2885@bogon.m.sigxcpu.org>
 <20201017104736.GA2822081@ravnborg.org>
 <20201018130122.GA3705@bogon.m.sigxcpu.org>
 <20201018133845.GA361365@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201018133845.GA361365@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sun, Oct 18, 2020 at 03:38:45PM +0200, Sam Ravnborg wrote:
>  Hi Guido
> > On Sun, Oct 18, 2020 at 03:01:22PM +0200, Guido Günther wrote:
> > Hi Sam,
> > On Sat, Oct 17, 2020 at 12:47:36PM +0200, Sam Ravnborg wrote:
> > > Hi Guido.
> > > 
> > > On Sat, Oct 17, 2020 at 11:13:07AM +0200, Guido Günther wrote:
> > > > Hi Sam,
> > > > On Fri, Oct 16, 2020 at 04:29:16PM +0200, Sam Ravnborg wrote:
> > > > > Hi Guido.
> > > > > On Tue, Oct 13, 2020 at 12:32:45PM +0200, Guido Günther wrote:
> > > > [..snip..]
> > > > > > 
> > > > > > Changes from v1:
> > > > > >  - As per review comments by Fabio Estevam
> > > > > >    https://lore.kernel.org/dri-devel/CAOMZO5B5ECcConvKej=RcaF8wvOxgq7nUzKJ-ad0aSAOzUqtbQ@mail.gmail.com/
> > > > > >    - Fix typo in commit messages
> > > > > >  - As per review comments by Rob Herring
> > > > > >    https://lore.kernel.org/dri-devel/20200929174624.GA832332@bogus/
> > > > > >    - Don't use an array of reset lines
> > > > > > 
> > > > > > Guido Günther (3):
> > > > > >   drm/panel: mantix: Don't dereference NULL mode
> > > > > >   drm/panel: mantix: Fix panel reset
> > > > > >   dt-binding: display: Require two resets on mantix panel
> > > > > 
> > > > > All applied to drm-misc-next and pushed out.
> > > > > And then I remembered you had commit right - sigh.
> > > > 
> > > > Thanks! Is there any special care needed to get that into 5.10? The
> > > > driver landed there in 72967d5616d3f0c714f8eb6c4e258179a9031c45.
> > > 
> > > As the patches was applied to drm-misc-next the easiet path would
> > > be to cherry-pick them and apply to drm-misc-fixes.
> > > dim has cherry-pick support - try to use it rahter than doing it by
> > > hand.
> > 
> > Does that require any further ACKs or just cherry-pick and push out?
> To the best of my knowledge just cherry-pick, test and push out.

drm-misc-fixes does not yet have the corresponding code so i assume i
have to wait for back merge of 5.10-rc1 ? At least

   https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html

seems to indicate that.
Cheers,
 -- Guido

> 
> 	Sam
> 
> > 
> > > When you apply to drm-misc-fixes include a Fixes: tag so the tooling
> > > will pick the patches automagically.
> > 
> > Will do. It was unfortunate that the initial ones didn't get them but
> > i think the drm merge happened while v2 was out on the list. I'll try
> > add that relevant information to the cover letter in the future.
> > 
> > Cheers,
> >  -- Guido
> > 
> > > 
> > > In hindsight the patches should have carried a Fixes: tag from a start
> > > and should have been applied to drm-misc-fixes from a start too.
> > > 
> > > I have done something like above once or twice but anyway reach out if
> > > you have questions. Or ask at #dri-devel.
> > > 
> > > 	Sam
> > > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
