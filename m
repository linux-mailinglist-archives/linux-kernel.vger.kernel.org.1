Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB3F29FF32
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgJ3H5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgJ3H5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:57:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26423C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 00:57:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o3so4506248pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=muDviu7LdHJg+SSfbczNSfqTYUnVpBS3s+/TDHUMTTw=;
        b=jgIk3kQqh6b5u8IMVHEg6AdHPuuke3JzirHkuNrOCCNKpeMK257DsLUoeFprqFh8Sz
         U+jweagDc8j2KnmzKdNbiv9B/CABxAw8RwQf2qsGFlB8ClYhnXz/4xTlrrK82ReaaXCY
         FyF8uYsKUx+Jsg+bWsN1VQ2OguKv7klzVR3JjwRuXzccW0KIzLmXlexdRAiUVePEvg44
         K27mHToHsf5LnJ4r4314ZbAbDvHCgXXPKKlXuyksDHrUVcrenfOVSAOwGtxPk6Z7MgKb
         3S6OHQKikdKPcJdpZz8QZYr2keQGpGGu2LplB/t9syqbHEhtrSYrpkZLRBg5RjmtI/cC
         djBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=muDviu7LdHJg+SSfbczNSfqTYUnVpBS3s+/TDHUMTTw=;
        b=ATSVaHspAT28r4x35GLIj/gCpHTn9qgKwEIlB3q4L+gOeSeJgVdqXxzAmvq4JPFoc3
         Vq1IhTgcmyPEC5vh1Hb8i5c/O9ZkrC18eWvk9nTnWEpG7PXisXHVNlXnTuWDn6jOwOQm
         S5ba3gZcb8D0GVilc1uSfmcCowb5x1SnbMM8rrwtdDZie2qvGGoiWJzE0xReUrKgu48D
         Cxyi3T4oLqY8nuYzFd9sfXuYsss73MaowiSTJyLA4RS+Mb2WTrDJKsegdnXkMazm01aO
         bl5gFKaYduppEDBvi9LS1ZJwysR42pPlaPldkOy2g/LXWi7lD6/nsMCfml5KfzhPFGup
         cuyw==
X-Gm-Message-State: AOAM530m+YNeFDbEDJdtZVJSWsLa1RPUznsI591tv4015RGjTIw6eLJS
        oST2xb1A46xvg/4Z6790n98=
X-Google-Smtp-Source: ABdhPJwwwhxE17Pk9mRvLaqPyLH8sC+zCszqpz892ul4ZfDWukCR0/BGEj8gA3lcqvZDIxcwXH53LQ==
X-Received: by 2002:a62:6044:0:b029:151:1a04:895 with SMTP id u65-20020a6260440000b02901511a040895mr8132347pfb.34.1604044643581;
        Fri, 30 Oct 2020 00:57:23 -0700 (PDT)
Received: from my--box ([103.98.79.70])
        by smtp.gmail.com with ESMTPSA id j5sm2253085pjb.56.2020.10.30.00.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 00:57:23 -0700 (PDT)
Date:   Fri, 30 Oct 2020 13:27:16 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        melissa.srw@gmail.com, daniel.vetter@ffwll.ch, mh12gx2825@gmail.com
Subject: Re: [Outreachy kernel] [PATCH] drm/amdgpu: use
 DEFINE_DEBUGFS_ATTRIBUTE with debugfs_create_file_unsafe()
Message-ID: <20201030075716.GA6976@my--box>
References: <20201030032245.GA274478@my--box>
 <20201030071120.GA1493629@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030071120.GA1493629@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 08:11:20AM +0100, Greg KH wrote:
> On Fri, Oct 30, 2020 at 08:52:45AM +0530, Deepak R Varma wrote:
> > Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_unsafe()
> > function in place of the debugfs_create_file() function will make the
> > file operation struct "reset" aware of the file's lifetime. Additional
> > details here: https://lists.archive.carbon60.com/linux/kernel/2369498
> > 
> > Issue reported by Coccinelle script:
> > scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> > 
> > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > ---
> > Please Note: This is a Outreachy project task patch.
> > 
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > index 2d125b8b15ee..f076b1ba7319 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -1551,29 +1551,29 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
> >  	return 0;
> >  }
> >  
> > -DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
> > -			amdgpu_debugfs_ib_preempt, "%llu\n");
> > +DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
> > +			 amdgpu_debugfs_ib_preempt, "%llu\n");
> 
> Are you sure this is ok?  Do these devices need this additional
> "protection"?  Do they have the problem that these macros were written
> for?
> 
> Same for the other patches you just submitted here, I think you need to
> somehow "prove" that these changes are necessary, checkpatch isn't able
> to determine this all the time.

Hi Greg,
Based on my understanding, the current function debugfs_create_file()
adds an overhead of lifetime managing proxy for such fop structs. This
should be applicable to these set of drivers as well. Hence I think this
change will be useful.

I will wait for comments from other experts for driver specific
consideration / behavior.

Thanks,
drv


> 
> thanks,
> 
> greg k-h
