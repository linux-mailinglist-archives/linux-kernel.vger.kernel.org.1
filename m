Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9812D21ED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgLHESB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:18:01 -0500
Received: from foss.arm.com ([217.140.110.172]:40648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbgLHESB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:18:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BDA111FB;
        Mon,  7 Dec 2020 20:17:15 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.87.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC8423F718;
        Mon,  7 Dec 2020 20:17:10 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        hca@linux.ibm.com, catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/3] s390/mm: Define arch_get_mappable_range()
Date:   Tue,  8 Dec 2020 09:46:18 +0530
Message-Id: <1607400978-31595-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607400978-31595-1-git-send-email-anshuman.khandual@arm.com>
References: <1607400978-31595-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This overrides arch_get_mappabble_range() on s390 platform which will be
used with recently added generic framework. It drops a redundant similar
check in vmem_add_mapping() while compensating __segment_load() with a new
address range check to preserve the existing functionality. It also adds a
VM_BUG_ON() check that would ensure that memhp_range_allowed() has already
been called on the hotplug path.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/s390/mm/extmem.c |  5 +++++
 arch/s390/mm/init.c   | 10 ++++++++++
 arch/s390/mm/vmem.c   |  4 ----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 5060956b8e7d..cc055a78f7b6 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -337,6 +337,11 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
 		goto out_free_resource;
 	}
 
+	if (seg->end + 1 > VMEM_MAX_PHYS || seg->end + 1 < seg->start_addr) {
+		rc = -ERANGE;
+		goto out_resource;
+	}
+
 	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
 	if (rc)
 		goto out_resource;
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 77767850d0d0..64937baabf93 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -278,6 +278,15 @@ device_initcall(s390_cma_mem_init);
 
 #endif /* CONFIG_CMA */
 
+struct range arch_get_mappable_range(void)
+{
+	struct range memhp_range;
+
+	memhp_range.start = 0;
+	memhp_range.end =  VMEM_MAX_PHYS;
+	return memhp_range;
+}
+
 int arch_add_memory(int nid, u64 start, u64 size,
 		    struct mhp_params *params)
 {
@@ -291,6 +300,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
 		return -EINVAL;
 
+	VM_BUG_ON(!memhp_range_allowed(start, size, 1));
 	rc = vmem_add_mapping(start, size);
 	if (rc)
 		return rc;
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b239f2ba93b0..749eab43aa93 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -536,10 +536,6 @@ int vmem_add_mapping(unsigned long start, unsigned long size)
 {
 	int ret;
 
-	if (start + size > VMEM_MAX_PHYS ||
-	    start + size < start)
-		return -ERANGE;
-
 	mutex_lock(&vmem_mutex);
 	ret = vmem_add_range(start, size);
 	if (ret)
-- 
2.20.1

