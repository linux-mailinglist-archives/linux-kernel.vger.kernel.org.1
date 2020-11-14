Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF22B2D25
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 13:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKNMif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 07:38:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKNMif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 07:38:35 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E91206F9;
        Sat, 14 Nov 2020 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605357514;
        bh=zWXg7qJz+2Sg2saXECILVeerquBsEIlBLdhabO0MzaY=;
        h=From:To:Cc:Subject:Date:From;
        b=FM9lC0CAEnQNPpIUCiz8iiNcJ/e7wL642Xk/pn9ths1/bJk5ecpOswdqegpS4Cz4y
         8vTGz2ZeiS3GSQi2U1CuPX2llkz0tfX8bOcfON/Lzwv4Ulwahf/ZyOj8pgEmF/zf50
         +2i2v8/jkJGdR+XZUcpv6/Hl9e47HcpykBxJ19EE=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Alon Mizrahi <amizrahi@habana.ai>
Subject: [PATCH] habanalabs: firmware returns 64bit argument
Date:   Sat, 14 Nov 2020 14:38:28 +0200
Message-Id: <20201114123828.20817-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Mizrahi <amizrahi@habana.ai>

F/W message returns 64bit value but up until now we casted it to
a 32bit variable, instead of receiving 64bit in the first place.

Signed-off-by: Alon Mizrahi <amizrahi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c     |  5 +++-
 drivers/misc/habanalabs/common/firmware_if.c | 26 ++++++++++----------
 drivers/misc/habanalabs/common/habanalabs.h  |  4 +--
 drivers/misc/habanalabs/common/hwmon.c       | 25 +++++++++++++++----
 drivers/misc/habanalabs/common/sysfs.c       | 10 ++++----
 drivers/misc/habanalabs/gaudi/gaudi.c        |  2 +-
 drivers/misc/habanalabs/goya/goya.c          |  6 ++---
 drivers/misc/habanalabs/goya/goyaP.h         |  2 +-
 8 files changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 1db804de45ba..b47a62da0b41 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -22,6 +22,7 @@ static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 				u8 i2c_reg, long *val)
 {
 	struct cpucp_packet pkt;
+	u64 result;
 	int rc;
 
 	if (!hl_device_operational(hdev, NULL))
@@ -36,7 +37,9 @@ static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 	pkt.i2c_reg = i2c_reg;
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						0, val);
+						0, &result);
+
+	*val = (long) result;
 
 	if (rc)
 		dev_err(hdev->dev, "Failed to read from I2C, error %d\n", rc);
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index e37d451e6415..8f70d0bbe5e1 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -88,7 +88,7 @@ int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode)
 }
 
 int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
-				u16 len, u32 timeout, long *result)
+				u16 len, u32 timeout, u64 *result)
 {
 	struct cpucp_packet *pkt;
 	dma_addr_t pkt_dma_addr;
@@ -143,7 +143,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 						>> CPUCP_PKT_CTL_OPCODE_SHIFT);
 		rc = -EIO;
 	} else if (result) {
-		*result = (long) le64_to_cpu(pkt->result);
+		*result = le64_to_cpu(pkt->result);
 	}
 
 out:
