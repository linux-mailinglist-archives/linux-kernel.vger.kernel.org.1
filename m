Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8852A3C93
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgKCGHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:07:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbgKCGHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:07:14 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15AC0222B9;
        Tue,  3 Nov 2020 06:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604383633;
        bh=iWvRT1sbKKsDu9PJC1iscR/kk7BPS+JW6WnMfh7Ulh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z9mFx8fgt/hAUb4hSxLUsFzhuoC2V45OdKKz4lsddOQGA0MEpdtk5MScLWb9KNvCc
         VBSZT3i1c9MfUUs4Z3nLQMjxg468PGN7Bu4SOhkg4lOCSHyo3n40ryqlACCSUjnjqw
         3AoyDjOifNnQS9c8Z+LDnkoPV7AOKf+/4pCffJUI=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     SW_Drivers@habana.ai, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 2/4] habanalabs/gaudi: add NIC firmware-related definitions
Date:   Tue,  3 Nov 2020 08:06:59 +0200
Message-Id: <20201103060701.25852-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103060701.25852-1-ogabbay@kernel.org>
References: <20201103060701.25852-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new structures and messages that the driver use to interact with the
firmware to receive information and events (errors) about GAUDI's NIC.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/include/common/cpucp_if.h | 34 ++++++++++++++++---
 .../habanalabs/include/gaudi/gaudi_fw_if.h    | 24 +++++++++++++
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 2a5c9cb3d505..782b8b8636be 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -9,6 +9,7 @@
 #define CPUCP_IF_H
 
 #include <linux/types.h>
+#include <linux/if_ether.h>
 
 /*
  * EVENT QUEUE
@@ -199,6 +200,11 @@ enum pq_init_status {
  *       CpuCP to write to the structure, to prevent data corruption in case of
  *       mismatched driver/FW versions.
  *
+ * CPUCP_PACKET_NIC_INFO_GET -
+ *       Fetch information from the device regarding the NIC. the host's driver
+ *       passes the max size it allows the CpuCP to write to the structure, to
+ *       prevent data corruption in case of mismatched driver/FW versions.
+ *
  * CPUCP_PACKET_TEMPERATURE_SET -
  *       Set the value of the offset property of a specified thermal sensor.
  *       The packet's arguments specify the desired sensor and the field to
@@ -244,12 +250,12 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_MAX_POWER_GET,		/* sysfs */
 	CPUCP_PACKET_MAX_POWER_SET,		/* sysfs */
 	CPUCP_PACKET_EEPROM_DATA_GET,		/* sysfs */
-	CPUCP_RESERVED,
+	CPUCP_PACKET_NIC_INFO_GET,		/* internal */
 	CPUCP_PACKET_TEMPERATURE_SET,		/* sysfs */
 	CPUCP_PACKET_VOLTAGE_SET,		/* sysfs */
 	CPUCP_PACKET_CURRENT_SET,		/* sysfs */
-	CPUCP_PACKET_PCIE_THROUGHPUT_GET,		/* internal */
-	CPUCP_PACKET_PCIE_REPLAY_CNT_GET,		/* internal */
+	CPUCP_PACKET_PCIE_THROUGHPUT_GET,	/* internal */
+	CPUCP_PACKET_PCIE_REPLAY_CNT_GET,	/* internal */
 	CPUCP_PACKET_TOTAL_ENERGY_GET,		/* internal */
 	CPUCP_PACKET_PLL_REG_GET,		/* internal */
 };
@@ -300,7 +306,7 @@ struct cpucp_packet {
 		/* For led set */
 		__le32 led_index;
 
-		/* For get CpuCP info/EEPROM data */
+		/* For get CpuCP info/EEPROM data/NIC info */
 		__le32 data_max_size;
 	};
 
@@ -392,6 +398,12 @@ struct eq_generic_event {
 #define CARD_NAME_MAX_LEN		16
 #define VERSION_MAX_LEN			128
 #define CPUCP_MAX_SENSORS		128
+#define CPUCP_MAX_NICS			128
+#define CPUCP_LANES_PER_NIC		4
+#define CPUCP_NIC_QSFP_EEPROM_MAX_LEN	1024
+#define CPUCP_MAX_NIC_LANES		(CPUCP_MAX_NICS * CPUCP_LANES_PER_NIC)
+#define CPUCP_NIC_MASK_ARR_LEN		((CPUCP_MAX_NICS + 63) / 64)
+#define CPUCP_NIC_POLARITY_ARR_LEN	((CPUCP_MAX_NIC_LANES + 63) / 64)
 
 struct cpucp_sensor {
 	__le32 type;
@@ -440,4 +452,18 @@ struct cpucp_info {
 	char card_name[CARD_NAME_MAX_LEN];
 };
 
+struct cpucp_mac_addr {
+	__u8 mac_addr[ETH_ALEN];
+};
+
+struct cpucp_nic_info {
+	struct cpucp_mac_addr mac_addrs[CPUCP_MAX_NICS];
+	__le64 link_mask[CPUCP_NIC_MASK_ARR_LEN];
+	__le64 pol_tx_mask[CPUCP_NIC_POLARITY_ARR_LEN];
+	__le64 pol_rx_mask[CPUCP_NIC_POLARITY_ARR_LEN];
+	__le64 link_ext_mask[CPUCP_NIC_MASK_ARR_LEN];
+	__u8 qsfp_eeprom[CPUCP_NIC_QSFP_EEPROM_MAX_LEN];
+	__le64 auto_neg_mask[CPUCP_NIC_MASK_ARR_LEN];
+};
+
 #endif /* CPUCP_IF_H */
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h b/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
index 8aadc6357da1..d61a4c87b765 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
@@ -8,6 +8,8 @@
 #ifndef GAUDI_FW_IF_H
 #define GAUDI_FW_IF_H
 
+#include <linux/types.h>
+
 #define GAUDI_EVENT_QUEUE_MSI_IDX	8
 #define GAUDI_NIC_PORT1_MSI_IDX		10
 #define GAUDI_NIC_PORT3_MSI_IDX		12
@@ -31,6 +33,28 @@ enum gaudi_pll_index {
 	IF_PLL
 };
 
+enum gaudi_nic_axi_error {
+	RXB,
+	RXE,
+	TXS,
+	TXE,
+	QPC_RESP,
+	NON_AXI_ERR,
+};
+
+/*
+ * struct eq_nic_sei_event - describes an AXI error cause.
+ * @axi_error_cause: one of the events defined in enum gaudi_nic_axi_error.
+ * @id: can be either 0 or 1, to further describe unit with interrupt cause
+ *      (i.e. TXE0 or TXE1).
+ * @pad[6]: padding structure to 64bit.
+ */
+struct eq_nic_sei_event {
+	__u8 axi_error_cause;
+	__u8 id;
+	__u8 pad[6];
+};
+
 #define GAUDI_PLL_FREQ_LOW		200000000 /* 200 MHz */
 
 #endif /* GAUDI_FW_IF_H */
-- 
2.17.1

