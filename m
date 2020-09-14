Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA35268E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgINOqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:46:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:14939 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgINOnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:43:31 -0400
IronPort-SDR: koxwXxHf2bOPw3XBDs2KblAHbo1G/d1o5SbVRmrULWTq13gefq1aIeiGrCQlbkBnfftItRuZY/
 r3a93n7FKMPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="223270415"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="223270415"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 07:43:25 -0700
IronPort-SDR: 6Q9BMM82o9yS6a670PAdSCwR8hF8boxWJ+RRrVn6ocI1Q8Irxsv5LNeeM7+Lh12Rr4oCyCQink
 79HTH1OrrQxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="335304746"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga008.jf.intel.com with ESMTP; 14 Sep 2020 07:43:25 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH V2 2/6] perf/x86/intel/uncore: Factor out uncore_pci_find_dev_pmu()
Date:   Mon, 14 Sep 2020 07:34:16 -0700
Message-Id: <1600094060-82746-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600094060-82746-1-git-send-email-kan.liang@linux.intel.com>
References: <1600094060-82746-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

When an uncore PCI sub driver gets a remove notification, the
corresponding PMU has to be retrieved and unregistered. The codes, which
find the corresponding PMU by comparing the pci_device_id table, can be
shared.

Factor out uncore_pci_find_dev_pmu(), which will be used later.

There is no functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 48 +++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e14b03f..f6ff1b9 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1008,6 +1008,37 @@ static int uncore_pci_get_dev_die_info(struct pci_dev *pdev,
 
 	return 0;
 }
+
+/*
+ * Find the PMU of a PCI device.
+ * @pdev: The PCI device.
+ * @ids: The ID table of the available PCI devices with a PMU.
+ */
+static struct intel_uncore_pmu *
+uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
+{
+	struct intel_uncore_pmu *pmu = NULL;
+	struct intel_uncore_type *type;
+	kernel_ulong_t data;
+	unsigned int devfn;
+
+	while (ids && ids->vendor) {
+		if ((ids->vendor == pdev->vendor) &&
+		    (ids->device == pdev->device)) {
+			data = ids->driver_data;
+			devfn = PCI_DEVFN(UNCORE_PCI_DEV_DEV(data),
+					  UNCORE_PCI_DEV_FUNC(data));
+			if (devfn == pdev->devfn) {
+				type = uncore_pci_uncores[UNCORE_PCI_DEV_TYPE(data)];
+				pmu = &type->pmus[UNCORE_PCI_DEV_IDX(data)];
+				break;
+			}
+		}
+		ids++;
+	}
+	return pmu;
+}
+
 /*
  * add a pci uncore device
  */
@@ -1039,21 +1070,8 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	 */
 	if (id->driver_data & ~0xffff) {
 		struct pci_driver *pci_drv = pdev->driver;
-		const struct pci_device_id *ids = pci_drv->id_table;
-		unsigned int devfn;
-
-		while (ids && ids->vendor) {
-			if ((ids->vendor == pdev->vendor) &&
-			    (ids->device == pdev->device)) {
-				devfn = PCI_DEVFN(UNCORE_PCI_DEV_DEV(ids->driver_data),
-						  UNCORE_PCI_DEV_FUNC(ids->driver_data));
-				if (devfn == pdev->devfn) {
-					pmu = &type->pmus[UNCORE_PCI_DEV_IDX(ids->driver_data)];
-					break;
-				}
-			}
-			ids++;
-		}
+
+		pmu = uncore_pci_find_dev_pmu(pdev, pci_drv->id_table);
 		if (pmu == NULL)
 			return -ENODEV;
 	} else {
-- 
2.7.4

