Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E18C2E74DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgL2ViU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:38:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbgL2ViT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:38:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E5442222A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 21:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609277824;
        bh=EdHApXtIRzM49SxVMYXbKT5JLCSjeXwucG3iekfAjOk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ceS1Bo/X4sJEJgv8zNFUYAYdqVkgrg6yPfnYxitsIVKdnvrBqo0uMDMhzlQmT502C
         5vE4ZkS0FkQLLlKT0WjgLBojFi9nOt/gtW87LneJ1t0ncl3Y6iKGyIbBOpZjk01mBg
         +0H2LTJgpf4D5tFfBVDpiqbTsltwh3Zr6IdhSB0/9akfxaxUdgSLVmttF0a+jkdjgR
         z6YqQ5m0QMsJij2bBCOj2WYkOBYilsjZ8/9wylLszskz29zjaQ0MCguUI4PLgUC8zA
         O0ty5aD+YA2rXdk9Q9pdv4nax/YZQe7qwmHraiT3TMfVubECUA7ePRcGL1xWC821Xu
         pjph5HfD02Veg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] habanalabs: update to latest hl_boot_if.h
Date:   Tue, 29 Dec 2020 23:36:51 +0200
Message-Id: <20201229213653.29749-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201229213653.29749-1-ogabbay@kernel.org>
References: <20201229213653.29749-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the latest version of this file that the F/W exports

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/include/common/hl_boot_if.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 1115456cca85..93552d6b59b3 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -150,6 +150,10 @@
  * CPU_BOOT_DEV_STS0_PLL_INFO_EN	FW retrieval of PLL info is enabled.
  *					Initialized in: linux
  *
+ * CPU_BOOT_DEV_STS0_SP_SRAM_EN		SP SRAM is initialized and available
+ *					for use.
+ *					Initialized in: preboot
+ *
  * CPU_BOOT_DEV_STS0_CLK_GATE_EN	Clock Gating enabled.
  *					FW initialized Clock Gating.
  *					Initialized in: preboot
@@ -162,10 +166,6 @@
  *					statuses.
  *					Initialized in: preboot
  *
- * CPU_BOOT_DEV_STS0_SP_SRAM_EN		SP SRAM is initialized and available
- *					for use.
- *					Initialized in: preboot
- *
  */
 #define CPU_BOOT_DEV_STS0_SECURITY_EN			(1 << 0)
 #define CPU_BOOT_DEV_STS0_DEBUG_EN			(1 << 1)
-- 
2.25.1

