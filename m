Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA8F2F39B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406680AbhALTKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406476AbhALTKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:10:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B84E2311F;
        Tue, 12 Jan 2021 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478562;
        bh=oEQqTeYP7WdO09TD4mlaUKgYrwXd+8dnrM6JxfB05mU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kN2Zr5tjwztTL/usemeZ1DBooUhu2fgoLXHc1TQM2HsjXwY0MHOC2fTtLNcIYXAi/
         f8o0AwrtvAUDwSaCq7jXEVWJdEWisK6Aozq72oClG2Ij3TnrNnM6rnXOg34mGVRcz9
         X623hmD9iIhfwOXRbhO6bY620JFVh0T7Nz1KFx1nmy41JyCGIeDhOeM2s243kU62JY
         BtcyDelk2E8riF6SDbfX4F8Htw48wFx2bBO9daRny6Kn4wTcPjHarzs+mk34X06olY
         Vp8pGbP2kkFdshQoczIxsOqUwvxN/o6Jnlcq9QM6sVKsWO5iT5kjjMYwgbI27TCUOU
         Z7JTyvs4H1qug==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 4/4] habanalabs: add security violations dump to debugfs
Date:   Tue, 12 Jan 2021 21:09:15 +0200
Message-Id: <20210112190915.21164-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210112190915.21164-1-ogabbay@kernel.org>
References: <20210112190915.21164-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to improve driver security debuggability, we add
security violations dump to debugfs.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../ABI/testing/debugfs-driver-habanalabs     |  8 +++++++
 drivers/misc/habanalabs/common/debugfs.c      | 22 +++++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   |  2 ++
 drivers/misc/habanalabs/gaudi/gaudi.c         |  3 ++-
 drivers/misc/habanalabs/gaudi/gaudiP.h        |  1 +
 .../misc/habanalabs/gaudi/gaudi_security.c    |  5 +++++
 drivers/misc/habanalabs/goya/goya.c           |  3 ++-
 drivers/misc/habanalabs/goya/goyaP.h          |  1 +
 drivers/misc/habanalabs/goya/goya_security.c  |  5 +++++
 9 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index c5d678d39144..3979bfdaa080 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -182,3 +182,11 @@ KernelVersion:  5.6
 Contact:        oded.gabbay@gmail.com
 Description:    Sets the stop-on_error option for the device engines. Value of
                 "0" is for disable, otherwise enable.
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/dump_security_violations
+Date:           Jan 2021
+KernelVersion:  5.12
+Contact:        oded.gabbay@gmail.com
+Description:    Dumps all security violations to dmesg. This will also ack
+                all security violations meanings those violations will not be
+                dumped next time user calls this API
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 50ca8eea6648..323d0381a60a 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -867,6 +867,17 @@ static ssize_t hl_stop_on_err_write(struct file *f, const char __user *buf,
 	return count;
 }
 
