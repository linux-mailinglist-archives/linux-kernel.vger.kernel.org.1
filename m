Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF0920A6A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 22:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436600AbgFYUSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 16:18:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:20516 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436562AbgFYUSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:18:42 -0400
IronPort-SDR: UKy2X53apJa0ntqbYZ6YGu41s4HygopKstAFIOSzxX/2MGmImkzTsnHoISKCd/4Pe3NG//+mHY
 lk+aSzyhOQ2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="132505286"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="132505286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 13:18:40 -0700
IronPort-SDR: hguf0MI+TInOK/uV/QbxRQ1hKalWrvpl2SYCI2mUSC18YpqyS0oh64dVKHK4o11nnZoP2pIext
 1tZ03oLjL2Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="453132242"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 25 Jun 2020 13:18:39 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Joerg Roedel" <joro@8bytes.org>, "Ingo Molnar" <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "H Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Christoph Hellwig" <hch@infradeed.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 08/12] fork: Clear PASID for new mm
Date:   Thu, 25 Jun 2020 13:17:18 -0700
Message-Id: <1593116242-31507-9-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1593116242-31507-1-git-send-email-fenghua.yu@intel.com>
References: <1593116242-31507-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a new mm is created, its PASID should be cleared, i.e. the PASID is
initialized to its init state 0 on both ARM and X86.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Add this patch to initialize PASID value for a new mm.

 include/linux/mm_types.h | 2 ++
 kernel/fork.c            | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d61285cfe027..d60d2ec10881 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -22,6 +22,8 @@
 #endif
 #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
 
+/* Initial PASID value is 0. */
+#define INIT_PASID	0
 
 struct address_space;
 struct mem_cgroup;
diff --git a/kernel/fork.c b/kernel/fork.c
index 142b23645d82..43b5f112604d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1007,6 +1007,13 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
 #endif
 }
 
+static void mm_init_pasid(struct mm_struct *mm)
+{
+#ifdef CONFIG_IOMMU_SUPPORT
+	mm->pasid = INIT_PASID;
+#endif
+}
+
 static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
@@ -1035,6 +1042,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
 	mm_init_owner(mm, p);
+	mm_init_pasid(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
-- 
2.19.1

