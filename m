Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BE82889FE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbgJINtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732677AbgJINtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:49:06 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0304B222B9;
        Fri,  9 Oct 2020 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602251345;
        bh=wl1fuI8lefh+3YsVxao7a3dyyLNUQhlLz4oNgzuFbLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVGWz6bscyAd1Q327E060Iz1w2Nr7nAKiIC7kTgVLRveWqIs/oKeRRovqVDW0jBJV
         tTVFadyniJetltJn8E2xB4ij52UJMud3O6wIH21iOKxycc7XLZg+kvK9HzImLrXdU3
         3WC9lAOb/e2eKvKZWOThK0VmDWL/eqUi7NhYl1wI=
Date:   Fri, 9 Oct 2020 08:54:30 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] amd/amdgpu_ctx: Use struct_size() helper and
 kmalloc()
Message-ID: <20201009135430.GA31347@embeddedor>
References: <20201008143450.GA23077@embeddedor>
 <4fe00048-2612-39f3-29bb-c9424000f836@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fe00048-2612-39f3-29bb-c9424000f836@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 09:08:51AM +0200, Christian König wrote:
> Am 08.10.20 um 16:34 schrieb Gustavo A. R. Silva:
> > Make use of the new struct_size() helper instead of the offsetof() idiom.
> > Also, use kmalloc() instead of kcalloc().
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > index c80d8339f58c..5be125f3b92a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > @@ -100,7 +100,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
> >   	enum drm_sched_priority priority;
> >   	int r;
> > -	entity = kcalloc(1, offsetof(typeof(*entity), fences[amdgpu_sched_jobs]),
> > +	entity = kmalloc(struct_size(entity, fences, amdgpu_sched_jobs),
> 
> NAK. You could use kzalloc() here, but kmalloc won't zero initialize the
> memory which could result in unforeseen consequences.

Oh I see.. I certainly didn't take that into account.

I'll fix that up and respin.

Thanks
--
Gustavo
