Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D3A2D2EE4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgLHP6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:58:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729948AbgLHP6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:58:36 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH] habanalabs: report dram_page_size in hw_ip_info ioctl
Date:   Tue,  8 Dec 2020 17:57:49 +0200
Message-Id: <20201208155749.5759-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208155749.5759-1-ogabbay@kernel.org>
References: <20201208155749.5759-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

Instead of having it hard-coded as a define, pass it to the user
in runtime.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 1 +
 include/uapi/misc/habanalabs.h                    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index a0c0d20f6f8f..3343012f4762 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -63,6 +63,7 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 	hw_ip.dram_size = prop->dram_size - dram_kmd_size;
 	if (hw_ip.dram_size > PAGE_SIZE)
 		hw_ip.dram_enabled = 1;
+	hw_ip.dram_page_size = prop->dram_page_size;
 	hw_ip.num_of_events = prop->num_of_events;
 
 	memcpy(hw_ip.cpucp_version, prop->cpucp_info.cpucp_version,
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 8a5e60a6dae0..b6e7ceef59af 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -320,6 +320,8 @@ struct hl_info_hw_ip_info {
 	__u8 pad[2];
 	__u8 cpucp_version[HL_INFO_VERSION_MAX_LEN];
 	__u8 card_name[HL_INFO_CARD_NAME_MAX_LEN];
+	__u64 reserved2;
+	__u64 dram_page_size;
 };
 
 struct hl_info_dram_usage {
-- 
2.17.1

