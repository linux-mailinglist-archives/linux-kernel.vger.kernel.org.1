Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3417923D3DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 00:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgHEWTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 18:19:44 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:55982 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725830AbgHEWTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 18:19:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B1F10182251C0;
        Wed,  5 Aug 2020 22:19:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3872:4041:4321:4605:5007:7576:10004:10400:10848:11026:11232:11233:11657:11658:11914:12043:12050:12296:12297:12438:12555:12740:12760:12895:12986:13069:13095:13311:13357:13439:14181:14659:14721:21080:21365:21433:21627:21990:30054:30064:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: soup01_4f0d84926fb2
X-Filterd-Recvd-Size: 3359
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Aug 2020 22:19:40 +0000 (UTC)
Message-ID: <d720b466a2b4b7507a963f9a2605c7f81e82e7ba.camel@perches.com>
Subject: Re: [PATCH] drm/amdgpu: fix spelling mistake "Falied" -> "Failed"
From:   Joe Perches <joe@perches.com>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Aug 2020 15:19:38 -0700
In-Reply-To: <CADnq5_P9hfv=Zt9+m47sFC0z202x+q-Otifv7a5z4afJamtQ2Q@mail.gmail.com>
References: <20200805113510.18277-1-colin.king@canonical.com>
         <CADnq5_NA9f2N3xkH4WAdDEP+0-5W0LkmTRy3yXqFdnWQmfsVmQ@mail.gmail.com>
         <a8ab7d75ef9df54bd193fc88e0670b30026e7e67.camel@perches.com>
         <CADnq5_P9hfv=Zt9+m47sFC0z202x+q-Otifv7a5z4afJamtQ2Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-05 at 17:27 -0400, Alex Deucher wrote:
> On Wed, Aug 5, 2020 at 4:53 PM Joe Perches <joe@perches.com> wrote:
> > On Wed, 2020-08-05 at 16:01 -0400, Alex Deucher wrote:
> > > On Wed, Aug 5, 2020 at 7:35 AM Colin King <colin.king@canonical.com> wrote:
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > > 
> > > > There is a spelling mistake in a DRM_ERROR message. Fix it.
> > > > 
> > > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > 
> > > This is already fixed.
> > 
> > This fix is not in today's -next.
> > 
> > Perhaps whatever tree it's fixed in should be in -next.
> > 
> 
> Weird.  It's in the drm-next tree as:
> 
> commit 4afaa61db9cf5250b5734c2531b226e7b3a3d691
> Author: Colin Ian King <colin.king@canonical.com>
> Date:   Fri Jul 10 09:37:58 2020 +0100
> 
>     drm/amdgpu: fix spelling mistake "Falied" -> "Failed"
> 
>     There is a spelling mistake in a DRM_ERROR error message. Fix it.
> 
>     Signed-off-by: Colin Ian King <colin.king@canonical.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Alex
> 
> > $ git show --oneline -s
> > d15fe4ec0435 (HEAD, tag: next-20200805, origin/master, origin/HEAD) Add linux-next specific files for 20200805
> > 
> > $ git grep -i falied drivers
> > drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:                DRM_ERROR("Falied to terminate tmr\n");
> > 
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > []
> > > > @@ -2010,7 +2010,7 @@ static int psp_suspend(void *handle)
> > > > 
> > > >         ret = psp_tmr_terminate(psp);
> > > >         if (ret) {
> > > > -               DRM_ERROR("Falied to terminate tmr\n");
> > > > +               DRM_ERROR("Failed to terminate tmr\n");
> > > >                 return ret;
> > > >         }

Dunno.

Maybe it's due to some ordering of trees in
how -next accumulates patches?


