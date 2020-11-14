Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E01C2B2C65
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 10:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgKNJYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 04:24:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgKNJYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 04:24:20 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E45A62224B;
        Sat, 14 Nov 2020 09:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605345860;
        bh=nd3G5SRZ043JQALl/KoyJi9iQb/ln2AV6ogbXOO+8z4=;
        h=From:To:Cc:Subject:Date:From;
        b=A8U2NGY4PqiNbAAoD059wEmZUHwnyFMH/paLy5Zh0AdxnVJRI14tLYKr4ApLxLp0s
         oen8zJ/u2bpPcPlF5Fb0TrTzTwPiEHZTHs+mIie116oH40aRLOHGdzO/LWl8v7nbjT
         zumxMgVWT+TFLA9dYAkby9m5SiU4gVf5dz0AbKcU=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Guy Nisan <gnisan@habana.ai>
Subject: [PATCH] habanalabs: add boot errors prints
Date:   Sat, 14 Nov 2020 11:24:11 +0200
Message-Id: <20201114092414.12244-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guy Nisan <gnisan@habana.ai>

Add log prints for security and eFuse boot error bits

Signed-off-by: Guy Nisan <gnisan@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index b5464cd34071..e37d451e6415 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -510,6 +510,13 @@ static void fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
 	if (err_val & CPU_BOOT_ERR0_NIC_FW_FAIL)
 		dev_err(hdev->dev,
 			"Device boot error - NIC F/W initialization failed\n");
+	if (err_val & CPU_BOOT_ERR0_SECURITY_NOT_RDY)
+		dev_warn(hdev->dev,
+			"Device boot warning - security not ready\n");
+	if (err_val & CPU_BOOT_ERR0_SECURITY_FAIL)
+		dev_err(hdev->dev, "Device boot error - security failure\n");
+	if (err_val & CPU_BOOT_ERR0_EFUSE_FAIL)
+		dev_err(hdev->dev, "Device boot error - eFuse failure\n");
 
 	security_val = RREG32(cpu_security_boot_status_reg);
 	if (security_val & CPU_BOOT_DEV_STS0_ENABLED)
-- 
2.17.1

