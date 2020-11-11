Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3F62AF41B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgKKOxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:53:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbgKKOxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605106415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5Dr0+pyBqVK3WLFkrmGnVmo0jFKi8+9WQgJ494/SxHE=;
        b=Ir79xG2yLD/riet8TMtKd95HoDk06HGGenoaUxLx8DsMfH+XQF5eAZDDck/V9FBWXOicCC
        LmqmYWazE1izlClcyGj530fbHGh6/V4MluvayQajm3oRPCoohEM7mEU/18C6wtxiGVCt9a
        MfpCfAiOVNfXMfT+S7H/8r+RKJHVnBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-bF7ocHOgOXK6oeBoGufIsg-1; Wed, 11 Nov 2020 09:53:33 -0500
X-MC-Unique: bF7ocHOgOXK6oeBoGufIsg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5093318CB72A;
        Wed, 11 Nov 2020 14:53:30 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6BDD380;
        Wed, 11 Nov 2020 14:53:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v2 0/8] powernv/memtrace: don't abuse memory hot(un)plug infrastructure for memory allocations
Date:   Wed, 11 Nov 2020 15:53:14 +0100
Message-Id: <20201111145322.15793-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on latest linux/master

powernv/memtrace is the only in-kernel user that rips out random memory
it never added (doesn't own) in order to allocate memory without a
linear mapping. Let's stop abusing memory hot(un)plug infrastructure for
that - use alloc_contig_pages() for allocating memory and remove the
linear mapping manually.

The original idea was discussed in:
 https://lkml.kernel.org/r/48340e96-7e6b-736f-9e23-d3111b915b6e@redhat.com

I only tested via QEMU TCG with a single NUMA node- see patch #8 for more
details.

Error handling and cleanup handling in memtrace code is a mess - that
should definitely get cleaned up sooner or later. Once we have __GFP_ZERO
support for alloc_contig_pages(), we can drop manual clearing. I added
a TODO for now, so this series can go via the powerpc tree - the __GFP_ZERO
change is then better suited via the mm tree, along with support for
__GFP_ZERO.

v1 -> v2:
- Tweaks to patch descriptions
- "powernv/memtrace: don't leak kernel memory to user space"
-- Added. Reported by Michael.
- "powernv/memtrace: fix crashing the kernel when enabling concurrently"
-- Added, discovered while testing.
- "powerpc/mm: protect linear mapping modifications by a mutex"
-- Added. Although we currently won't have concurrency, this is cleaner and
   future-proof.
- "powerepc/book3s64/hash: drop WARN_ON in hash__remove_section_mapping"
-- Added. Suggested by Oscar
- "powernv/memtrace: don't abuse memory hot(un)plug infrastructure for
   memory allocations"
-- Reshuffle the code to make review easier.
-- Add a TODO regarding __GFP_ZERO. Adapt to changed page clearing code.
-- Use GFP_KERNEL | __GFP_THISNODE | __GFP_NOWARN for allocations.


David Hildenbrand (8):
  powernv/memtrace: don't leak kernel memory to user space
  powernv/memtrace: fix crashing the kernel when enabling concurrently
  powerpc/mm: factor out creating/removing linear mapping
  powerpc/mm: protect linear mapping modifications by a mutex
  powerpc/mm: print warning in arch_remove_linear_mapping()
  powerepc/book3s64/hash: drop WARN_ON in hash__remove_section_mapping
  powerpc/mm: remove linear mapping if __add_pages() fails in
    arch_add_memory()
  powernv/memtrace: don't abuse memory hot(un)plug infrastructure for
    memory allocations

 arch/powerpc/mm/book3s64/hash_utils.c     |   1 -
 arch/powerpc/mm/mem.c                     |  53 +++++--
 arch/powerpc/platforms/powernv/Kconfig    |   8 +-
 arch/powerpc/platforms/powernv/memtrace.c | 175 ++++++++++------------
 include/linux/memory_hotplug.h            |   3 +
 5 files changed, 125 insertions(+), 115 deletions(-)

-- 
2.26.2

