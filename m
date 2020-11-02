Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D382A2A3487
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgKBTsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:48:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:38088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKBTrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:47:24 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F3520715;
        Mon,  2 Nov 2020 19:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604346444;
        bh=13h28gcC+P21+F5TC9DEAazChgUYOYYFwdE2Gpls25k=;
        h=From:To:Cc:Subject:Date:From;
        b=hrusRPwGrMSdYR7quAZFrH53bgcsYi7rTTayuT2WkObeN5K9VesSvUfWUENilprkg
         L3qYH3+OAVr8lzO/Zfa0xRhPGccyPd/KA57EfkkWIiKs59QPWFf31qelVl1lIUb1fW
         wN5SLOjSwtkClOn0u9NpNQxBG+SbhAhsnFDuKlqo=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: we need CPU queues for hwmon
Date:   Mon,  2 Nov 2020 21:47:19 +0200
Message-Id: <20201102194719.28436-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F/W can be loaded but device CPU queues disabled. In that case, HWMON
should be disabled. This is only relevant when debugging

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/hwmon.c b/drivers/misc/habanalabs/common/hwmon.c
index 2ac29cb2fe61..892a5e2b0b9d 100644
--- a/drivers/misc/habanalabs/common/hwmon.c
+++ b/drivers/misc/habanalabs/common/hwmon.c
@@ -542,7 +542,7 @@ int hl_hwmon_init(struct hl_device *hdev)
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	int rc;
 
-	if ((hdev->hwmon_initialized) || !(hdev->fw_loading))
+	if ((hdev->hwmon_initialized) || !(hdev->cpu_queues_enable))
 		return 0;
 
 	if (hdev->hl_chip_info->info) {
-- 
2.17.1

