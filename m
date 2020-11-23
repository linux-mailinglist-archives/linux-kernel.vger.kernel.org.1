Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71D82BFE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 03:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgKWC3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 21:29:25 -0500
Received: from foss.arm.com ([217.140.110.172]:51996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgKWC3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 21:29:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79A60106F;
        Sun, 22 Nov 2020 18:29:24 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.82.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6532A3F70D;
        Sun, 22 Nov 2020 18:29:21 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 3/3] s390/mm: Define arch_get_addressable_range()
Date:   Mon, 23 Nov 2020 07:58:49 +0530
Message-Id: <1606098529-7907-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
References: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This overrides arch_get_addressable_range() on s390 platform and drops
now redudant similar check in vmem_add_mapping().

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/s390/include/asm/mmu.h |  2 ++
 arch/s390/mm/vmem.c         | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index e12ff0f29d1a..f92d3926b188 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -55,4 +55,6 @@ static inline int tprot(unsigned long addr)
 	return rc;
 }
 
+#define arch_get_addressable_range arch_get_addressable_range
+struct range arch_get_addressable_range(bool need_mapping);
 #endif
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b239f2ba93b0..e03ad0ed13a7 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -532,14 +532,22 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
 	mutex_unlock(&vmem_mutex);
 }
 
+struct range arch_get_addressable_range(bool need_mapping)
+{
+	struct range memhp_range;
+
+	memhp_range.start = 0;
+	if (need_mapping)
+		memhp_range.end =  VMEM_MAX_PHYS;
+	else
+		memhp_range.end = (1ULL << (MAX_PHYSMEM_BITS + 1)) - 1;
+	return memhp_range;
+}
+
 int vmem_add_mapping(unsigned long start, unsigned long size)
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

