Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A3A2CB018
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgLAWcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:32:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726828AbgLAWcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606861842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VNFpshh0KXLK8U3rtzTr4+BIoGN4Z+9c10o907dnoaI=;
        b=itu7LiHG7IULUUbFMgOubkJTOQyfPTy3KjlW/m6QGxehR5tiktiOgNSs3K6O1kILdbuRCg
        cm/qiC2MgIbSl6y/mDIgduUMbb849O9qJbvBluxbEJdrWABKPPQJOeIrzJB1IsL0npFIcm
        GML6NHc8YyhGaVC3dGBs615O+AhOmYM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-9iORGVwsOvir6JNWaAJNIA-1; Tue, 01 Dec 2020 17:30:37 -0500
X-MC-Unique: 9iORGVwsOvir6JNWaAJNIA-1
Received: by mail-qk1-f198.google.com with SMTP id 198so2574945qkj.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 14:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VNFpshh0KXLK8U3rtzTr4+BIoGN4Z+9c10o907dnoaI=;
        b=KwwZldrIPOZc1d9pm3a8Q7rxE9b0HJCzfwArMvXKtMbQPFc4kmeiB5O4BKH19SET/9
         yN732lFzMYaE1ONP8k+84rrmfrhuPispxvhpwUjm6miI6BZ8F1yg0OPFNwoWlR+KOunO
         kAxR7FcFKwp3peHkvH7bCDACSnjtGXuCyYO7CYtrXwfFnxY9M02RTsAr/Gb8xFLZ0FZK
         nnJ6Uv7TnO+6UWWr9/UXkm1pSnFgFcwPypvwDb/qY9VweTOO6h5XLkp04uY94jyi05xa
         oUXZdQUpO/PLQJjTQBFLTcWn5fAi6MNn4p8PQVjvkUvWcomOkit2RjtTgx71CefEaGKj
         RXrg==
X-Gm-Message-State: AOAM531Kz4u21md39SyPH9tRt3mgJU3iuhAA7XAS+hv19VyVi/GEs8Zq
        YKTl03IRsbiX7h26b20PZqdJxMt053gby/XwQwIfrmyVOANpnGphlj8GTDeGyDE9VpgwfevNdR9
        tvK7btCn2IqkI+GpbNELlXm3/
X-Received: by 2002:a37:9d16:: with SMTP id g22mr5333140qke.62.1606861836759;
        Tue, 01 Dec 2020 14:30:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5u0z/kIoCpzz+1n/AsgrjghQuDDAFjAR1UtdA4N2bZDrAyaLpA0tKx4CXXY6lx64kuGjutQ==
X-Received: by 2002:a37:9d16:: with SMTP id g22mr5333118qke.62.1606861836492;
        Tue, 01 Dec 2020 14:30:36 -0800 (PST)
Received: from xz-x1 ([142.126.94.187])
        by smtp.gmail.com with ESMTPSA id t126sm1149498qkc.76.2020.12.01.14.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 14:30:35 -0800 (PST)
Date:   Tue, 1 Dec 2020 17:30:33 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
Message-ID: <20201201223033.GG3277@xz-x1>
References: <20201130230603.46187-1-peterx@redhat.com>
 <20201201125927.GB11935@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201125927.GB11935@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 12:59:27PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 30, 2020 at 06:06:03PM -0500, Peter Xu wrote:
> > Faulting around for reads are in most cases helpful for the performance so that
> > continuous memory accesses may avoid another trip of page fault.  However it
> > may not always work as expected.
> > 
> > For example, userfaultfd registered regions may not be the best candidate for
> > pre-faults around the reads.
> > 
> > For missing mode uffds, fault around does not help because if the page cache
> > existed, then the page should be there already.  If the page cache is not
> > there, nothing else we can do, either.  If the fault-around code is destined to
> > be helpless for userfault-missing vmas, then ideally we can skip it.
> 
> This sounds like you're thinking of a file which has exactly one user.
> If there are multiple processes mapping the same file, then no, there's
> no reason to expect a page to be already present in the page table,
> just because it's present in the page cache.
> 
> > For wr-protected mode uffds, errornously fault in those pages around could lead
> > to threads accessing the pages without uffd server's awareness.  For example,
> > when punching holes on uffd-wp registered shmem regions, we'll first try to
> > unmap all the pages before evicting the page cache but without locking the
> > page (please refer to shmem_fallocate(), where unmap_mapping_range() is called
> > before shmem_truncate_range()).  When fault-around happens near a hole being
> > punched, we might errornously fault in the "holes" right before it will be
> > punched.  Then there's a small window before the page cache was finally
> > dropped, and after the page will be writable again (NOTE: the uffd-wp protect
> > information is totally lost due to the pre-unmap in shmem_fallocate(), so the
> > page can be writable within the small window).  That's severe data loss.
> 
> This still doesn't make sense.  If the page is Uptodate in the page
> cache, then userspace gets to access it.  If you don't want the page to
> be accessible, ClearPageUptodate().  read() can also access it if it's
> marked Uptodate.  A write fault on a page will call the filesystem's
> page_mkwrite() and you can block it there.

I still don't think the page_mkwrite() could help here... Though Andrea pointed
out an more important issue against swap cache (in the v1 thread [1]).  Indeed
if we have those figured out maybe we'll also rethink this patch then it could
become optional; while that seems to be required to allow shmem swap in/out
with uffd-wp which I haven't yet tested.  As Hugh pointed out, purely reuse the
_PAGE_SWP_UFFD_WP in swap cache may not work trivially since uffd-wp is per-pte
rather than per-page, so I probably need to think a bit more on how to do
that...

I don't know whether a patch like this could still be good in the future.  For
now, let's drop this patch until we solve all the rest of the puzzle.

My thanks to all the reviewers, and sorry for the noise!

NAK myself.

[1] https://lore.kernel.org/lkml/alpine.LSU.2.11.2012011250070.1582@eggly.anvils/T/#mef0716b38f4f5fc07b7542f2c11a07535ea31aad

-- 
Peter Xu

