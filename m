Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F682A00F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgJ3JP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgJ3JPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:15:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7732DC0613D7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:15:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v5so2172357wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ajiZKDquHTFSl0096pkCVJGMC7tGtJTQuVLJuoBU2x4=;
        b=PI2jc1onHCGHTFVrOglMW6SqUxii06UoetHncrrfRN7UKVNuoUUMafkCmOCrbDnzS7
         jd4EeQYASCzCZt0DNZ3dlCHo1pb4Mb1DvEHQNrrI6M9J4m95H/fuuYPptNcbR1pHAbFj
         sPRW9/fLFAdAe5xhF5kXN0H02zqfTXGuOmrao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ajiZKDquHTFSl0096pkCVJGMC7tGtJTQuVLJuoBU2x4=;
        b=Vp6vZ81UfYtp6jhYX5GKV+atvccwgH9OdoD/urDtALJdgsCLMghVFLNEkk0HOrmqXR
         XLHsGyHL7ECei4dhYBVvm+CgFJg0q644E/UYvN6S3gqcU5Mjgv1NE+l4ZL8TtKnVD8M9
         Ew9OJiiGwGIoNeqVSNNU5DqkfZBBbhMdCWWvlqb7wDiYPy5CU34JORc5oohygZeS6Am5
         REdb6D98yym+s+mCVHEihJI3YjHrQs5JnxQibl8ECvqH4nLa/7inP1h5iE12kNqXcCsw
         TgghZHZVXUY/XBOoXbPTvqfeBaDp2eyD3z5mYZ80gf99uV+HV3bwYwjLbErEuDEeiMPt
         gZtw==
X-Gm-Message-State: AOAM53212AjstpcJT6QXBqY5pi3JojeQUJNp4ToFsro546j0EuDN/d6u
        MCzRWIhib3tphuOtVK6TdYCOsw==
X-Google-Smtp-Source: ABdhPJz1w5owVaYO5YAhR8bSJx5mzCGURblvQtjgVDkUzIP6+/UvUQcNl1nNuFPePlumK451ec2/Tg==
X-Received: by 2002:a1c:7dc5:: with SMTP id y188mr1425897wmc.37.1604049324133;
        Fri, 30 Oct 2020 02:15:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v14sm10240364wrq.46.2020.10.30.02.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 02:15:23 -0700 (PDT)
Date:   Fri, 30 Oct 2020 10:15:21 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: Re: [Outreachy kernel] [PATCH] drm/amdgpu: use
 DEFINE_DEBUGFS_ATTRIBUTE with debugfs_create_file_unsafe()
Message-ID: <20201030091521.GH401619@phenom.ffwll.local>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201030082518.GB1619669@kroah.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 09:25:18AM +0100, Greg KH wrote:
> On Fri, Oct 30, 2020 at 09:00:04AM +0100, Christian König wrote:
> > Am 30.10.20 um 08:57 schrieb Deepak R Varma:
> > > On Fri, Oct 30, 2020 at 08:11:20AM +0100, Greg KH wrote:
> > > > On Fri, Oct 30, 2020 at 08:52:45AM +0530, Deepak R Varma wrote:
> > > > > Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_unsafe()
> > > > > function in place of the debugfs_create_file() function will make the
> > > > > file operation struct "reset" aware of the file's lifetime. Additional
> > > > > details here: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.archive.carbon60.com%2Flinux%2Fkernel%2F2369498&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Cddd7a6ac8164415a639708d87ca97004%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637396414464384011%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=o6GOHvMxNMuOPlC4nhDyURCHBLqfQZhYQq%2BiIMt3D3s%3D&amp;reserved=0
> > > > > 
> > > > > Issue reported by Coccinelle script:
> > > > > scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> > > > > 
> > > > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > > > > ---
> > > > > Please Note: This is a Outreachy project task patch.
> > > > > 
> > > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 ++++++++++----------
> > > > >   1 file changed, 10 insertions(+), 10 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > index 2d125b8b15ee..f076b1ba7319 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > @@ -1551,29 +1551,29 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
> > > > >   	return 0;
> > > > >   }
> > > > > -DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
> > > > > -			amdgpu_debugfs_ib_preempt, "%llu\n");
> > > > > +DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
> > > > > +			 amdgpu_debugfs_ib_preempt, "%llu\n");
> > > > Are you sure this is ok?  Do these devices need this additional
> > > > "protection"?  Do they have the problem that these macros were written
> > > > for?
> > > > 
> > > > Same for the other patches you just submitted here, I think you need to
> > > > somehow "prove" that these changes are necessary, checkpatch isn't able
> > > > to determine this all the time.
> > > Hi Greg,
> > > Based on my understanding, the current function debugfs_create_file()
> > > adds an overhead of lifetime managing proxy for such fop structs. This
> > > should be applicable to these set of drivers as well. Hence I think this
> > > change will be useful.
> > 
> > Well since this is only created once per device instance I don't really care
> > about this little overhead.
> > 
> > But what exactly is debugfs doing or not doing here?
> 
> It is trying to save drivers from having debugfs files open that point
> to memory that can go away at any time.  For graphics devices, I doubt
> that is the case.

So for anything we add/remove we have two-stage cleanup

1. drm_dev_unregister (or drm_connector_unregisters, those are the only
two hotunpluggable things we have) unregister all the uapi interfaces.
This deletes all the sysfs and debugfs files.

2. Once all the references to the underlying object disappear from the
kernel, we free up the data structure.

Now for chardev and similar uapi, we hold full references for open files.
But for sysfs and debugfs we assume that those uapi layers will make sure
that after we deleted the files in step 1 all access through these
functions are guaranteed to have finished. If that's not the case, then we
need to rework our refcounting and also refcount the underlying drm
structure (drm_device or drm_connector) from sysfs/debugfs files.

Now I tried to look at the patch Deepak references, and I'm not really
clear what changes. Or whether we made a wrong assumption previously about
what debugfs/sysfs guarantee when we delete the files.
-Daniel

> 
> thanks,
> 
> greg k-h

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
