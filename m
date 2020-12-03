Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDFB2CDCA4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgLCRqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:46:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgLCRqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:46:51 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Alon Mizrahi <amizrahi@habana.ai>
Subject: [PATCH 1/3] habanalabs: add comment for pll frequency ioctl opcode
Date:   Thu,  3 Dec 2020 19:46:03 +0200
Message-Id: <20201203174605.31530-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Mizrahi <amizrahi@habana.ai>

Forgot to add the comment for the opcode when it was added.

Signed-off-by: Alon Mizrahi <amizrahi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 include/uapi/misc/habanalabs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 8c15a7d336a0..dc8bcec195cc 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -279,6 +279,7 @@ enum hl_device_status {
  * HL_INFO_CLK_THROTTLE_REASON - Retrieve clock throttling reason
  * HL_INFO_SYNC_MANAGER  - Retrieve sync manager info per dcore
  * HL_INFO_TOTAL_ENERGY  - Retrieve total energy consumption
+ * HL_INFO_PLL_FREQUENCY - Retrieve PLL frequency
  */
 #define HL_INFO_HW_IP_INFO		0
 #define HL_INFO_HW_EVENTS		1
-- 
2.17.1

