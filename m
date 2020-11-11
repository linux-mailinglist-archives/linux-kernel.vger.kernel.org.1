Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7B82AF95D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgKKT7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:59:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKKT73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:59:29 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E553208B3;
        Wed, 11 Nov 2020 19:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605124769;
        bh=PN7RlUHFj/3wvLVxIyXWTYMLn7CNcwSA+8vUsb844pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0dtMfiUh4PBLfuFsCGbjzVUZ5z3Lf8bR7p+ZVKcBfzyEEhnQrqZN8M3ZdF7O1BjAW
         sv3h+iRYlIiUCbagSMzdhiahs78WRZSrReQyLbcnhImolAD8UCtOKW0xHezK07i2iH
         n5TIWSkgv2a3bjISp2U8SGPG5NMl+WYW5utOl8UA=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: print message with correct device
Date:   Wed, 11 Nov 2020 21:59:20 +0200
Message-Id: <20201111195920.18338-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111195920.18338-1-ogabbay@kernel.org>
References: <20201111195920.18338-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During hard-reset, the driver rejects further IOCTL calls and prints
an error message. That error message should be printed with the correct
device instead of using only the control device.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 0729cd43f297..ba8217fc9425 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -573,7 +573,7 @@ static long _hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg,
 	int retcode;
 
 	if (hdev->hard_reset_pending) {
-		dev_crit_ratelimited(hdev->dev_ctrl,
+		dev_crit_ratelimited(dev,
 			"Device HARD reset pending! Please close FD\n");
 		return -ENODEV;
 	}
-- 
2.17.1

