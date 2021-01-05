Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4422A2EB4B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbhAEVKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:10:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbhAEVKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609880944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hTxFQ5xUBHjKy7DyxsET6+IkY/1tKBB+g0+GZ2RnZoM=;
        b=ZAHuHYXBey71iyBe9e+A4HOnngtFH4lX47I1lA3mJiyzbZR/Y/Gp2QVagqmFNkbeeBr5tu
        jgsBk8FEmz1BE8Oi2wYzb8pHnjgxjMen8jb8mg3V6R80eEPkBbY+eO1eUt4kX2hUF+T2+t
        s+Z/F8QqFAUs975Jn6YLCajZgr86eQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-RLQXxJ_RMfKVE8nTMGK1hg-1; Tue, 05 Jan 2021 16:06:32 -0500
X-MC-Unique: RLQXxJ_RMfKVE8nTMGK1hg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD2ED107ACE3;
        Tue,  5 Jan 2021 21:06:30 +0000 (UTC)
Received: from mail (ovpn-112-76.rdu2.redhat.com [10.10.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B978A53C9F;
        Tue,  5 Jan 2021 21:06:27 +0000 (UTC)
Date:   Tue, 5 Jan 2021 16:06:27 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Message-ID: <X/TU04nu/WdFRS3m@redhat.com>
References: <X/NrdnoDHgFd0Ku1@redhat.com>
 <A7AC77D2-6901-4225-911B-EDBF013DCA42@vmware.com>
 <X/N4aqRgyxffhMSs@redhat.com>
 <73EE9007-65AF-4416-9930-D992C74447A9@vmware.com>
 <X/OCMalFYnDdGnch@redhat.com>
 <2844ACC1-8908-494C-B411-3C69B27A1730@vmware.com>
 <X/SzzjREaoR9u7Ua@redhat.com>
 <BABCB1DE-C41E-4C3E-90D1-5893585FB68A@vmware.com>
 <X/TB6ztitnESl3qZ@redhat.com>
 <91523A61-1AF8-48F9-8650-D313032E550C@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91523A61-1AF8-48F9-8650-D313032E550C@vmware.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 08:06:22PM +0000, Nadav Amit wrote:
> I just thought that there might be some insinuation, as you mentioned VMware
> by name. My response was half-jokingly and should have had a smiley to
> prevent you from wasting your time on the explanation.

No problem, actually I appreciate you pointed out to give me the extra
opportunity to further clarify I wasn't implying anything like that,
sorry again for any confusion I may have generated.

I mentioned vmware because I'd be shocked if for the whole duration of
the wrprotect on the guest physical memory it'd have to halt all minor
faults and all memory freeing like it would happen to rust-vmm/qemu if
we take the mmap_write_lock, that's all. Or am I wrong about this?

For uffd-wp avoiding the mmap_write_lock isn't an immediate concern
(obviously so in the rust-vmm case which won't even do postcopy live
migration), but the above concern applies for the long term and maybe
mid term for qemu.

The postcopy live snapshoitting was the #1 use case so it's hard not
to mention it, but there's still other interesting userland use cases
of uffd-wp with various users already testing it in their apps, that
may ultimately become more prevalent, who knows.

The point is that those that will experiment with uffd-wp will run a
benchmark, post a blog, others will see the blog, they will test too
in their app and post their blog. It needs to deliver the full
acceleration immediately, otherwise the evaluation may show it as a
fail or not worth it.

In theory we could just say, we'll optimize it later if significant
userbase emerge, but in my view it's bit of a chicken egg problem and
I'm afraid that such theory may not work well in practice.

Still, for the initial fix, avoiding the mmap_write_lock seems more
important actually for clear_refs than for uffd-wp. uffd-wp is
somewhat lucky and will just share any solution to keep clear_refs
scalable, since the issue is identical.

Thanks,
Andrea

