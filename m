Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88EB21E3F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 01:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgGMXtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 19:49:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:36778 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgGMXsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:48:52 -0400
IronPort-SDR: rRdNokkPGDRYL/W3BnlCeuhyAeI6vulqxiy0Ixxxek9iVsPOVKiXPkXJ9jmkPtdkmuFTbUk8/E
 5fLjhAsynB6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="148748426"
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="148748426"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 16:48:47 -0700
IronPort-SDR: mYkdE6PGHDZpGMX1zVqeZLVKakSOkfJCtMiMaI0erZmwp9PgUaQQg5dkiM5v/arpCRkN7MzNjI
 P+XtGIlQa7Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="281570473"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga003.jf.intel.com with ESMTP; 13 Jul 2020 16:48:46 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Joerg Roedel" <joro@8bytes.org>, "Ingo Molnar" <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "H Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Felix Kuehling" <Felix.Kuehling@amd.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        "amd-gfx" <amd-gfx@lists.freedesktop.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v6 11/12] sched: Define and initialize a flag to identify valid PASID in the task
Date:   Mon, 13 Jul 2020 16:48:06 -0700
Message-Id: <1594684087-61184-12-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

The flag is defined for the task to identify if the task has a valid
PASID. Its initial value is 0 when the task is forked/cloned. It will
be used shortly.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
v2:
- Add this patch to define the flag to identify valid PASID MSR (PeterZ)

 include/linux/sched.h | 3 +++
 kernel/fork.c         | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 692e327d7455..042d6f5cde6a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -800,6 +800,9 @@ struct task_struct {
 	/* Stalled due to lack of memory */
 	unsigned			in_memstall:1;
 #endif
+#ifdef CONFIG_IOMMU_SUPPORT
+	unsigned			has_valid_pasid:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 43b5f112604d..0a962bebdf88 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -955,6 +955,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->use_memdelay = 0;
 #endif
 
+#ifdef CONFIG_IOMMU_SUPPORT
+	tsk->has_valid_pasid = 0;
+#endif
+
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
 #endif
-- 
2.19.1

