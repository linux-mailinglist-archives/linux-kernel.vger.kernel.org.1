Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61B42A015E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgJ3JZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgJ3JZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:25:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AE7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:25:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c16so2272339wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lr95YjmxfBMQgyUuKRsKu2us1sAP1mxiJZKWtC6RQLE=;
        b=J7c4uO3oFnVEICxe8V4NrJjJtpvezAbH4Hnr1BGHvgDeOFSERTJJk/DwplkhhnEqy9
         gsk0k8raBxS9hZRbzo+tr8t9Dk5T6j0noOY+90TyNK1xWKM0eZMyQJIHckNemEjavWGJ
         dH6rskih7R8r2jYNF4tDicyiGmBFKIxSwmTag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=lr95YjmxfBMQgyUuKRsKu2us1sAP1mxiJZKWtC6RQLE=;
        b=QKVPY68eaJpA9a3PSbtAfxNT9QOOpvdYq5f6JXmkHCXN/FiohAN4h/JYkdbmoadk6d
         o892A2Ev2b1YMLLycukVQP4AFPBT82gjGuwYfi9Pi8848H1wv2ZL1l+Nfhr7r6Mo4r9+
         FjtP9TDj9PNmeAmbwjbRb2GHf/lUbr/tIm6ATQ3HdzUcqzVPsvBSONTRBHVxHNAiCjzP
         lToFHDHm2DWh14UCIy2jZP/tOchxaW1ce8980LygA+k1xgnog91ttjrenDgbY093JYou
         Z6VS2mwaGPkE3oW7j2w/DVMwCTMg+frcWauj0bhIkTIRgdNRRvPevnW5cDYEa351OEmb
         TLzQ==
X-Gm-Message-State: AOAM530NHNeipuAwg1bW8F2hBN2DTEUJtJtMkjB9p16doDlCHynuzrML
        L1JH2xl2xhSOCcDd335iFyBamw==
X-Google-Smtp-Source: ABdhPJzCjMEsph+rgXwaN/TbnJTQc9xZPv4MlevNFQZPghkhmWJxtTUdg+b4UkW0Zd6TJSzHqwwt0w==
X-Received: by 2002:a05:600c:218a:: with SMTP id e10mr1482019wme.7.1604049900279;
        Fri, 30 Oct 2020 02:25:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t1sm9436244wrs.48.2020.10.30.02.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 02:24:59 -0700 (PDT)
Date:   Fri, 30 Oct 2020 10:24:57 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        melissa.srw@gmail.com
Subject: Re: [Outreachy kernel] [PATCH] drm/amdgpu: use
 DEFINE_DEBUGFS_ATTRIBUTE with debugfs_create_file_unsafe()
Message-ID: <20201030092457.GI401619@phenom.ffwll.local>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        melissa.srw@gmail.com
References: <20201030032245.GA274478@my--box>
 <20201030071120.GA1493629@kroah.com>
 <20201030075716.GA6976@my--box>
 <5a7d8e8d-8db5-ff56-6448-3f1cefc11ef8@amd.com>
 <20201030082518.GB1619669@kroah.com>
 <20201030091521.GH401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201030091521.GH401619@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:15:21AM +0100, Daniel Vetter wrote:
> On Fri, Oct 30, 2020 at 09:25:18AM +0100, Greg KH wrote:
> > On Fri, Oct 30, 2020 at 09:00:04AM +0100, Christian König wrote:
> > > Am 30.10.20 um 08:57 schrieb Deepak R Varma:
> > > > On Fri, Oct 30, 2020 at 08:11:20AM +0100, Greg KH wrote:
> > > > > On Fri, Oct 30, 2020 at 08:52:45AM +0530, Deepak R Varma wrote:
> > > > > > Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_unsafe()
> > > > > > function in place of the debugfs_create_file() function will make the
> > > > > > file operation struct "reset" aware of the file's lifetime. Additional
> > > > > > details here: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.archive.carbon60.com%2Flinux%2Fkernel%2F2369498&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Cddd7a6ac8164415a639708d87ca97004%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637396414464384011%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=o6GOHvMxNMuOPlC4nhDyURCHBLqfQZhYQq%2BiIMt3D3s%3D&amp;reserved=0
> > > > > > 
> > > > > > Issue reported by Coccinelle script:
> > > > > > scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> > > > > > 
> > > > > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > > > > > ---
> > > > > > Please Note: This is a Outreachy project task patch.
> > > > > > 
> > > > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 ++++++++++----------
> > > > > >   1 file changed, 10 insertions(+), 10 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > > index 2d125b8b15ee..f076b1ba7319 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > > @@ -1551,29 +1551,29 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
> > > > > >   	return 0;
> > > > > >   }
> > > > > > -DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
> > > > > > -			amdgpu_debugfs_ib_preempt, "%llu\n");
> > > > > > +DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
> > > > > > +			 amdgpu_debugfs_ib_preempt, "%llu\n");
> > > > > Are you sure this is ok?  Do these devices need this additional
> > > > > "protection"?  Do they have the problem that these macros were written
> > > > > for?
> > > > > 
> > > > > Same for the other patches you just submitted here, I think you need to
> > > > > somehow "prove" that these changes are necessary, checkpatch isn't able
> > > > > to determine this all the time.
> > > > Hi Greg,
> > > > Based on my understanding, the current function debugfs_create_file()
> > > > adds an overhead of lifetime managing proxy for such fop structs. This
> > > > should be applicable to these set of drivers as well. Hence I think this
> > > > change will be useful.
> > > 
> > > Well since this is only created once per device instance I don't really care
> > > about this little overhead.
> > > 
> > > But what exactly is debugfs doing or not doing here?
> > 
> > It is trying to save drivers from having debugfs files open that point
> > to memory that can go away at any time.  For graphics devices, I doubt
> > that is the case.
> 
> So for anything we add/remove we have two-stage cleanup
> 
> 1. drm_dev_unregister (or drm_connector_unregisters, those are the only
> two hotunpluggable things we have) unregister all the uapi interfaces.
> This deletes all the sysfs and debugfs files.
> 
> 2. Once all the references to the underlying object disappear from the
> kernel, we free up the data structure.
> 
> Now for chardev and similar uapi, we hold full references for open files.
> But for sysfs and debugfs we assume that those uapi layers will make sure
> that after we deleted the files in step 1 all access through these
> functions are guaranteed to have finished. If that's not the case, then we
> need to rework our refcounting and also refcount the underlying drm
> structure (drm_device or drm_connector) from sysfs/debugfs files.
> 
> Now I tried to look at the patch Deepak references, and I'm not really
> clear what changes. Or whether we made a wrong assumption previously about
> what debugfs/sysfs guarantee when we delete the files.

I read some more code and kerneldoc, and I still have no idea what this
new _unsafe variant is used for. Only ones I've found seem to use
debugfs_file_get/put like the normal variant, to protect against
concurrently removed files due to hotunplug. Which is kinda what we've
been expecting debugfs to do for us.

What's a use-case for _unsafe _without_ debugfs_file_get/put?

Decently confused me over here doesn't get this.
-Daniel

> -Daniel
> 
> > 
> > thanks,
> > 
> > greg k-h
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
