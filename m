Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA0D29FFC1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgJ3IYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3IYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:24:31 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A5E422253;
        Fri, 30 Oct 2020 08:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604046270;
        bh=gSmXKcEPU74GTRAjfSumqviFvknWDQc7X1JOOAmSq+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Si1Xp4kz2nZiduJ6OnRI3808vnUeGlBGzEWnvohCTFWiL8OcNDVlCtzhiiSyo7uzA
         KWQToIUK6uyhXgmnpE6atZe+J3Vo7O9puJespbTMC9te+eVnaZjc+YQgbIsXwNys2L
         dfWEeyNDkAPCuWamjOc+NQFyjoaE2fmTeWcsQD0Q=
Date:   Fri, 30 Oct 2020 09:25:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Deepak R Varma <mh12gx2825@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: Re: [Outreachy kernel] [PATCH] drm/amdgpu: use
 DEFINE_DEBUGFS_ATTRIBUTE with debugfs_create_file_unsafe()
Message-ID: <20201030082518.GB1619669@kroah.com>
References: <20201030032245.GA274478@my--box>
 <20201030071120.GA1493629@kroah.com>
 <20201030075716.GA6976@my--box>
 <5a7d8e8d-8db5-ff56-6448-3f1cefc11ef8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a7d8e8d-8db5-ff56-6448-3f1cefc11ef8@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 09:00:04AM +0100, Christian König wrote:
> Am 30.10.20 um 08:57 schrieb Deepak R Varma:
> > On Fri, Oct 30, 2020 at 08:11:20AM +0100, Greg KH wrote:
> > > On Fri, Oct 30, 2020 at 08:52:45AM +0530, Deepak R Varma wrote:
> > > > Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_unsafe()
> > > > function in place of the debugfs_create_file() function will make the
> > > > file operation struct "reset" aware of the file's lifetime. Additional
> > > > details here: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.archive.carbon60.com%2Flinux%2Fkernel%2F2369498&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Cddd7a6ac8164415a639708d87ca97004%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637396414464384011%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=o6GOHvMxNMuOPlC4nhDyURCHBLqfQZhYQq%2BiIMt3D3s%3D&amp;reserved=0
> > > > 
> > > > Issue reported by Coccinelle script:
> > > > scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> > > > 
> > > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > > > ---
> > > > Please Note: This is a Outreachy project task patch.
> > > > 
> > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 ++++++++++----------
> > > >   1 file changed, 10 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > index 2d125b8b15ee..f076b1ba7319 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > @@ -1551,29 +1551,29 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
> > > >   	return 0;
> > > >   }
> > > > -DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
> > > > -			amdgpu_debugfs_ib_preempt, "%llu\n");
> > > > +DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
> > > > +			 amdgpu_debugfs_ib_preempt, "%llu\n");
> > > Are you sure this is ok?  Do these devices need this additional
> > > "protection"?  Do they have the problem that these macros were written
> > > for?
> > > 
> > > Same for the other patches you just submitted here, I think you need to
> > > somehow "prove" that these changes are necessary, checkpatch isn't able
> > > to determine this all the time.
> > Hi Greg,
> > Based on my understanding, the current function debugfs_create_file()
> > adds an overhead of lifetime managing proxy for such fop structs. This
> > should be applicable to these set of drivers as well. Hence I think this
> > change will be useful.
> 
> Well since this is only created once per device instance I don't really care
> about this little overhead.
> 
> But what exactly is debugfs doing or not doing here?

It is trying to save drivers from having debugfs files open that point
to memory that can go away at any time.  For graphics devices, I doubt
that is the case.

thanks,

greg k-h
