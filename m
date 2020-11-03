Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B192A48DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgKCPCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:02:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgKCPAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:00:55 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 943B321534;
        Tue,  3 Nov 2020 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604415654;
        bh=TEL/YbabPRQncJRuvMmw90xCOwuk+tAGEVoROWRsXaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPDR7lRXvEZlqYaxZtVkzibXy7EneyQsTAIPJwOwNuN7NtOiww0NY4ODV/QSTwje7
         JzycUdI2W9s4yskR7bb0nW1I/poFvHb9tDZySoHvp2kwxDoclgBgtdanuSXy3XPRRA
         zBnuYQG5X9jiwcfilq7Ob+jDMX4zt3isMeqGSy+A=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Tal Cohen <talcohen@habana.ai>
Subject: [PATCH] habanalabs: use enum for CB allocation options
Date:   Tue,  3 Nov 2020 17:00:44 +0200
Message-Id: <20201103150046.19074-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103150046.19074-1-ogabbay@kernel.org>
References: <20201103150046.19074-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tal Cohen <talcohen@habana.ai>

In the future there will be situations where queues can accept either
kernel allocated CBs or user allocated CBs, depending on different
states.

Therefore, instead of using a boolean variable of kernel/user allocated
CB, we need to use a bitmask to indicate that, which will allow to
combine the two options.

Add a flag to the uapi so the user will be able to indicate whether
the CB was allocated by kernel or by user. Of course the driver
validates that.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 31 +++++++++++++++++--
 drivers/misc/habanalabs/common/habanalabs.h   | 19 ++++++++++--
 drivers/misc/habanalabs/gaudi/gaudi.c         | 13 +++++---
 drivers/misc/habanalabs/goya/goya.c           |  6 ++--
 include/uapi/misc/habanalabs.h                | 16 ++++++++++
 5 files changed, 73 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 1f8b53d42e3a..ea480b14703f 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -568,9 +568,36 @@ static int validate_queue_index(struct hl_device *hdev,
 		return -EINVAL;
 	}
 
-	*queue_type = hw_queue_prop->type;
-	*is_kernel_allocated_cb = !!hw_queue_prop->requires_kernel_cb;
+	/* When hw queue type isn't QUEUE_TYPE_HW,
+	 * USER_ALLOC_CB flag shall be referred as "don't care".
+	 */
+	if (hw_queue_prop->type == QUEUE_TYPE_HW) {
+		if (chunk->cs_chunk_flags & HL_CS_CHUNK_FLAGS_USER_ALLOC_CB) {
+			if (!(hw_queue_prop->cb_alloc_flags & CB_ALLOC_USER)) {
+				dev_err(hdev->dev,
+					"Queue index %d doesn't support user CB\n",
+					chunk->queue_index);
+				return -EINVAL;
+			}
 
+			*is_kernel_allocated_cb = false;
+		} else {
+			if (!(hw_queue_prop->cb_alloc_flags &
+					CB_ALLOC_KERNEL)) {
+				dev_err(hdev->dev,
+					"Queue index %d doesn't support kernel CB\n",
+					chunk->queue_index);
+				return -EINVAL;
+			}
+
+			*is_kernel_allocated_cb = true;
+		}
+	} else {
+		*is_kernel_allocated_cb = !!(hw_queue_prop->cb_alloc_flags
+						& CB_ALLOC_KERNEL);
+	}
+
+	*queue_type = hw_queue_prop->type;
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 968431c7ce20..5983850d3f8f 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -206,6 +206,17 @@ struct hl_outbound_pci_region {
 	u64	size;
 };
 
