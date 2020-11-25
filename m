Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2582C4680
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbgKYRLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:11:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730275AbgKYRLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:11:13 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B019A206CA;
        Wed, 25 Nov 2020 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606324272;
        bh=/IDvutFDFNECVAUYmwULT36uIowuFg578D+Tw12Y66A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtltJtwTMzwnPFhIT0Tk4hCFqEL3WWyjKfYknmNGkp+JPo0OSDYsBkINDjs58/MgK
         Ed6Mm86NxihG5UktAGF7cEQbdoYzObbLGN9WxD0olXwJyvp1NavU6PP7flglZ7g2BE
         os9Z3sRkL150yXqFXfbmRqu/hIGthqZpOsdJukdA=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Alon Mizrahi <amizrahi@habana.ai>
Subject: [PATCH] habanalabs: add ull to PLL masks
Date:   Wed, 25 Nov 2020 19:09:56 +0200
Message-Id: <20201125170957.30494-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201125170957.30494-1-ogabbay@kernel.org>
References: <20201125170957.30494-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Mizrahi <amizrahi@habana.ai>

These defines are 64-bit defines so they need ull suffix.

Signed-off-by: Alon Mizrahi <amizrahi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/include/common/cpucp_if.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 554f82271d5f..00bd9b392f93 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -317,13 +317,13 @@ enum cpucp_packet_id {
 #define CPUCP_PKT_CTL_OPCODE_MASK	0x1FFF0000
 
 #define CPUCP_PKT_RES_PLL_OUT0_SHIFT	0
-#define CPUCP_PKT_RES_PLL_OUT0_MASK	0x000000000000FFFF
+#define CPUCP_PKT_RES_PLL_OUT0_MASK	0x000000000000FFFFull
 #define CPUCP_PKT_RES_PLL_OUT1_SHIFT	16
-#define CPUCP_PKT_RES_PLL_OUT1_MASK	0x00000000FFFF0000
+#define CPUCP_PKT_RES_PLL_OUT1_MASK	0x00000000FFFF0000ull
 #define CPUCP_PKT_RES_PLL_OUT2_SHIFT	32
-#define CPUCP_PKT_RES_PLL_OUT2_MASK	0x0000FFFF00000000
+#define CPUCP_PKT_RES_PLL_OUT2_MASK	0x0000FFFF00000000ull
 #define CPUCP_PKT_RES_PLL_OUT3_SHIFT	48
-#define CPUCP_PKT_RES_PLL_OUT3_MASK	0xFFFF000000000000
+#define CPUCP_PKT_RES_PLL_OUT3_MASK	0xFFFF000000000000ull
 
 struct cpucp_packet {
 	union {
-- 
2.17.1

