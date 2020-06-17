Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213681FD0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 17:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgFQP2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 11:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFQP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:28:39 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2E5C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:28:37 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e16so1842889qtg.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YWvFZzs3KP9lJjMgLteUxWcl0AN5fcCF6bv79uFgihI=;
        b=fPvsZiRmvOrvrQ4yxrTzKd5CSIveZ17z50EpolEl+pPAK7HUWF0QJZmXtSGVDOakfw
         7DHwzIzE2lNcGxpAtO8aw08z/gM8Y21yy9DIXMANO2ubUa3TWdA4GmPrzu72SDfRdvmF
         BClIRqEbNJmDflVkgdFD+OnXmF0SaCCsk8z9/TyDuufHGuZdnpCUVgkaPeljCUzfOGUP
         iou8x9GwNeXqpb+7LiV1ym/MPlGBad5o331/0hIUNzTl2FFPtmlIOP+y+IRR8Ia8Spm0
         VHrOAMJcFDHzlMiG7WUr4U2IvrrqHhxtahUa25x/jrfaWVB1Q09VlgzgQNmhTWG78o/m
         b3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YWvFZzs3KP9lJjMgLteUxWcl0AN5fcCF6bv79uFgihI=;
        b=GiTRBtQ/nmIzlhuNhNCUGCzmKZ+T7DUQgAai4VczdvdqA9vnKGCb9yNjylkLysIbRj
         A8hL6dL1KW3+R12T1dK0Ff29mn/1Iry8nB2BsjoiEopb8vltsBA+AFBmhlYMwC9o3x4L
         bHgQ8eOXdBHAeUDnpv0+wDaOrOpuWJxNAwHkSa7eYlePbf2UyWRk5wK9diD4KwVyqtbK
         84zbq05wXZDKMeF5oOhaezg9XA/NXR1f5i1dOXpddwATR4DyswQ/cZDAnhGKMrNpkqqw
         EYno9Afk6X9cEn8WeQr7F7r19BJahsGDj8bBs330JAdhLgOyuyPo1Hl8RR8n9aOFzdPE
         8eXw==
X-Gm-Message-State: AOAM531RSfzmqezaQA/0oyob36AnTEUeCZpOfYH7Zd4uyIU0s0rmHJ3f
        0i4eG9QESb/UkS5mORkH4uFXug==
X-Google-Smtp-Source: ABdhPJzZDttOnjxPbTFDeZHyWDfba0peOY2A/3G4231dt912/147Xnlp7RMkFB2VSf50LuX5ZTAibw==
X-Received: by 2002:ac8:468a:: with SMTP id g10mr27323795qto.6.1592407717080;
        Wed, 17 Jun 2020 08:28:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id f127sm210137qkb.55.2020.06.17.08.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 08:28:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jlZzP-009d7z-9q; Wed, 17 Jun 2020 12:28:35 -0300
Date:   Wed, 17 Jun 2020 12:28:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
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
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
Message-ID: <20200617152835.GF6578@ziepe.ca>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch>
 <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local>
 <20200611141515.GW6578@ziepe.ca>
 <20200616120719.GL20149@phenom.ffwll.local>
 <CAKMK7uE7DKUo9Z+yCpY+mW5gmKet8ugbF3yZNyHGqsJ=e-g_hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uE7DKUo9Z+yCpY+mW5gmKet8ugbF3yZNyHGqsJ=e-g_hA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 08:48:50AM +0200, Daniel Vetter wrote:

> Now my understanding for rdma is that if you don't have hw page fault
> support,

The RDMA ODP feature is restartable HW page faulting just like nouveau
has. The classical MR feature doesn't have this. Only mlx5 HW supports
ODP today.

> It's only gpus (I think) which are in this awkward in-between spot
> where dynamic memory management really is much wanted, but the hw
> kinda sucks. Aside, about 10+ years ago we had a similar problem with
> gpu hw, but for security: Many gpu didn't have any kinds of page
> tables to isolate different clients from each another. drivers/gpu
> fixed this by parsing&validating what userspace submitted to make sure
> it's only every accessing its own buffers. Most gpus have become
> reasonable nowadays and do have proper per-process pagetables (gpu
> process, not the pasid stuff), but even today there's still some of
> the old model left in some of the smallest SoC.

But I still don't understand why a dma fence is needed inside the GPU
driver itself in the notifier.

Surely the GPU driver can block and release the notifier directly from
its own command processing channel?

Why does this fence and all it entails need to leak out across
drivers?

Jason
