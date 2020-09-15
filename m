Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C5D26AA61
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 19:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgIORUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:20:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:36040 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbgIOQar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:30:47 -0400
IronPort-SDR: Dn86oh8PuPkxL0ZA/fHMaapbl5Vbyh4XrRq3+CadHogvO4Yengt35yMv39aAyy1qfZ6l+z0k4j
 IkwT6C8K7t9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="177365786"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="177365786"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 09:30:18 -0700
IronPort-SDR: JRIr5y4dbpXVKb1+imYwnCi0xFG2mDi348P96gAUmTOGpdlnPY47TI9dWBxfco/cloGuo+aHkO
 GwCM8zc7qzOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="345909876"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 15 Sep 2020 09:30:17 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v8 2/9] iommu/vt-d: Change flags type to unsigned int in binding mm
Date:   Tue, 15 Sep 2020 09:30:06 -0700
Message-Id: <1600187413-163670-3-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"flags" passed to intel_svm_bind_mm() is a bit mask and should be
defined as "unsigned int" instead of "int".

Change its type to "unsigned int".

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
v5:
- Reviewed by Lu Baolu

v2:
- Add this new patch per Thomas' comment.

 drivers/iommu/intel/svm.c   | 7 ++++---
 include/linux/intel-iommu.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index e78a74a9c1cf..fc90a079e228 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -446,7 +446,8 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 
 /* Caller must hold pasid_mutex, mm reference */
 static int
-intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
+intel_svm_bind_mm(struct device *dev, unsigned int flags,
+		  struct svm_dev_ops *ops,
 		  struct mm_struct *mm, struct intel_svm_dev **sd)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
@@ -1033,7 +1034,7 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
 	struct iommu_sva *sva = ERR_PTR(-EINVAL);
 	struct intel_svm_dev *sdev = NULL;
-	int flags = 0;
+	unsigned int flags = 0;
 	int ret;
 
 	/*
@@ -1042,7 +1043,7 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 	 * and intel_svm etc.
 	 */
 	if (drvdata)
-		flags = *(int *)drvdata;
+		flags = *(unsigned int *)drvdata;
 	mutex_lock(&pasid_mutex);
 	ret = intel_svm_bind_mm(dev, flags, NULL, mm, &sdev);
 	if (ret)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 7322073f62d0..9c3e8337442a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -765,7 +765,7 @@ struct intel_svm {
 	struct mm_struct *mm;
 
 	struct intel_iommu *iommu;
-	int flags;
+	unsigned int flags;
 	u32 pasid;
 	int gpasid; /* In case that guest PASID is different from host PASID */
 	struct list_head devs;
-- 
2.19.1

