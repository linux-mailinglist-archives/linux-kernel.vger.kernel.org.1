Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38113268E25
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgINOp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:45:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:14939 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbgINOn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:43:26 -0400
IronPort-SDR: ZnJV7Povz2nCC40+fyXzlTmM7hmscmBnP1MHVj8XonIaRMSHIk7zHgCe7l4dH7WG1yw84Z7BLE
 2k5J9mf3ff3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="223270414"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="223270414"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 07:43:25 -0700
IronPort-SDR: /7iTwOOpQJ4XVp3/NFshsGp/W7pTi7xySnWs2tPdwwKGfLP/F5I107+3xTmPSvSRWfzGEcu2YG
 n2XlNtNJO0cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="335304744"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga008.jf.intel.com with ESMTP; 14 Sep 2020 07:43:24 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH V2 1/6] perf/x86/intel/uncore: Factor out uncore_pci_get_dev_die_info()
Date:   Mon, 14 Sep 2020 07:34:15 -0700
Message-Id: <1600094060-82746-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600094060-82746-1-git-send-email-kan.liang@linux.intel.com>
References: <1600094060-82746-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The socket and die information is required to register/unregister a PMU
in the uncore PCI sub driver. The codes, which get the socket and die
information from a BUS number, can be shared.

Factor out uncore_pci_get_dev_die_info(), which will be used later.

There is no functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d5c6d3b..e14b03f 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -989,6 +989,26 @@ uncore_types_init(struct intel_uncore_type **types, bool setid)
 }
 
 /*
+ * Get the die information of a PCI device.
+ * @pdev: The PCI device.
+ * @phys_id: The physical socket id which the device maps to.
+ * @die: The die id which the device maps to.
+ */
+static int uncore_pci_get_dev_die_info(struct pci_dev *pdev,
+				       int *phys_id, int *die)
+{
+	*phys_id = uncore_pcibus_to_physid(pdev->bus);
+	if (*phys_id < 0)
+		return -ENODEV;
+
+	*die = (topology_max_die_per_package() > 1) ? *phys_id :
+				topology_phys_to_logical_pkg(*phys_id);
+	if (*die < 0)
+		return -EINVAL;
+
+	return 0;
+}
+/*
  * add a pci uncore device
  */
 static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -998,14 +1018,9 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	struct intel_uncore_box *box;
 	int phys_id, die, ret;
 
-	phys_id = uncore_pcibus_to_physid(pdev->bus);
-	if (phys_id < 0)
-		return -ENODEV;
-
-	die = (topology_max_die_per_package() > 1) ? phys_id :
-					topology_phys_to_logical_pkg(phys_id);
-	if (die < 0)
-		return -EINVAL;
+	ret = uncore_pci_get_dev_die_info(pdev, &phys_id, &die);
+	if (ret)
+		return ret;
 
 	if (UNCORE_PCI_DEV_TYPE(id->driver_data) == UNCORE_EXTRA_PCI_DEV) {
 		int idx = UNCORE_PCI_DEV_IDX(id->driver_data);
-- 
2.7.4

