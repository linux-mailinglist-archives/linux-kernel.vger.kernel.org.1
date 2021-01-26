Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A329B304FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbhA0D0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:26:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387472AbhAZVDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:03:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 864FA22B2C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 21:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611694940;
        bh=PDURcj0mvytBOAb5N9Nbm2d45trC2U+E/9LNX+oeWso=;
        h=From:To:Subject:Date:From;
        b=uIrZI6mHDQVN8+8Vi0fpKk0AyLiWKpSWkH8JN3yAcxy+eAU4Zt5zBV40hG3hOI56S
         XSx2+ttiBKY/XM3LMmmuGnB3I8w1TTRb3lco6BkWKF56CA24OBbr4P4XCdLc1aLuoG
         5Q/4Zkg4FauBet5TOLDyJW4rvBtnIIrx0Kbmmh7nl93yKnA2hHEy674mh7gQOlcuz/
         xDrWhiQgZ3E83ZlLNugMbO2C4g+PefYZDo/ce8MguwYLRAmPWdRDeS42WYbk6J+3q8
         tBPNjiH4x4vlwGFI0cK2ZMybdwTF2hm/FgEzzgxIFJXht3bZgyI6rSMumvbWOm7tpl
         BiBTnzL4gsKpw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] habanalabs: update SyncManager interrupt handling
Date:   Tue, 26 Jan 2021 23:02:13 +0200
Message-Id: <20210126210215.4892-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware provides more information about SyncManager events.
Adjust the code to the latest firmware interface file.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c             | 14 +++++++-------
 drivers/misc/habanalabs/include/common/cpucp_if.h | 11 +++++++++--
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 1348016309e3..a9bd5aef6c02 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6860,24 +6860,24 @@ static void gaudi_print_sm_sei_info(struct hl_device *hdev, u16 event_type,
 	u32 index = event_type - GAUDI_EVENT_DMA_IF_SEI_0;
 
 	switch (sei_data->sei_cause) {
-	case GAUDI_SM_SEI_SO_OVERFLOW:
+	case SM_SEI_SO_OVERFLOW:
 		dev_err(hdev->dev,
 			"SM %u SEI Error: SO %u overflow/underflow",
-			index, le16_to_cpu(sei_data->sei_log));
+			index, le32_to_cpu(sei_data->sei_log));
 		break;
-	case GAUDI_SM_SEI_LBW_4B_UNALIGNED:
+	case SM_SEI_LBW_4B_UNALIGNED:
 		dev_err(hdev->dev,
 			"SM %u SEI Error: Unaligned 4B LBW access, monitor agent address low - %#x",
-			index, le16_to_cpu(sei_data->sei_log));
+			index, le32_to_cpu(sei_data->sei_log));
 		break;
-	case GAUDI_SM_SEI_AXI_RESPONSE_ERR:
+	case SM_SEI_AXI_RESPONSE_ERR:
 		dev_err(hdev->dev,
 			"SM %u SEI Error: AXI ID %u response error",
-			index, le16_to_cpu(sei_data->sei_log));
+			index, le32_to_cpu(sei_data->sei_log));
 		break;
 	default:
 		dev_err(hdev->dev, "Unknown SM SEI cause %u",
-				le16_to_cpu(sei_data->sei_log));
+				le32_to_cpu(sei_data->sei_log));
 		break;
 	}
 }
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index d75d1077461b..b77c1c16c32c 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -58,10 +58,17 @@ struct hl_eq_ecc_data {
 	__u8 pad[7];
 };
 
+enum hl_sm_sei_cause {
+	SM_SEI_SO_OVERFLOW,
+	SM_SEI_LBW_4B_UNALIGNED,
+	SM_SEI_AXI_RESPONSE_ERR
+};
+
 struct hl_eq_sm_sei_data {
-	__le16 sei_log;
+	__le32 sei_log;
+	/* enum hl_sm_sei_cause */
 	__u8 sei_cause;
-	__u8 pad[5];
+	__u8 pad[3];
 };
 
 struct hl_eq_entry {
-- 
2.25.1

