Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEC429178F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 15:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgJRNB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 09:01:26 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:48222 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgJRNB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 09:01:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id F17FDFB03;
        Sun, 18 Oct 2020 15:01:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vS3LHYXK4BBc; Sun, 18 Oct 2020 15:01:22 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 983B2420E6; Sun, 18 Oct 2020 15:01:22 +0200 (CEST)
Date:   Sun, 18 Oct 2020 15:01:22 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm/panel: mantix panel reset fixes
Message-ID: <20201018130122.GA3705@bogon.m.sigxcpu.org>
References: <cover.1602584953.git.agx@sigxcpu.org>
 <20201016142916.GA1184974@ravnborg.org>
 <20201017091307.GA2885@bogon.m.sigxcpu.org>
 <20201017104736.GA2822081@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201017104736.GA2822081@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,
On Sat, Oct 17, 2020 at 12:47:36PM +0200, Sam Ravnborg wrote:
> Hi Guido.
> 
> On Sat, Oct 17, 2020 at 11:13:07AM +0200, Guido Günther wrote:
> > Hi Sam,
> > On Fri, Oct 16, 2020 at 04:29:16PM +0200, Sam Ravnborg wrote:
> > > Hi Guido.
> > > On Tue, Oct 13, 2020 at 12:32:45PM +0200, Guido Günther wrote:
> > [..snip..]
> > > > 
> > > > Changes from v1:
> > > >  - As per review comments by Fabio Estevam
> > > >    https://lore.kernel.org/dri-devel/CAOMZO5B5ECcConvKej=RcaF8wvOxgq7nUzKJ-ad0aSAOzUqtbQ@mail.gmail.com/
> > > >    - Fix typo in commit messages
> > > >  - As per review comments by Rob Herring
> > > >    https://lore.kernel.org/dri-devel/20200929174624.GA832332@bogus/
> > > >    - Don't use an array of reset lines
> > > > 
> > > > Guido Günther (3):
> > > >   drm/panel: mantix: Don't dereference NULL mode
> > > >   drm/panel: mantix: Fix panel reset
> > > >   dt-binding: display: Require two resets on mantix panel
> > > 
> > > All applied to drm-misc-next and pushed out.
> > > And then I remembered you had commit right - sigh.
> > 
> > Thanks! Is there any special care needed to get that into 5.10? The
> > driver landed there in 72967d5616d3f0c714f8eb6c4e258179a9031c45.
> 
> As the patches was applied to drm-misc-next the easiet path would
> be to cherry-pick them and apply to drm-misc-fixes.
> dim has cherry-pick support - try to use it rahter than doing it by
> hand.

Does that require any further ACKs or just cherry-pick and push out?

> When you apply to drm-misc-fixes include a Fixes: tag so the tooling
> will pick the patches automagically.

Will do. It was unfortunate that the initial ones didn't get them but
i think the drm merge happened while v2 was out on the list. I'll try
add that relevant information to the cover letter in the future.

Cheers,
 -- Guido

> 
> In hindsight the patches should have carried a Fixes: tag from a start
> and should have been applied to drm-misc-fixes from a start too.
> 
> I have done something like above once or twice but anyway reach out if
> you have questions. Or ask at #dri-devel.
> 
> 	Sam
> 
