Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A444A1D9AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 17:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgESPKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 11:10:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbgESPKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:10:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9CAEEB1D7;
        Tue, 19 May 2020 15:10:13 +0000 (UTC)
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
From:   Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] ix86: keep page table dumping off hypervisor area
Message-ID: <6db80042-40f9-f4a3-bbd8-7a0a3de0b546@suse.com>
Date:   Tue, 19 May 2020 17:10:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bba42affa732 ("x86/mm: Fix dump_pagetables with Xen PV") took
care of only the 64-bit case, albeit I think the 32-bit issue predates
the commit mentioned there in the Fixes: tag. For the 32-bit case, as
long as this space is mapped (by the hypervisor) with large pages, no
(noticable) harm results from walking even that area. If there are 4k
mappings, though, HIGHPTE=y configurations wanting to also dump that
range will find a need to map page tables owned by the hypervisor (which
hence doesn't allow them to be mapped). With DEBUG_WX this in turn
causes booting to fail.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -366,7 +366,7 @@ static void ptdump_walk_pgd_level_core(s
 	{0, PTRS_PER_PGD * PGD_LEVEL_MULT / 2},
 	{GUARD_HOLE_END_ADDR, ~0UL},
 #else
-	{0, ~0UL},
+	{0, __FIXADDR_TOP + PAGE_SIZE ?: ~0UL},
 #endif
 	{0, 0}
 };
