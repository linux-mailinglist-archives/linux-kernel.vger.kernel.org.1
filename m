Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E022A6603
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgKDOKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:10:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730045AbgKDOJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:09:27 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77B26221E2;
        Wed,  4 Nov 2020 14:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604498967;
        bh=tY3v5u7FuQ79KrpB1ryL4RB7orYHmEG7YzO8vQhBhPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RHjIGlnPznrBtAdyO0DWChmY5ezeVuzc1ZuIMVzgOlls46RcQO0SPRxupXCtIYLoe
         uz8rNZEfoUesAAEb5Hp4veP6kvo4K1VRZ+FI41rqlT8M9vEc0jmHWMYTE882rGXI6r
         U7vA3jEWNyaD6u/zZiIYvb/z3qY8cvHbk5GV7miw=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: remove duplicate print
Date:   Wed,  4 Nov 2020 16:09:03 +0200
Message-Id: <20201104140908.10178-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104140908.10178-1-ogabbay@kernel.org>
References: <20201104140908.10178-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We print twice the firmware status regarding security, once in
common code and once in asic code. Remove the print in asic code
and leave the common code print.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 3 ---
 drivers/misc/habanalabs/goya/goya.c   | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8abe46b8d615..ae4f3669261d 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -647,9 +647,6 @@ static int gaudi_early_init(struct hl_device *hdev)
 	if (rc)
 		goto free_queue_props;
 
-	dev_info(hdev->dev, "firmware-level security is %s\n",
-		hdev->asic_prop.fw_security_disabled ? "disabled" : "enabled");
-
 	return 0;
 
 free_queue_props:
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 6dea52a50be4..99f536f8a649 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -615,9 +615,6 @@ static int goya_early_init(struct hl_device *hdev)
 				"PCI strap is not configured correctly, PCI bus errors may occur\n");
 	}
 
-	dev_info(hdev->dev, "firmware-level security is %s\n",
-		hdev->asic_prop.fw_security_disabled ? "disabled" : "enabled");
-
 	return 0;
 
 free_queue_props:
-- 
2.17.1

