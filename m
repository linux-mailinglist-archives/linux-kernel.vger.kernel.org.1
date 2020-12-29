Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4717E2E74DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgL2Vht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:37:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgL2Vhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:37:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 981A522227
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 21:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609277823;
        bh=HJkZ/9Yf+bL1U158AIiTAJ8ZXUru0j6sz+qUmVjj4Fw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Sd0drVDiQlhW43maznOEf2/8dfy7O1HWEQ4lCzJSWgpwnrxPOysWqjuqlhE0bUEqa
         7v6w3eHpMRClPfCoE+XkfxYoZlj4ygnzGM6jjSR6vDVVgrsUUoe3kz5OGCjb990SvN
         5FAywItCzYH14vZoEnTKhoHKwFb5B2vNsGYWNRm74XT1FgkXFffqjg+MEdi6rixJ37
         cBHCeeEEaxEBVH77n5ZIt56PEaVPTvIKPx1yVcni+B7KIYRUL5nQKEyA0THf6HcuWY
         vR4rx37ooofsz6HdGDMcjF98vgrvQYLhmPO0Fvk8/mwGqseyk6+OluQ3Erk8G+lvtY
         5ib+gKwccxUwg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] habanalabs: add ASIC property of functional HBMs
Date:   Tue, 29 Dec 2020 23:36:50 +0200
Message-Id: <20201229213653.29749-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201229213653.29749-1-ogabbay@kernel.org>
References: <20201229213653.29749-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of functional HBMs in the same ASIC can be different due
to malfunctioning HBM banks.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index bd91ec6677a5..0cd18c0fec95 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -416,6 +416,7 @@ struct hl_mmu_properties {
  *                            from BOOT_DEV_STS0
  * @dram_supports_virtual_memory: is there an MMU towards the DRAM
  * @hard_reset_done_by_fw: true if firmware is handling hard reset flow
+ * @num_functional_hbms: number of functional HBMs in each DCORE.
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -474,6 +475,7 @@ struct asic_fixed_properties {
 	u8				fw_security_status_valid;
 	u8				dram_supports_virtual_memory;
 	u8				hard_reset_done_by_fw;
+	u8				num_functional_hbms;
 };
 
 /**
-- 
2.25.1

