Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6EC27488E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIVStM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgIVStL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600800550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pvVMl2lXhY9qW3FKBTGyVnidFcK9anz/x/7S1UyT+hU=;
        b=WnUY5IxVnVDbAAQzJdpvzpl82RvIJNmdvLFqUw756PVMmTLAVnKtjUfZssXIyDrkOCAxnM
        oZVMxesFbwd5staL0OoxVhJaNToOaz7YErdCi9uZnn9PtZkKGVyY+wSbWiU0mbjDZGeCXN
        6A8eBdbXURhxeDk11+TnnRHS6TIM3tI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-V5n66mLzMNunSipTf-CNPw-1; Tue, 22 Sep 2020 14:49:08 -0400
X-MC-Unique: V5n66mLzMNunSipTf-CNPw-1
Received: by mail-qt1-f199.google.com with SMTP id b18so16953734qto.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pvVMl2lXhY9qW3FKBTGyVnidFcK9anz/x/7S1UyT+hU=;
        b=S9RFvICGGkl3HXhPCSrVqjMNE+XQNsxRLSqsv8lKHpf8etGaEAE9h6EUVxBZ7XIa+O
         RVHvfNNLjXmFqABR0SwY+n/USOz6kcttrPxGsoC+KmnFQuqHWM6rPkyq3qtdtoxV0bjP
         M2W6psgLewlZ7NiIQ53ZpNvdL5WMpoahzvsDysH8xMT4dHkzNlODvXHPb/BwHWMTYFRv
         sYKoM9OYBymdDUj8d1KsoPIKuOsnUlQ6BGvSmHs98iNIDtj7SNaphfrTkmhGT7YOOEZd
         VQQoJkxg2Mwe63O408HHerX2bbFpq+NGbq/m3HPrfXVI9tin2qOQ8VQe92bD07QuW1J5
         dNgg==
X-Gm-Message-State: AOAM5335+KbT6cHa+3xDCajIa/fyWMsA1XV0ZuFCwMndfrvOQklWlAjg
        yUFDy3UdwFLEOqsmLlkUba3lS2HtaU8rIvDRWxKhzr+ZLkfCGH1IWaqt7zM3Dv7J62+swZXS7r0
        A5d8P2mQN1noTJlADew/ZLtbn
X-Received: by 2002:a37:9a93:: with SMTP id c141mr6216706qke.203.1600800548031;
        Tue, 22 Sep 2020 11:49:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+gvROI+XaSQiJOWbbyz+qOZbSbM01T/V529JXEp4D7KxFRuzpRATaThLsuFBVPun4ezpFww==
X-Received: by 2002:a37:9a93:: with SMTP id c141mr6216680qke.203.1600800547794;
        Tue, 22 Sep 2020 11:49:07 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id f76sm11725245qke.19.2020.09.22.11.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 11:49:07 -0700 (PDT)
Date:   Tue, 22 Sep 2020 14:49:05 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 3/5] mm: Rework return value for copy_one_pte()
Message-ID: <20200922184905.GM19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-4-peterx@redhat.com>
 <20200922100840.GA11679@redhat.com>
 <20200922101815.GB11679@redhat.com>
 <20200922153612.GF19098@xz-x1>
 <20200922154845.GE11679@redhat.com>
 <20200922160330.GH19098@xz-x1>
 <20200922165354.GG11679@redhat.com>
 <20200922181306.GJ19098@xz-x1>
 <20200922182317.GH11679@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922182317.GH11679@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 08:23:18PM +0200, Oleg Nesterov wrote:
> On 09/22, Peter Xu wrote:
> >
> > On Tue, Sep 22, 2020 at 06:53:55PM +0200, Oleg Nesterov wrote:
> > > On 09/22, Peter Xu wrote:
> > > >
> > > > On Tue, Sep 22, 2020 at 05:48:46PM +0200, Oleg Nesterov wrote:
> > > > > > However since I didn't change this logic in this patch, it probably means this
> > > > > > bug is also in the original code before this series...  I'm thinking maybe I
> > > > > > should prepare a standalone patch to clear the swp_entry_t and cc stable.
> > > > >
> > > > > Well, if copy_one_pte(src_pte) hits a swap entry and returns entry.val != 0, then
> > > > > pte_none(*src_pte) is not possible after restart? This means that copy_one_pte()
> > > > > will be called at least once.
> > > >
> > > > Note that we've released the page table locks, so afaict the old swp entry can
> > > > be gone under us when we go back to the "do" loop... :)
> > >
> > > But how?
> > >
> > > I am just curious, I don't understand this code enough.
> >
> > Me neither.
> >
> > The point is I think we can't assume *src_pte will read the same if we have
> > released the src_ptl in copy_pte_range(),
> 
> This is clear.
> 
> But I still think that !pte_none() -> pte_none() transition is not possible
> under mmap_write_lock()...
> 
> OK, let me repeat I don't understans these code paths enough, let me reword:
> I don't see how this transition is possible.

Though I guess I'll keep my wording, because I still think it's accurate to
me. :)

Can we e.g. punch a page hole without changing vmas?

-- 
Peter Xu

