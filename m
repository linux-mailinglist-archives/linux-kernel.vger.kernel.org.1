Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396C91FF502
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 16:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbgFROmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 10:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgFROmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:42:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06E3C0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:42:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x6so6311138wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=pdYzXGFouE6m4FSIkgrBziaqe3C5lzqdVFEvi65td6k=;
        b=Yv00WEyiSIg66gxJEUUQwcy2Tlc1E6Wc6zvKRDzYUlRDO6iCWLetHtRbnLoDvvQlXe
         zOvWWpAvNNuvZIWHgr0fKWDsU8iNkZKTU9Ci4Vt8EkYVQUyV00qvQSrVYglPeqw2m8hn
         YqvRGf3NKI0NMSmp82ufCgdaCILt0ba9vFJX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=pdYzXGFouE6m4FSIkgrBziaqe3C5lzqdVFEvi65td6k=;
        b=DAB5RNvR5CLHiX1k1WN2tUBa1V/DXELOP3n3PrVf0pZUsg3qv/c3+hGAgvhRs3HxXT
         YWKpwJF+gcY16ft1BKitnFUeLRfNmQMeVaIAlcDSduDjo1jiKM5YHgZihK/zN62KgO3H
         In15fsUM/H/LpNHCXh/FQVvBrcprFM0edv0zppICYpV6bAFR+1YDwb4PqCPReAQAmPfl
         Q54y+Ob9lUuLzA0WGUq+fx3MwZ+aUyPynjtx916PBHO4pH05PeGVV771RQVAheYKiGE1
         ewM05o8ZdrLFsUdPcAN/Y0Yx7tiD9FJBZqqteBLCfD+s0V/MY+56/fOeMUM7nnPZsFBz
         5PPg==
X-Gm-Message-State: AOAM5308nTOhnPqBFgz3KrZptBd1oQXTwiAvLkr9qVh9C7/ygtzF5pJF
        950vyowZ/qHPEX06evzdBAmzFQ==
X-Google-Smtp-Source: ABdhPJxnVXjNFjlZjZjkcFFWafgkcwR6ZwnMtNAx31PJPXgT9P8/Pv/85bqfzuCJe/q/lkXd/e/Xbg==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr4325124wrj.265.1592491359458;
        Thu, 18 Jun 2020 07:42:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g25sm3649693wmh.18.2020.06.18.07.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:42:38 -0700 (PDT)
Date:   Thu, 18 Jun 2020 16:42:36 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= 
        <thomas_os@shipmail.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
Message-ID: <20200618144236.GR20149@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= <thomas_os@shipmail.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch>
 <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local>
 <20200611141515.GW6578@ziepe.ca>
 <20200616120719.GL20149@phenom.ffwll.local>
 <20200616145312.GC6578@ziepe.ca>
 <CAKMK7uER6ax1zr14xYLKqDfDZp+ycBsY9Yx7JaVkKQ849VfSPg@mail.gmail.com>
 <20200617152940.GG6578@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617152940.GG6578@ziepe.ca>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:29:40PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 17, 2020 at 09:57:54AM +0200, Daniel Vetter wrote:
> 
> > > At the very least I think there should be some big warning that
> > > dma_fence in notifiers should be avoided.
> > 
> > Yeah I'm working on documentation, and also the notifiers here
> > hopefully make it clear it's massive pain. I think we could even make
> > a hard rule that dma_fence in mmu notifier outside of drivers/gpu is a
> > bug/misfeature.
> 
> Yep!
>
> > Might be a good idea to add a MAINTAINERS entry with a K: regex
> > pattern, so that you can catch such modifiers. We do already have such
> > a pattern for dma-fence, to catch abuse. So if you want I could type
> > up a documentation patch for this, get your and others acks and the
> > dri-devel folks would enforce that the dma_fence_wait madness doesn't
> > leak beyond drivers/gpu
> 
> It seems like the best thing

Just thought about where to best put this, and I think including it as
another paragraph in the next round of this series makes the most sense.
You'll get cc'ed for acking when that happens - might take a while since
there's a lot of details here all over to sort out.
-Daniel

>  
> > Oded has agreed to remove the dma-fence usage, since they really don't
> > need it (and all the baggage that comes with it), plain old completion
> > is enough for their use. This use is also why I added the regex to
> > MAINTAINERS, so that in the future we can catch people who try to use
> > dma_fence because it looks cute and useful, and are completely
> > oblivious to all the pain and headaches involved.
> 
> This is good!
> 
> Thanks,
> Jason 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
