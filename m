Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F207274812
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgIVSXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:23:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48322 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726526AbgIVSXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600799010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ovmZrpAC+T2YMt44GFu5rQZOQ7iR8zuXRD3rJJbHavM=;
        b=huc+kdq8/cuJ6B+rCJPEvg+QX2b3ijR3oQ22Z1lXBPFNlRUPaYIoYg4b+CHE/WD3BLIwBL
        2rtrohi/GMyK/sUduclbABwlx2luzgH1V5jMd0lBiVVIAeJt2GdO7Mum7WxCVy8DoIbks6
        A6SzEizFFHSmC63m/HKlKypevkUc1sA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-DIMrhNbONEK1AjdJmpafsw-1; Tue, 22 Sep 2020 14:23:28 -0400
X-MC-Unique: DIMrhNbONEK1AjdJmpafsw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DA31801ABB;
        Tue, 22 Sep 2020 18:23:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9CAF45DE19;
        Tue, 22 Sep 2020 18:23:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 22 Sep 2020 20:23:26 +0200 (CEST)
Date:   Tue, 22 Sep 2020 20:23:18 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Xu <peterx@redhat.com>
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
Message-ID: <20200922182317.GH11679@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-4-peterx@redhat.com>
 <20200922100840.GA11679@redhat.com>
 <20200922101815.GB11679@redhat.com>
 <20200922153612.GF19098@xz-x1>
 <20200922154845.GE11679@redhat.com>
 <20200922160330.GH19098@xz-x1>
 <20200922165354.GG11679@redhat.com>
 <20200922181306.GJ19098@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922181306.GJ19098@xz-x1>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22, Peter Xu wrote:
>
> On Tue, Sep 22, 2020 at 06:53:55PM +0200, Oleg Nesterov wrote:
> > On 09/22, Peter Xu wrote:
> > >
> > > On Tue, Sep 22, 2020 at 05:48:46PM +0200, Oleg Nesterov wrote:
> > > > > However since I didn't change this logic in this patch, it probably means this
> > > > > bug is also in the original code before this series...  I'm thinking maybe I
> > > > > should prepare a standalone patch to clear the swp_entry_t and cc stable.
> > > >
> > > > Well, if copy_one_pte(src_pte) hits a swap entry and returns entry.val != 0, then
> > > > pte_none(*src_pte) is not possible after restart? This means that copy_one_pte()
> > > > will be called at least once.
> > >
> > > Note that we've released the page table locks, so afaict the old swp entry can
> > > be gone under us when we go back to the "do" loop... :)
> >
> > But how?
> >
> > I am just curious, I don't understand this code enough.
>
> Me neither.
>
> The point is I think we can't assume *src_pte will read the same if we have
> released the src_ptl in copy_pte_range(),

This is clear.

But I still think that !pte_none() -> pte_none() transition is not possible
under mmap_write_lock()...

OK, let me repeat I don't understans these code paths enough, let me reword:
I don't see how this transition is possible.

Oleg.

