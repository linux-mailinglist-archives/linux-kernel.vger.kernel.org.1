Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA308277853
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgIXSPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgIXSPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:15:04 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA31C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:15:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c62so407914qke.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9NJQT1B3t3dYmrEGe9dnjwFh4ipeAAV2W/ZTEBMDE8E=;
        b=f8n3PrqhsiKL7Dh0x9lJKBPskIhVVKnftymIA3j9bRtyUJn1yT9Ddh01jjE8qhv4w9
         S7naQXy5ZGI9k/u1NLWLhQcdFok6O2JH8wlPD4DCP1/qMp5CN34bFZ0kNNsuknoZYh/7
         vaV8JTK0BwZpPCbXjhyNnp+0PvEpl7afAQPik0fVQbGILY+XsXzCpNwBvmfdJgBdRknn
         eLttNv4CfF7eaV/qUEkrAIhcwWbS20AKpw6TYaMO9wt2i47/GoLeqRqjJQIVq1R1/wfQ
         iGJzoeZSNBYk0kMVub/FO4BpDBNArQ0zq4i092o1xV2XISv1vh+o0Wu50B1ZCoQDQDgX
         oylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9NJQT1B3t3dYmrEGe9dnjwFh4ipeAAV2W/ZTEBMDE8E=;
        b=tYcBky/uwdOTtNyweVlHz5mMH6MHoTnho7wJF1B5sxwZAyauKZKFm954juYgfCC4oe
         BVAlTFamIct3JVRTysfWJfwSPmxxergWD+l72RwhB8Nn8Z4Amy5jKYqey0NfyWLToPtS
         vUVeEkN88iX15nHdd8S0QGjg4ZTzYa2gkVx6nAgwWph2IluSXSSqSEDdlO8hd0+Gpjm7
         E4Tz7oktH5fdPrbEbOrce2/90hsDobdwVaNNL1/aAWOIMtww7IpccfJtjOoV2Ve34cHb
         H48Ypu5H3MN005a1FH4KaQC4RiVeT4or4UrMbqVNBodGjLOW60qL1HzEfLdULGqPIWF5
         UZxA==
X-Gm-Message-State: AOAM533kz1YW7Vqxoio+YO1SPQgp+wvj71BHRf45jjNjyAprcjCMgqTZ
        cr6ZYojxbBkFCr/pQlzbAAIYag==
X-Google-Smtp-Source: ABdhPJxtioWuLnfbPVJThKB4P6JwxJpFNgCu3TtJPTEAMHuHXT4ys9heysqu1otOGnY9NOS0o5s9MA==
X-Received: by 2002:a37:68c7:: with SMTP id d190mr335280qkc.127.1600971303370;
        Thu, 24 Sep 2020 11:15:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id c11sm165844qkb.58.2020.09.24.11.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 11:15:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kLVll-000Pxz-Nv; Thu, 24 Sep 2020 15:15:01 -0300
Date:   Thu, 24 Sep 2020 15:15:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200924181501.GF9916@ziepe.ca>
References: <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
 <20200922161046.GB731578@ziepe.ca>
 <20200922175415.GI19098@xz-x1>
 <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1>
 <20200923170759.GA9916@ziepe.ca>
 <20200924143517.GD79898@xz-x1>
 <20200924165152.GE9916@ziepe.ca>
 <20200924175531.GH79898@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924175531.GH79898@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 01:55:31PM -0400, Peter Xu wrote:
> On Thu, Sep 24, 2020 at 01:51:52PM -0300, Jason Gunthorpe wrote:
> > > Regarding the solution here, I think we can also cover read-only fast-gup too
> > > in the future - IIUC what we need to do is to make it pte_protnone() instead of
> > > pte_wrprotect(), then in the fault handler we should identify this special
> > > pte_protnone() against numa balancing (change_prot_numa()).  I think it should
> > > work fine too, iiuc, because I don't think we should migrate a page at all if
> > > it's pinned for any reason...
> 
> [1]
> 
> > 
> > With your COW breaking patch the read only fast-gup should break the
> > COW because of the write protect, just like for the write side. Not
> > seeing why we need to do something more?
> 
> Consider this sequence of a parent process managed to fork() a child:
> 
>        buf = malloc();
>        // RDONLY gup
>        pin_user_pages(buf, !WRITE);
>        // pte of buf duplicated on both sides
>        fork();
>        mprotect(buf, WRITE);
>        *buf = 1;
>        // buf page replaced as cow triggered
> 
> Currently when fork() we'll happily share a pinned read-only page with the
> child by copying the pte directly.  

Why? This series prevents that, the page will be maybe_dma_pinned, so
fork() will copy it.

> As a summary: imho the important thing is we should not allow any kind of
> sharing of any dma page, even it's pinned for read.

Any sharing that results in COW. MAP_SHARED is fine, for instance

My feeling for READ when FOLL_PIN is used GUP_fast will go to the slow
path any time it sees a read-only page.

The slow path will determine if it is read-only because it could be
COW'd or read-only for some other reason

Jason
