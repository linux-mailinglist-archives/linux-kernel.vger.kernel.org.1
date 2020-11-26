Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5344F2C5C94
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 20:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbgKZTVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 14:21:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731736AbgKZTVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 14:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606418492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rPB2EMAwXH2IPl5RCPkvxpnn+2RaxoqCnomeoi2hSRQ=;
        b=OjwW4DS2Csa6TTaN78FmYRZ/JgxZSke7J1vPBi57c6RTzp3EHnP0Du2oyPwt4D6NgpEq3K
        OpbzUvtqVLzRvJOYFGEZ+/iM7I8rqdTM3mpd+5gMqdgBY1Ti82mOcOg9hCp47wfTAUGPdU
        ULQXlKLyTW8zxGtVxJmpHynMpQMDtSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-E2YUBY8RPvWpyz79xbmxrA-1; Thu, 26 Nov 2020 14:21:28 -0500
X-MC-Unique: E2YUBY8RPvWpyz79xbmxrA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDD9D803F48;
        Thu, 26 Nov 2020 19:21:26 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A02DB5C1BD;
        Thu, 26 Nov 2020 19:21:23 +0000 (UTC)
Date:   Thu, 26 Nov 2020 14:21:23 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X8AAMyvmLUJJSYsf@redhat.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
 <20201125210414.GO123287@linux.ibm.com>
 <X77OyM8utmWcq1Di@redhat.com>
 <20201126093602.GQ123287@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126093602.GQ123287@linux.ibm.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 11:36:02AM +0200, Mike Rapoport wrote:
> I think it's inveneted by your BIOS vendor :)

BTW, all systems I use on a daily basis have that type 20... Only two
of them are reproducing the VM_BUG_ON on a weekly basis on v5.9.

If you search 'E820 "type 20"' you'll get plenty of hits, so it's not
just me at least :).. In fact my guess is there are probably more
workstation/laptops with that type 20 than without. Maybe it only
showup if booting with EFI?

Easy to check with `dmesg | grep "type 20"` after boot.

One guess why this wasn't frequently reproduced is some desktop distro
is doing the mistake of keeping THP enabled = madvise by default and
they're reducing the overall compaction testing? Or maybe they're not
all setting DEBUG_VM=y (but some other distro I'm sure ships v5.9 with
DEBUG_VM=y). Often I hit this bug in kcompactd0 for example, that
wouldn't happen with THP enabled=madvise.

The two bpf tracing tools below can proof how the current
defrag=madvise default only increase the allocation latency from a few
usec to a dozen usec. Only if setting defrag=always the latency goes
up to single digit milliseconds, because of the cost of direct
compaction which is only worth paying for, for MADV_HUGEPAGE ranges
doing long-lived allocations (we know by now that defrag=always was
a suboptimal default).

https://www.kernel.org/pub/linux/kernel/people/andrea/ebpf/thp-comm.bp
https://www.kernel.org/pub/linux/kernel/people/andrea/ebpf/thp.bp

Since 3917c80280c93a7123f1a3a6dcdb10a3ea19737d even app like Redis
using fork for snapshotting purposes should prefer THP
enabled. (besides it would be better if it used uffd-wp as alternative
to fork)

3917c80280c93a7123f1a3a6dcdb10a3ea19737d also resolved another concern
because the decade old "fork() vs gup/O_DIRECT vs thread" race was
supposed to be unnoticeable from userland if the O_DIRECT min I/O
granularity was enforced to be >=PAGE_SIZE. However with THP backed
anon memory, that minimum granularity requirement increase to
HPAGE_PMD_SIZE. Recent kernels are going in the direction of solving
that race by doing cow during fork as it was originally proposed long
time ago
(https://lkml.kernel.org/r/20090311165833.GI27823@random.random) which
I suppose will solve the race with sub-PAGE_SIZE granularity too, but
3917c80280c93a7123f1a3a6dcdb10a3ea19737d alone is enough to reduce the
minumum I/O granularity requirement from HPAGE_PMD_SIZE to PAGE_SIZE
as some userland may have expected. The best of course is to fully
prevent that race condition by setting MADV_DONTFORK on the regions
under O_DIRECT (as qemu does for example).

Overall the only tangible concern left is potential higher memory
usage for servers handling tiny object storage freed at PAGE_SIZE
granularity with MADV_DONTNEED (instead of having a way to copy and
defrag the virtual space of small objects through a callback that
updates the pointer to the object...).

Small object storage relying on jemalloc/tcmalloc for tiny object
management simply need to selectively disable THP to avoid wasting
memory either with MADV_NOHUGEPAGE or with the prctl
PR_SET_THP_DISABLE. Flipping a switch in the OCI schema allows to
disable THP too for those object storage apps making heavy use of
MADV_DONTNEED, not even a single line of code need changing in the app
for it if deployed through the OCI container runtime.

Recent jemalloc uses MADV_NOHUGEPAGE. I didn't check exactly how it's
being used but I've an hope it already does the right thing and
separates small object arena zapped with MADV_DONTNEED at PAGE_SIZE
granularity, with large object arena where THP shall remain
enabled. glibc also should learn to separate small objects and big
objects in different arenas. This has to be handled by the app, like
it is handled optimally already in scylladb that in fact invokes
MADV_HUGEPAGE, or plenty of other databases are using not just THP but
also hugetlbfs which certainly won't fly if MADV_DONTNEED is attempted
at PAGE_SIZE granularity.. or elastic search that also gets a
significant boost from THP etc..

Thanks,
Andrea

