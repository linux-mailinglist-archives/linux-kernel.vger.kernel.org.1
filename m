Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EC62F39B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406508AbhALTKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406294AbhALTKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:10:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C19082310A;
        Tue, 12 Jan 2021 19:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478561;
        bh=b4rL8CQG3gb6wQd7aEhpwj+/YBrFWy875fB8SuQmEsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpzADwXFtMoTSRf1M4lAnsEFlLcP4EvgzCME8nNpxrq6+krvHm3M+/CG9M2cCt7td
         TQlh02qeH5WSyD2lSZP5boxX4521/tYSwD6L1jTA92YSMXIv1ib1wn+Zmd16trzVSw
         n9i8KVEap1lFM95+Z87TSt06z2SHVs4zOVRdWp9a2vpaa9lCIBYi6Hh22VchJBou6K
         0+eUvTXOTSjn9vrZ7T8tE0lZaq+vO55VyANgoCjMGJxCMw332evUbOVW9IzJ8TD+Zl
         7FhzThKh1C/bvP0MnMGcVojh1UtLG4Fu9JS3ddO2Sg/5bO8NVi2GLHw/+JpcYcQFKi
         WFCn6tHU8bnhA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/4] habanalabs: ignore F/W BMC errors in case no BMC present
Date:   Tue, 12 Jan 2021 21:09:14 +0200
Message-Id: <20210112190915.21164-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210112190915.21164-1-ogabbay@kernel.org>
References: <20210112190915.21164-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to support operation mode in which BMC is not active,
driver must not take BMC errors into consideration.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index a6ea5bbeb699..dcd6c3614044 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -308,9 +308,15 @@ static int fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
 	if (err_val & CPU_BOOT_ERR0_DRAM_SKIPPED)
 		dev_warn(hdev->dev,
 			"Device boot warning - Skipped DRAM initialization\n");
-	if (err_val & CPU_BOOT_ERR0_BMC_WAIT_SKIPPED)
-		dev_warn(hdev->dev,
-			"Device boot error - Skipped waiting for BMC\n");
+
+	if (err_val & CPU_BOOT_ERR0_BMC_WAIT_SKIPPED) {
+		if (hdev->bmc_enable)
+			dev_warn(hdev->dev,
+				"Device boot error - Skipped waiting for BMC\n");
+		else
+			err_val &= ~CPU_BOOT_ERR0_BMC_WAIT_SKIPPED;
+	}
+
 	if (err_val & CPU_BOOT_ERR0_NIC_DATA_NOT_RDY)
 		dev_err(hdev->dev,
 			"Device boot error - Serdes data from BMC not available\n");
-- 
2.25.1