@@ -157,7 +157,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 int hl_fw_unmask_irq(struct hl_device *hdev, u16 event_type)
 {
 	struct cpucp_packet pkt;
-	long result;
+	u64 result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -180,7 +180,7 @@ int hl_fw_unmask_irq_arr(struct hl_device *hdev, const u32 *irq_arr,
 {
 	struct cpucp_unmask_irq_arr_packet *pkt;
 	size_t total_pkt_size;
-	long result;
+	u64 result;
 	int rc;
 
 	total_pkt_size = sizeof(struct cpucp_unmask_irq_arr_packet) +
@@ -219,7 +219,7 @@ int hl_fw_unmask_irq_arr(struct hl_device *hdev, const u32 *irq_arr,
 int hl_fw_test_cpu_queue(struct hl_device *hdev)
 {
 	struct cpucp_packet test_pkt = {};
-	long result;
+	u64 result;
 	int rc;
 
 	test_pkt.ctl = cpu_to_le32(CPUCP_PACKET_TEST <<
@@ -232,7 +232,7 @@ int hl_fw_test_cpu_queue(struct hl_device *hdev)
 	if (!rc) {
 		if (result != CPUCP_PACKET_FENCE_VAL)
 			dev_err(hdev->dev,
-				"CPU queue test failed (0x%08lX)\n", result);
+				"CPU queue test failed (%#08llx)\n", result);
 	} else {
 		dev_err(hdev->dev, "CPU queue test failed, error %d\n", rc);
 	}
@@ -263,7 +263,7 @@ void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 int hl_fw_send_heartbeat(struct hl_device *hdev)
 {
 	struct cpucp_packet hb_pkt = {};
-	long result;
+	u64 result;
 	int rc;
 
 	hb_pkt.ctl = cpu_to_le32(CPUCP_PACKET_TEST <<
@@ -285,7 +285,7 @@ int hl_fw_cpucp_info_get(struct hl_device *hdev)
 	struct cpucp_packet pkt = {};
 	void *cpucp_info_cpu_addr;
 	dma_addr_t cpucp_info_dma_addr;
-	long result;
+	u64 result;
 	int rc;
 
 	cpucp_info_cpu_addr =
@@ -336,7 +336,7 @@ int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 	struct cpucp_packet pkt = {};
 	void *eeprom_info_cpu_addr;
 	dma_addr_t eeprom_info_dma_addr;
-	long result;
+	u64 result;
 	int rc;
 
 	eeprom_info_cpu_addr =
@@ -379,7 +379,7 @@ int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 		struct hl_info_pci_counters *counters)
 {
 	struct cpucp_packet pkt = {};
-	long result;
+	u64 result;
 	int rc;
 
 	pkt.ctl = cpu_to_le32(CPUCP_PACKET_PCIE_THROUGHPUT_GET <<
@@ -426,7 +426,7 @@ int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 int hl_fw_cpucp_total_energy_get(struct hl_device *hdev, u64 *total_energy)
 {
 	struct cpucp_packet pkt = {};
-	long result;
+	u64 result;
 	int rc;
 
 	pkt.ctl = cpu_to_le32(CPUCP_PACKET_TOTAL_ENERGY_GET <<
@@ -452,7 +452,7 @@ int hl_fw_cpucp_pll_info_get(struct hl_device *hdev,
 		u32 *pll_info)
 {
 	struct cpucp_packet pkt;
-	long result;
+	u64 result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -467,7 +467,7 @@ int hl_fw_cpucp_pll_info_get(struct hl_device *hdev,
 	if (rc)
 		dev_err(hdev->dev, "Failed to read PLL info, error %d\n", rc);
 
-	*pll_info = result;
+	*pll_info = (u32) result;
 
 	return rc;
 }
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index b8ad5bfa6359..43aa8cbd8969 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -925,7 +925,7 @@ struct hl_asic_funcs {
 	int (*get_eeprom_data)(struct hl_device *hdev, void *data,
 				size_t max_size);
 	int (*send_cpu_message)(struct hl_device *hdev, u32 *msg,
-				u16 len, u32 timeout, long *result);
+				u16 len, u32 timeout, u64 *result);
 	int (*pci_bars_map)(struct hl_device *hdev);
 	int (*init_iatu)(struct hl_device *hdev);
 	u32 (*rreg)(struct hl_device *hdev, u32 reg);
@@ -2178,7 +2178,7 @@ int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 				void __iomem *dst, u32 src_offset, u32 size);
 int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode);
 int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
-				u16 len, u32 timeout, long *result);
+				u16 len, u32 timeout, u64 *result);
 int hl_fw_unmask_irq(struct hl_device *hdev, u16 event_type);
 int hl_fw_unmask_irq_arr(struct hl_device *hdev, const u32 *irq_arr,
 		size_t irq_arr_size);
diff --git a/drivers/misc/habanalabs/common/hwmon.c b/drivers/misc/habanalabs/common/hwmon.c
index ab96401c3752..6b421d76b311 100644
--- a/drivers/misc/habanalabs/common/hwmon.c
+++ b/drivers/misc/habanalabs/common/hwmon.c
@@ -312,6 +312,7 @@ int hl_get_temperature(struct hl_device *hdev,
 			int sensor_index, u32 attr, long *value)
 {
 	struct cpucp_packet pkt;
+	u64 result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -322,7 +323,9 @@ int hl_get_temperature(struct hl_device *hdev,
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						0, value);
+						0, &result);
+
+	*value = (long) result;
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -363,6 +366,7 @@ int hl_get_voltage(struct hl_device *hdev,
 			int sensor_index, u32 attr, long *value)
 {
 	struct cpucp_packet pkt;
+	u64 result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -373,7 +377,9 @@ int hl_get_voltage(struct hl_device *hdev,
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						0, value);
+						0, &result);
+
+	*value = (long) result;
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -389,6 +395,7 @@ int hl_get_current(struct hl_device *hdev,
 			int sensor_index, u32 attr, long *value)
 {
 	struct cpucp_packet pkt;
+	u64 result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -399,7 +406,9 @@ int hl_get_current(struct hl_device *hdev,
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						0, value);
+						0, &result);
+
+	*value = (long) result;
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -415,6 +424,7 @@ int hl_get_fan_speed(struct hl_device *hdev,
 			int sensor_index, u32 attr, long *value)
 {
 	struct cpucp_packet pkt;
+	u64 result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -425,7 +435,9 @@ int hl_get_fan_speed(struct hl_device *hdev,
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						0, value);
+						0, &result);
+
+	*value = (long) result;
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -441,6 +453,7 @@ int hl_get_pwm_info(struct hl_device *hdev,
 			int sensor_index, u32 attr, long *value)
 {
 	struct cpucp_packet pkt;
+	u64 result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -451,7 +464,9 @@ int hl_get_pwm_info(struct hl_device *hdev,
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						0, value);
+						0, &result);
+
+	*value = (long) result;
 
 	if (rc) {
 		dev_err(hdev->dev,
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 94ca68e62000..4366d8f93842 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -12,7 +12,7 @@
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
 {
 	struct cpucp_packet pkt;
-	long result;
+	u64 result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -32,10 +32,10 @@ long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
 		dev_err(hdev->dev,
 			"Failed to get frequency of PLL %d, error %d\n",
 			pll_index, rc);
-		result = rc;
+		return rc;
 	}
 
-	return result;
+	return (long) result;
 }
 
 void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq)
@@ -62,7 +62,7 @@ void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq)
 u64 hl_get_max_power(struct hl_device *hdev)
 {
 	struct cpucp_packet pkt;
-	long result;
+	u64 result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -75,7 +75,7 @@ u64 hl_get_max_power(struct hl_device *hdev)
 
 	if (rc) {
 		dev_err(hdev->dev, "Failed to get max power, error %d\n", rc);
-		result = rc;
+		return (u64) rc;
 	}
 
 	return result;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f1b8d20cf2ce..9c9df5f020a6 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4572,7 +4572,7 @@ static void *gaudi_get_int_queue_base(struct hl_device *hdev,
 }
 
 static int gaudi_send_cpu_message(struct hl_device *hdev, u32 *msg,
-				u16 len, u32 timeout, long *result)
+				u16 len, u32 timeout, u64 *result)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 3398b4cc1298..55d174d3cac8 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2954,7 +2954,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 }
 
 int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
-				u32 timeout, long *result)
+				u32 timeout, u64 *result)
 {
 	struct goya_device *goya = hdev->asic_specific;
 
@@ -4540,7 +4540,7 @@ static int goya_unmask_irq_arr(struct hl_device *hdev, u32 *irq_arr,
 {
 	struct cpucp_unmask_irq_arr_packet *pkt;
 	size_t total_pkt_size;
-	long result;
+	u64 result;
 	int rc;
 	int irq_num_entries, irq_arr_index;
 	__le32 *goya_irq_arr;
@@ -4599,7 +4599,7 @@ static int goya_soft_reset_late_init(struct hl_device *hdev)
 static int goya_unmask_irq(struct hl_device *hdev, u16 event_type)
 {
 	struct cpucp_packet pkt;
-	long result;
+	u64 result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index ef4298f84a0a..8b3408211af6 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -192,7 +192,7 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id);
 int goya_test_queues(struct hl_device *hdev);
 int goya_test_cpu_queue(struct hl_device *hdev);
 int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
-				u32 timeout, long *result);
+				u32 timeout, u64 *result);
 
 long goya_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr);
 long goya_get_voltage(struct hl_device *hdev, int sensor_index, u32 attr);
-- 
2.17.1

