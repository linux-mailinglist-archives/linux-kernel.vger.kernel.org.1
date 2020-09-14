Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C304268F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgINOrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:47:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:14947 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgINOnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:43:32 -0400
IronPort-SDR: h5Pp35orws1Tf8YEIFS+UcvSSiKHsiXZKLjUhYd69sX6XJCTdccEhQbI+DofP5jh2kKEuKDXsw
 e8yOI52U0PvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="223270416"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="223270416"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 07:43:25 -0700
IronPort-SDR: kbr6pvTwJulvQnYypXZm5uhGnH3jKI15lss3U8xQNp58Phn98v+Pj8MYM8eD5prgG6FKGlDaub
 xe41+f0g53SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="335304747"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga008.jf.intel.com with ESMTP; 14 Sep 2020 07:43:25 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH V2 3/6] perf/x86/intel/uncore: Factor out uncore_pci_pmu_register()
Date:   Mon, 14 Sep 2020 07:34:17 -0700
Message-Id: <1600094060-82746-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600094060-82746-1-git-send-email-kan.liang@linux.intel.com>
References: <1600094060-82746-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The PMU registration in the uncore PCI sub driver is similar as the
normal PMU registration for a PCI device. The codes to register a PCI
PMU can be shared.

Factor out uncore_pci_pmu_register(), which will be used later.

The pci_set_drvdata() is not included in uncore_pci_pmu_register(). The
uncore PCI sub driver doesn't own the PCI device. It will not touch the
private driver data pointer for the device.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 82 ++++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index f6ff1b9..a884747 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1040,13 +1040,61 @@ uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
 }
 
 /*
+ * Register the PMU for a PCI device
+ * @pdev: The PCI device.
+ * @type: The corresponding PMU type of the device.
+ * @pmu: The corresponding PMU of the device.
+ * @phys_id: The physical socket id which the device maps to.
+ * @die: The die id which the device maps to.
+ */
+static int uncore_pci_pmu_register(struct pci_dev *pdev,
+				   struct intel_uncore_type *type,
+				   struct intel_uncore_pmu *pmu,
+				   int phys_id, int die)
+{
+	struct intel_uncore_box *box;
+	int ret;
+
+	if (WARN_ON_ONCE(pmu->boxes[die] != NULL))
+		return -EINVAL;
+
+	box = uncore_alloc_box(type, NUMA_NO_NODE);
+	if (!box)
+		return -ENOMEM;
+
+	if (pmu->func_id < 0)
+		pmu->func_id = pdev->devfn;
+	else
+		WARN_ON_ONCE(pmu->func_id != pdev->devfn);
+
+	atomic_inc(&box->refcnt);
+	box->pci_phys_id = phys_id;
+	box->dieid = die;
+	box->pci_dev = pdev;
+	box->pmu = pmu;
+	uncore_box_init(box);
+
+	pmu->boxes[die] = box;
+	if (atomic_inc_return(&pmu->activeboxes) > 1)
+		return 0;
+
+	/* First active box registers the pmu */
+	ret = uncore_pmu_register(pmu);
+	if (ret) {
+		pmu->boxes[die] = NULL;
+		uncore_box_exit(box);
+		kfree(box);
+	}
+	return ret;
+}
+
+/*
  * add a pci uncore device
  */
 static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct intel_uncore_type *type;
 	struct intel_uncore_pmu *pmu = NULL;
-	struct intel_uncore_box *box;
 	int phys_id, die, ret;
 
 	ret = uncore_pci_get_dev_die_info(pdev, &phys_id, &die);
@@ -1082,38 +1130,10 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		pmu = &type->pmus[UNCORE_PCI_DEV_IDX(id->driver_data)];
 	}
 
-	if (WARN_ON_ONCE(pmu->boxes[die] != NULL))
-		return -EINVAL;
-
-	box = uncore_alloc_box(type, NUMA_NO_NODE);
-	if (!box)
-		return -ENOMEM;
+	ret = uncore_pci_pmu_register(pdev, type, pmu, phys_id, die);
 
-	if (pmu->func_id < 0)
-		pmu->func_id = pdev->devfn;
-	else
-		WARN_ON_ONCE(pmu->func_id != pdev->devfn);
+	pci_set_drvdata(pdev, pmu->boxes[die]);
 
-	atomic_inc(&box->refcnt);
-	box->pci_phys_id = phys_id;
-	box->dieid = die;
-	box->pci_dev = pdev;
-	box->pmu = pmu;
-	uncore_box_init(box);
-	pci_set_drvdata(pdev, box);
-
-	pmu->boxes[die] = box;
-	if (atomic_inc_return(&pmu->activeboxes) > 1)
-		return 0;
-
-	/* First active box registers the pmu */
-	ret = uncore_pmu_register(pmu);
-	if (ret) {
-		pci_set_drvdata(pdev, NULL);
-		pmu->boxes[die] = NULL;
-		uncore_box_exit(box);
-		kfree(box);
-	}
 	return ret;
 }
 
-- 
2.7.4

