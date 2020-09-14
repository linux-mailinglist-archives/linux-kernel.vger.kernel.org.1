Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4829268E30
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgINOrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:47:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:14942 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgINOnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:43:31 -0400
IronPort-SDR: WNSGHUzA4TOW1GC8B9MUCnwJWi6egiRQHYmweDPNPZ4f8ERfOe60EhVLsfPwjw2edEjK4NAUY/
 +Chiz2f9Fszw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="223270417"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="223270417"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 07:43:25 -0700
IronPort-SDR: ZEpJEbC1ujj9MH0ka8T0lMXr/vORNscb8Wz30KQQmMjMN1FKATlh/msolkpH9vMPoz2EuL6FG9
 7DfCdM536Q/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="335304748"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga008.jf.intel.com with ESMTP; 14 Sep 2020 07:43:25 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH V2 4/6] perf/x86/intel/uncore: Factor out uncore_pci_pmu_unregister()
Date:   Mon, 14 Sep 2020 07:34:18 -0700
Message-Id: <1600094060-82746-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600094060-82746-1-git-send-email-kan.liang@linux.intel.com>
References: <1600094060-82746-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The PMU unregistration in the uncore PCI sub driver is similar as the
normal PMU unregistration for a PCI device. The codes to unregister a
PCI PMU can be shared.

Factor out uncore_pci_pmu_unregister(), which will be used later.

Use uncore_pci_get_dev_die_info() to replace the codes which retrieve
the socket and die informaion.

The pci_set_drvdata() is not included in uncore_pci_pmu_unregister() as
well, because the uncore PCI sub driver will not touch the private
driver data pointer of the device.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a884747..428a2c0 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1137,18 +1137,38 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	return ret;
 }
 
+/*
+ * Unregister the PMU of a PCI device
+ * @pmu: The corresponding PMU is unregistered.
+ * @phys_id: The physical socket id which the device maps to.
+ * @die: The die id which the device maps to.
+ */
+static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu,
+				      int phys_id, int die)
+{
+	struct intel_uncore_box *box = pmu->boxes[die];
+
+	if (WARN_ON_ONCE(phys_id != box->pci_phys_id))
+		return;
+
+	pmu->boxes[die] = NULL;
+	if (atomic_dec_return(&pmu->activeboxes) == 0)
+		uncore_pmu_unregister(pmu);
+	uncore_box_exit(box);
+	kfree(box);
+}
+
 static void uncore_pci_remove(struct pci_dev *pdev)
 {
 	struct intel_uncore_box *box;
 	struct intel_uncore_pmu *pmu;
 	int i, phys_id, die;
 
-	phys_id = uncore_pcibus_to_physid(pdev->bus);
+	if (uncore_pci_get_dev_die_info(pdev, &phys_id, &die))
+		return;
 
 	box = pci_get_drvdata(pdev);
 	if (!box) {
-		die = (topology_max_die_per_package() > 1) ? phys_id :
-					topology_phys_to_logical_pkg(phys_id);
 		for (i = 0; i < UNCORE_EXTRA_PCI_DEV_MAX; i++) {
 			if (uncore_extra_pci_dev[die].dev[i] == pdev) {
 				uncore_extra_pci_dev[die].dev[i] = NULL;
@@ -1160,15 +1180,10 @@ static void uncore_pci_remove(struct pci_dev *pdev)
 	}
 
 	pmu = box->pmu;
-	if (WARN_ON_ONCE(phys_id != box->pci_phys_id))
-		return;
 
 	pci_set_drvdata(pdev, NULL);
-	pmu->boxes[box->dieid] = NULL;
-	if (atomic_dec_return(&pmu->activeboxes) == 0)
-		uncore_pmu_unregister(pmu);
-	uncore_box_exit(box);
-	kfree(box);
+
+	uncore_pci_pmu_unregister(pmu, phys_id, die);
 }
 
 static int __init uncore_pci_init(void)
-- 
2.7.4

