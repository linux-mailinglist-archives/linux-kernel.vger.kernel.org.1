Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A071AB4D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 02:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404568AbgDPAi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 20:38:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:10260 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404525AbgDPAiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:38:52 -0400
IronPort-SDR: SMN6ii3VJthkv+rvmlhj0yKh62pECxbGpUTrH89JrrYeFXXgT17fJIaTX+8cAg7GS+X9tkSvbB
 EYL8zYSm1F8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 17:38:45 -0700
IronPort-SDR: Cyz5Q3fyBgotQFCvSDOCnrYU5L4EDVw0RbDMjDHiPPpXUbTpXyCe4MQI67zQTdLVtqxHCEHYTL
 8yL3qsiwj3iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="245833729"
Received: from rrnash-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.255.230.113])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2020 17:38:44 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 1/1] PCI/EDR: Change ACPI event message log level
Date:   Wed, 15 Apr 2020 17:38:32 -0700
Message-Id: <01afb4e01efbe455de0c445bef6cf3ffc59340d2.1586996350.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently we have pci_info() message in the beginning of
edr_handle_event() function, which will be printing
notification details every-time firmware sends ACPI SYSTEM
level events. This will pollute the dmesg logs for systems
that has lot for ACPI system level notifications. So change
the log-level to pci_dbg, and add a new info log for EDR
events.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/edr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index 594622a6cb16..e346c82559fa 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -148,11 +148,13 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	pci_ers_result_t estate = PCI_ERS_RESULT_DISCONNECT;
 	u16 status;
 
-	pci_info(pdev, "ACPI event %#x received\n", event);
+	pci_dbg(pdev, "ACPI event %#x received\n", event);
 
 	if (event != ACPI_NOTIFY_DISCONNECT_RECOVER)
 		return;
 
+	pci_info(pdev, "EDR event received\n");
+
 	/* Locate the port which issued EDR event */
 	edev = acpi_dpc_port_get(pdev);
 	if (!edev) {
-- 
2.17.1

