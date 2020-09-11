Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11B26691D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 21:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgIKTqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 15:46:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:13920 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgIKTqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 15:46:16 -0400
IronPort-SDR: pduanDzBijZFKfLOaWwjlJaqy2E8iuVGQrnOPTSUHlNCkdycW4DasO6zMOxCvH1Zoj8jvULlWZ
 EHJDnCtMYY7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="156291249"
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="156291249"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 12:46:15 -0700
IronPort-SDR: iLAaNdL18OHKCyLqwTaCcoW2BOOKTnzxP2ZUVmvoyjQA9Q7PxfJU4zaQxZ1LqpDJ8DD3XqFCP5
 CEk/gWNVIiYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="342401238"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2020 12:46:15 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 0AA1058094D;
        Fri, 11 Sep 2020 12:46:15 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org,
        alexander.h.duyck@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/3] mfd: intel_pmt: Add OOBMSM device ID
Date:   Fri, 11 Sep 2020 12:45:47 -0700
Message-Id: <20200911194549.12780-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911194549.12780-1-david.e.box@linux.intel.com>
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Out of Band Management Services Module device ID to Intel PMT driver.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/mfd/intel_pmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
index 0e572b105101..8f9970ab3026 100644
--- a/drivers/mfd/intel_pmt.c
+++ b/drivers/mfd/intel_pmt.c
@@ -55,6 +55,8 @@ struct pmt_platform_info {
 	unsigned long quirks;
 };
 
+static const struct pmt_platform_info pmt_info;
+
 static const struct pmt_platform_info tgl_info = {
 	.quirks = PMT_QUIRK_NO_WATCHER | PMT_QUIRK_NO_CRASHLOG |
 		  PMT_QUIRK_TABLE_SHIFT,
@@ -200,8 +202,10 @@ static void pmt_pci_remove(struct pci_dev *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 }
 
+#define PCI_DEVICE_ID_INTEL_PMT_OOBMSM	0x09a7
 #define PCI_DEVICE_ID_INTEL_PMT_TGL	0x9a0d
 static const struct pci_device_id pmt_pci_ids[] = {
+	{ PCI_DEVICE_DATA(INTEL, PMT_OOBMSM, &pmt_info) },
 	{ PCI_DEVICE_DATA(INTEL, PMT_TGL, &tgl_info) },
 	{ }
 };
-- 
2.20.1

