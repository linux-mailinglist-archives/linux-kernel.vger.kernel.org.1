Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BB42E7410
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgL2VEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:04:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgL2VEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:04:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DA0C221F8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 21:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609275821;
        bh=vOzMFJuWXgEfksjooO73m6TtYPkiviCsgpFWxG5I1IE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=afrYDgWiZD5RsP4y24Gf4xBP8IQNuuR2h0hvJ2ZlpH03FNvkb5NDuiqPgkfGTqeVR
         zVnu4ObpKf7EfSPpvwmZpPo/VqJ+FnEyjEKz//KdmqUFFvAytfbIgnrsPDUEwKj0XM
         FNERRGB3eR5GJGSXZ22vcg7xHin2BClqfPtZZof6WIqh9VokUFch4SH/KHEzg9/glJ
         XmejDHiobov6RBtXzF8difw8eDzrxDK53e8EEtGdxhElRPPaeGt/hItsddZm/AsACN
         HKNpHSguY5E15RFT9lX9GvJZ21csQpB8QsWLY0blJyhiF1vR0q5brbL1dZY5m2BIGJ
         q84DtdP059zCA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs/gaudi: retry loading TPC f/w on -EINTR
Date:   Tue, 29 Dec 2020 23:03:36 +0200
Message-Id: <20201229210337.2082-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201229210337.2082-1-ogabbay@kernel.org>
References: <20201229210337.2082-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If loading the firmware file for the TPC f/w was interrupted, try
to do it again, up to 5 times.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 88d0e4356d59..8c09e4466af8 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -838,11 +838,17 @@ static int gaudi_init_tpc_mem(struct hl_device *hdev)
 	size_t fw_size;
 	void *cpu_addr;
 	dma_addr_t dma_handle;
-	int rc;
+	int rc, count = 5;
 
+again:
 	rc = request_firmware(&fw, GAUDI_TPC_FW_FILE, hdev->dev);
+	if (rc == -EINTR && count-- > 0) {
+		msleep(50);
+		goto again;
+	}
+
 	if (rc) {
-		dev_err(hdev->dev, "Firmware file %s is not found!\n",
+		dev_err(hdev->dev, "Failed to load firmware file %s\n",
 				GAUDI_TPC_FW_FILE);
 		goto out;
 	}
-- 
2.25.1

