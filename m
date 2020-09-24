Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC1527788B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgIXSe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728264AbgIXSeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600972462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8K7ULO9gOYr1TfXMbCWrHocAusNVWavCoisSi1BnpHw=;
        b=Htrz0GAyohAW2O0YD3C17YdUa1cLes9dLNhht/a4HM5/22Pb6ukAGSq/1b1/3thcc+sodB
        aE7caex3Hb6XNBld21xW2SJYf0wx8k3NVz+e7FDDa8SnNPYzTvGENBkcue9hEiI1tBP50o
        uVyvcEWVlRI47q/7CuCfcXHawWgiZww=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-Dpf6WJ5aNbOCP3ReIwljzg-1; Thu, 24 Sep 2020 14:34:21 -0400
X-MC-Unique: Dpf6WJ5aNbOCP3ReIwljzg-1
Received: by mail-qk1-f200.google.com with SMTP id 125so272647qkh.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8K7ULO9gOYr1TfXMbCWrHocAusNVWavCoisSi1BnpHw=;
        b=DrTMyj3kCd42XcQzJVQInKo/mhV1Y8s7zKpefaGKmFZFnnEQkZqrQf5BUKN0iiiNES
         Jgr5zdqggLwMAXBYQwaafTdA1NpE+3E8IQepBKY5q94LySZL29Z89vncH7uWBzlLoiZV
         2oPhF6LjKJLyCWCb8InoRgKW9Ej7Y5S/stGUy0qLCws38ade67ZAV68AR9aiwgZ4a8xT
         ewc5t7njH27C5gq+hOi6+za2RYM8m8uHUn7z0KEvXJvMQTKBWNa3VvN8/WnGOsQd1Hdg
         dZxzr5s2IrlVqJ54wnTNAjBzdFc9huDddJSIelGkOjk/TlcRLpN2tskeBF+BxfKtA8DD
         mZHw==
X-Gm-Message-State: AOAM532vgHHeiqEnVqRTVMrx9u4dX6JnaMa42WoJM1oIjt2UwF2qJ9OF
        58MyFvN1zKc294amrCWhmg4JuL4qmabKGR6ljTMH3GIKyhh2dXkGtBQ2EEzx4rEfyjTvWN5JWMH
        5i/CEgIqKF+CY5e71QNGpkotG
X-Received: by 2002:a37:a0cf:: with SMTP id j198mr464631qke.408.1600972460559;
        Thu, 24 Sep 2020 11:34:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz189qd83FsBU+Y1WUPx1hxxa2IHQ66Cfq7DuTjUWqlGX5heqwtD0IdF9ou967Lsr72f6+HHw==
X-Received: by 2002:a37:a0cf:: with SMTP id j198mr464597qke.408.1600972460310;
        Thu, 24 Sep 2020 11:34:20 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id z3sm211216qkj.0.2020.09.24.11.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 11:34:19 -0700 (PDT)
Date:   Thu, 24 Sep 2020 14:34:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <20200924183418.GJ79898@xz-x1>
References: <20200922151736.GD19098@xz-x1>
 <20200922161046.GB731578@ziepe.ca>
 <20200922175415.GI19098@xz-x1>
 <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1>
 <20200923170759.GA9916@ziepe.ca>
 <20200924143517.GD79898@xz-x1>
 <20200924165152.GE9916@ziepe.ca>
 <20200924175531.GH79898@xz-x1>
 <20200924181501.GF9916@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200924181501.GF9916@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 03:15:01PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 24, 2020 at 01:55:31PM -0400, Peter Xu wrote:
> > On Thu, Sep 24, 2020 at 01:51:52PM -0300, Jason Gunthorpe wrote:
> > > > Regarding the solution here, I think we can also cover read-only fast-gup too
> > > > in the future - IIUC what we need to do is to make it pte_protnone() instead of
> > > > pte_wrprotect(), then in the fault handler we should identify this special
> > > > pte_protnone() against numa balancing (change_prot_numa()).  I think it should
> > > > work fine too, iiuc, because I don't think we should migrate a page at all if
> > > > it's pinned for any reason...
> > 
> > [1]
> > 
> > > 
> > > With your COW breaking patch the read only fast-gup should break the
> > > COW because of the write protect, just like for the write side. Not
> > > seeing why we need to do something more?
> > 
> > Consider this sequence of a parent process managed to fork() a child:
> > 
> >        buf = malloc();

Sorry! I think I missed something like:

           mprotect(buf, !WRITE);

Here.

> >        // RDONLY gup
> >        pin_user_pages(buf, !WRITE);
> >        // pte of buf duplicated on both sides
> >        fork();
> >        mprotect(buf, WRITE);
> >        *buf = 1;
> >        // buf page replaced as cow triggered
> > 
> > Currently when fork() we'll happily share a pinned read-only page with the
> > child by copying the pte directly.  
> 
> Why? This series prevents that, the page will be maybe_dma_pinned, so
> fork() will copy it.

With the extra mprotect(!WRITE), I think we'll see a !pte_write() entry.  Then
it'll not go into maybe_dma_pinned() at all since cow==false.

> 
> > As a summary: imho the important thing is we should not allow any kind of
> > sharing of any dma page, even it's pinned for read.
> 
> Any sharing that results in COW. MAP_SHARED is fine, for instance

Oh right, MAP_SHARED is definitely special.

Thanks,

-- 
Peter Xu

