Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBF52FA998
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436971AbhARTFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407950AbhARTEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:04:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6E6620715;
        Mon, 18 Jan 2021 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610996629;
        bh=gq2u1VI5YZ0uyJVTqCzlaAt+yZuDGXVB7fClRjBtM68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzDOXcVXbaEoWgsBRQJF8eKKFLbZgcZVGXwoARBlRF0wMo5rDIr6y9x6n4SvAM/H/
         RrBtc07wtytXrPLinIy/h/5ikl2ZKtSRpj70nLPepunx6nxtvc96XPPTaJTi3mvStz
         x/EGRGgagWE6/aFyMwCiiwAK4O4Ucur8UA3oNhHFp5bSwVMKMHtlRoryVPzbJf0bbs
         WeEyFqh4E066iq8UO5eyEhf95ii7grLWlYPxm4t+r/pfm3k4i1c/XK7MgfxODrnnXt
         +pOhwwMnm4PgebT7xEHvju5Xyc25YQFVfhb34orKOERScoT2LmB0qtxc/lx6qJtt/1
         I9ky+jiUiH7QQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/3] habanalabs: add user available interrupt to hw_ip
Date:   Mon, 18 Jan 2021 21:03:42 +0200
Message-Id: <20210118190343.11978-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118190343.11978-1-ogabbay@kernel.org>
References: <20210118190343.11978-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to support completions that arrive directly to the user,
the driver needs to supply the user with the first available msix
interrupt available.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h       | 3 +++
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 2 ++
 drivers/misc/habanalabs/gaudi/gaudi.c             | 2 ++
 drivers/misc/habanalabs/goya/goya.c               | 2 ++
 include/uapi/misc/habanalabs.h                    | 6 ++++--
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 3923b03e99aa..ce1a1e70a6d5 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -408,6 +408,8 @@ struct hl_mmu_properties {
  * @sync_stream_first_mon: first monitor available for sync stream use
  * @first_available_user_sob: first sob available for the user
  * @first_available_user_mon: first monitor available for the user
+ * @first_available_user_msix_interrupt: first available msix interrupt
+ *                                       reserved for the user
  * @tpc_enabled_mask: which TPCs are enabled.
  * @completion_queues_count: number of completion queues.
  * @fw_security_disabled: true if security measures are disabled in firmware,
@@ -469,6 +471,7 @@ struct asic_fixed_properties {
 	u16				sync_stream_first_mon;
 	u16				first_available_user_sob[HL_MAX_DCORES];
 	u16				first_available_user_mon[HL_MAX_DCORES];
+	u16				first_available_user_msix_interrupt;
 	u8				tpc_enabled_mask;
 	u8				completion_queues_count;
 	u8				fw_security_disabled;
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index e216865b8102..d94825be029c 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -90,6 +90,8 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 	hw_ip.psoc_pci_pll_od = prop->psoc_pci_pll_od;
 	hw_ip.psoc_pci_pll_div_factor = prop->psoc_pci_pll_div_factor;
 
+	hw_ip.first_available_interrupt_id =
+			prop->first_available_user_msix_interrupt;
 	return copy_to_user(out, &hw_ip,
 		min((size_t)size, sizeof(hw_ip))) ? -EFAULT : 0;
 }
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 2b01c081404a..69b3867bc151 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -527,6 +527,8 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 			prop->sync_stream_first_mon +
 			(num_sync_stream_queues * HL_RSVD_MONS);
 
+	prop->first_available_user_msix_interrupt = USHRT_MAX;
+
 	/* disable fw security for now, set it in a later stage */
 	prop->fw_security_disabled = true;
 	prop->fw_security_status_valid = false;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 50dcefc02cdd..82f69274def7 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -455,6 +455,8 @@ int goya_get_fixed_properties(struct hl_device *hdev)
 
 	prop->max_pending_cs = GOYA_MAX_PENDING_CS;
 
+	prop->first_available_user_msix_interrupt = USHRT_MAX;
+
 	/* disable fw security for now, set it in a later stage */
 	prop->fw_security_disabled = true;
 	prop->fw_security_status_valid = false;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index b431a70e1b8b..866355a53188 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -309,7 +309,9 @@ struct hl_info_hw_ip_info {
 	__u32 num_of_events;
 	__u32 device_id; /* PCI Device ID */
 	__u32 module_id; /* For mezzanine cards in servers (From OCP spec.) */
-	__u32 reserved[2];
+	__u32 reserved;
+	__u16 first_available_interrupt_id;
+	__u16 reserved2;
 	__u32 cpld_version;
 	__u32 psoc_pci_pll_nr;
 	__u32 psoc_pci_pll_nf;
@@ -320,7 +322,7 @@ struct hl_info_hw_ip_info {
 	__u8 pad[2];
 	__u8 cpucp_version[HL_INFO_VERSION_MAX_LEN];
 	__u8 card_name[HL_INFO_CARD_NAME_MAX_LEN];
-	__u64 reserved2;
+	__u64 reserved3;
 	__u64 dram_page_size;
 };
 
-- 
2.25.1