+static ssize_t hl_security_violations_read(struct file *f, char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+
+	hdev->asic_funcs->ack_protection_bits_errors(hdev);
+
+	return 0;
+}
+
 static const struct file_operations hl_data32b_fops = {
 	.owner = THIS_MODULE,
 	.read = hl_data_read32,
@@ -924,6 +935,11 @@ static const struct file_operations hl_stop_on_err_fops = {
 	.write = hl_stop_on_err_write
 };
 
+static const struct file_operations hl_security_violations_fops = {
+	.owner = THIS_MODULE,
+	.read = hl_security_violations_read
+};
+
 static const struct hl_info_list hl_debugfs_list[] = {
 	{"command_buffers", command_buffers_show, NULL},
 	{"command_submission", command_submission_show, NULL},
@@ -1073,6 +1089,12 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 				dev_entry,
 				&hl_stop_on_err_fops);
 
+	debugfs_create_file("dump_security_violations",
+				0644,
+				dev_entry->root,
+				dev_entry,
+				&hl_security_violations_fops);
+
 	for (i = 0, entry = dev_entry->entry_arr ; i < count ; i++, entry++) {
 
 		ent = debugfs_create_file(hl_debugfs_list[i].name,
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index d3c73fc7baf7..454ef3bfe2e7 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -850,6 +850,7 @@ enum div_select_defs {
  * @collective_wait_create_jobs: allocate collective wait cs jobs
  * @scramble_vaddr: Routine to scramble the virtual address prior of mapping it
  *                  in the MMU.
+ * @ack_protection_bits_errors: ack and dump all security violations
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -960,6 +961,7 @@ struct hl_asic_funcs {
 			struct hl_ctx *ctx, struct hl_cs *cs, u32 wait_queue_id,
 			u32 collective_engine_id);
 	u64 (*scramble_vaddr)(struct hl_device *hdev, u64 virt_addr);
+	void (*ack_protection_bits_errors)(struct hl_device *hdev);
 };
 
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 126650e3a9ad..36e2cc22d108 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8545,7 +8545,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.get_device_time = gaudi_get_device_time,
 	.collective_wait_init_cs = gaudi_collective_wait_init_cs,
 	.collective_wait_create_jobs = gaudi_collective_wait_create_jobs,
-	.scramble_vaddr = hl_mmu_scramble_vaddr
+	.scramble_vaddr = hl_mmu_scramble_vaddr,
+	.ack_protection_bits_errors = gaudi_ack_protection_bits_errors
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 78830443341d..50bb4ad570fd 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -335,6 +335,7 @@ struct gaudi_device {
 };
 
 void gaudi_init_security(struct hl_device *hdev);
+void gaudi_ack_protection_bits_errors(struct hl_device *hdev);
 void gaudi_add_device_attr(struct hl_device *hdev,
 			struct attribute_group *dev_attr_grp);
 void gaudi_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_security.c b/drivers/misc/habanalabs/gaudi/gaudi_security.c
index e10181692d0b..7085f45814ae 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_security.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_security.c
@@ -13052,3 +13052,8 @@ void gaudi_init_security(struct hl_device *hdev)
 
 	gaudi_init_protection_bits(hdev);
 }
+
+void gaudi_ack_protection_bits_errors(struct hl_device *hdev)
+{
+
+}
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 86da0401b6ea..b3d530e83e6b 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5456,7 +5456,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_device_time = goya_get_device_time,
 	.collective_wait_init_cs = goya_collective_wait_init_cs,
 	.collective_wait_create_jobs = goya_collective_wait_create_jobs,
-	.scramble_vaddr = hl_mmu_scramble_vaddr
+	.scramble_vaddr = hl_mmu_scramble_vaddr,
+	.ack_protection_bits_errors = goya_ack_protection_bits_errors
 };
 
 /*
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 8b3408211af6..23fe099ed218 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -173,6 +173,7 @@ void goya_init_mme_qmans(struct hl_device *hdev);
 void goya_init_tpc_qmans(struct hl_device *hdev);
 int goya_init_cpu_queues(struct hl_device *hdev);
 void goya_init_security(struct hl_device *hdev);
+void goya_ack_protection_bits_errors(struct hl_device *hdev);
 int goya_late_init(struct hl_device *hdev);
 void goya_late_fini(struct hl_device *hdev);
 
diff --git a/drivers/misc/habanalabs/goya/goya_security.c b/drivers/misc/habanalabs/goya/goya_security.c
index 14701836f92b..14c3bae3ccdc 100644
--- a/drivers/misc/habanalabs/goya/goya_security.c
+++ b/drivers/misc/habanalabs/goya/goya_security.c
@@ -3120,3 +3120,8 @@ void goya_init_security(struct hl_device *hdev)
 
 	goya_init_protection_bits(hdev);
 }
+
+void goya_ack_protection_bits_errors(struct hl_device *hdev)
+{
+
+}
-- 
2.25.1