+/*
+ * enum queue_cb_alloc_flags - Indicates queue support for CBs that
+ * allocated by Kernel or by User
+ * @CB_ALLOC_KERNEL: support only CBs that allocated by Kernel
+ * @CB_ALLOC_USER: support only CBs that allocated by User
+ */
+enum queue_cb_alloc_flags {
+	CB_ALLOC_KERNEL = 0x1,
+	CB_ALLOC_USER   = 0x2
+};
+
 /*
  * struct hl_hw_sob - H/W SOB info.
  * @hdev: habanalabs device structure.
@@ -223,16 +234,18 @@ struct hl_hw_sob {
 /**
  * struct hw_queue_properties - queue information.
  * @type: queue type.
+ * @queue_cb_alloc_flags: bitmap which indicates if the hw queue supports CB
+ *                        that allocated by the Kernel driver and therefore,
+ *                        a CB handle can be provided for jobs on this queue.
+ *                        Otherwise, a CB address must be provided.
  * @driver_only: true if only the driver is allowed to send a job to this queue,
  *               false otherwise.
- * @requires_kernel_cb: true if a CB handle must be provided for jobs on this
- *                      queue, false otherwise (a CB address must be provided).
  * @supports_sync_stream: True if queue supports sync stream
  */
 struct hw_queue_properties {
 	enum hl_queue_type	type;
+	enum queue_cb_alloc_flags cb_alloc_flags;
 	u8			driver_only;
-	u8			requires_kernel_cb;
 	u8			supports_sync_stream;
 };
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 065c2377c1fa..559e22a5696c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -381,23 +381,28 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 		if (gaudi_queue_type[i] == QUEUE_TYPE_EXT) {
 			prop->hw_queues_props[i].type = QUEUE_TYPE_EXT;
 			prop->hw_queues_props[i].driver_only = 0;
-			prop->hw_queues_props[i].requires_kernel_cb = 1;
 			prop->hw_queues_props[i].supports_sync_stream = 1;
+			prop->hw_queues_props[i].cb_alloc_flags =
+				CB_ALLOC_KERNEL;
 			num_sync_stream_queues++;
 		} else if (gaudi_queue_type[i] == QUEUE_TYPE_CPU) {
 			prop->hw_queues_props[i].type = QUEUE_TYPE_CPU;
 			prop->hw_queues_props[i].driver_only = 1;
-			prop->hw_queues_props[i].requires_kernel_cb = 0;
 			prop->hw_queues_props[i].supports_sync_stream = 0;
+			prop->hw_queues_props[i].cb_alloc_flags =
+				CB_ALLOC_KERNEL;
 		} else if (gaudi_queue_type[i] == QUEUE_TYPE_INT) {
 			prop->hw_queues_props[i].type = QUEUE_TYPE_INT;
 			prop->hw_queues_props[i].driver_only = 0;
-			prop->hw_queues_props[i].requires_kernel_cb = 0;
+			prop->hw_queues_props[i].supports_sync_stream = 0;
+			prop->hw_queues_props[i].cb_alloc_flags =
+				CB_ALLOC_USER;
 		} else if (gaudi_queue_type[i] == QUEUE_TYPE_NA) {
 			prop->hw_queues_props[i].type = QUEUE_TYPE_NA;
 			prop->hw_queues_props[i].driver_only = 0;
-			prop->hw_queues_props[i].requires_kernel_cb = 0;
 			prop->hw_queues_props[i].supports_sync_stream = 0;
+			prop->hw_queues_props[i].cb_alloc_flags =
+				CB_ALLOC_USER;
 		}
 	}
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index e8bf0b79cd67..7012fcdab837 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -373,20 +373,20 @@ int goya_get_fixed_properties(struct hl_device *hdev)
 	for (i = 0 ; i < NUMBER_OF_EXT_HW_QUEUES ; i++) {
 		prop->hw_queues_props[i].type = QUEUE_TYPE_EXT;
 		prop->hw_queues_props[i].driver_only = 0;
-		prop->hw_queues_props[i].requires_kernel_cb = 1;
+		prop->hw_queues_props[i].cb_alloc_flags = CB_ALLOC_KERNEL;
 	}
 
 	for (; i < NUMBER_OF_EXT_HW_QUEUES + NUMBER_OF_CPU_HW_QUEUES ; i++) {
 		prop->hw_queues_props[i].type = QUEUE_TYPE_CPU;
 		prop->hw_queues_props[i].driver_only = 1;
-		prop->hw_queues_props[i].requires_kernel_cb = 0;
+		prop->hw_queues_props[i].cb_alloc_flags = CB_ALLOC_KERNEL;
 	}
 
 	for (; i < NUMBER_OF_EXT_HW_QUEUES + NUMBER_OF_CPU_HW_QUEUES +
 			NUMBER_OF_INT_HW_QUEUES; i++) {
 		prop->hw_queues_props[i].type = QUEUE_TYPE_INT;
 		prop->hw_queues_props[i].driver_only = 0;
-		prop->hw_queues_props[i].requires_kernel_cb = 0;
+		prop->hw_queues_props[i].cb_alloc_flags = CB_ALLOC_USER;
 	}
 
 	prop->completion_queues_count = NUMBER_OF_CMPLT_QUEUES;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 9705b8adb60c..5753157e71b3 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -490,6 +490,22 @@ union hl_cb_args {
 	struct hl_cb_out out;
 };
 
+/* HL_CS_CHUNK_FLAGS_ values
+ *
+ * HL_CS_CHUNK_FLAGS_USER_ALLOC_CB:
+ *      Indicates if the CB was allocated and mapped by userspace.
+ *      User allocated CB is a command buffer allocated by the user, via malloc
+ *      (or similar). After allocating the CB, the user invokes “memory ioctl”
+ *      to map the user memory into a device virtual address. The user provides
+ *      this address via the cb_handle field. The interface provides the
+ *      ability to create a large CBs, Which aren’t limited to
+ *      “HL_MAX_CB_SIZE”. Therefore, it increases the PCI-DMA queues
+ *      throughput. This CB allocation method also reduces the use of Linux
+ *      DMA-able memory pool. Which are limited and used by other Linux
+ *      sub-systems.
+ */
+#define HL_CS_CHUNK_FLAGS_USER_ALLOC_CB 0x1
+
 /*
  * This structure size must always be fixed to 64-bytes for backward
  * compatibility
-- 
2.17.1

