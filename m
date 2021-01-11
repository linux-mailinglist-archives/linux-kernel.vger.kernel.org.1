Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9C2F1FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403937AbhAKTlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:41:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbhAKTlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:41:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF23522BF3;
        Mon, 11 Jan 2021 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610394027;
        bh=wMhR+nnU1eezFDf6iB1XZoqyfaXAGSf1irT3FkxVVjI=;
        h=From:To:Cc:Subject:Date:From;
        b=pQjOSIJk6BNqRFvzbbWQxJWtYYQgM/1Teuad/NVOg/V7SEr6hIyhLTe5klps2lYF6
         ACRHW8/YFDzJaPvnqKf3nFr/mgg4aeUALUq/0nBk3KdiqOvqblCJLMT4dMZuJ0KKuw
         zV73aDaE9w6EOE+U4O8Fv1LqbMtK+M4Ezna7cSE/bVEYHw3Fd9e8IvR187Co19EFFv
         btoJrImUrD23SSJlPNSx8bMWRjt6b+uw7g+8IEjegpgNSveHHS7Jc96u1i9wzGSI8b
         deq7HDEZWflnLsMn72f4uJ84+x/n88ZuYMKoe/AmR3qQZG6NCr6DVyt2m50zf1M1bi
         8wYlYLaIGrgtQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: [PATCH v3 0/2] mm: fix initialization of struct page for holes in  memory layout
Date:   Mon, 11 Jan 2021 21:40:15 +0200
Message-Id: <20210111194017.22696-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

Commit 73a6e474cb37 ("mm: memmap_init: iterate over
memblock regions rather that check each PFN") exposed several issues with
the memory map initialization and these patches fix those issues.

Initially there were crashes during compaction that Qian Cai reported back
in April [1]. It seemed back then that the problem was fixed, but a few
weeks ago Andrea Arcangeli hit the same bug [2] and there was an additional
discussion at [3].

v3: 
* use architectural zone constraints to set zone links for struct pages
  corresponding to the holes
* drop implicit update of memblock.memory
* add a patch that sets pfn 0 to E820_TYPE_RAM on x86

v2: https://lore.kernel.org/lkml/20201209214304.6812-1-rppt@kernel.org/):
* added patch that adds all regions in memblock.reserved that do not
overlap with memblock.memory to memblock.memory in the beginning of
free_area_init()

[1] https://lore.kernel.org/lkml/8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw
[2] https://lore.kernel.org/lkml/20201121194506.13464-1-aarcange@redhat.com
[3] https://lore.kernel.org/mm-commits/20201206005401.qKuAVgOXr%akpm@linux-foundation.org

Mike Rapoport (2):
  x86/setup: don't remove E820_TYPE_RAM for pfn 0
  mm: fix initialization of struct page for holes in memory layout

 arch/x86/kernel/setup.c | 20 +++++-----
 mm/page_alloc.c         | 84 ++++++++++++++++++++++++-----------------
 2 files changed, 59 insertions(+), 45 deletions(-)

-- 
2.28.0

