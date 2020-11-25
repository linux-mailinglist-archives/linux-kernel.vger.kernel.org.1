Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1872C467E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgKYRKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:10:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730960AbgKYRKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:10:02 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17A8E2063A;
        Wed, 25 Nov 2020 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606324202;
        bh=t4hyEv72MSpH4VzJG715WX9vUsQfaAHFeZRQ0uZD95Y=;
        h=From:To:Cc:Subject:Date:From;
        b=jcq5tIUCaN6sMl97IvBdrsQ4DL8m4CXU6srAjERQVZpksTiaI6vbYshDYyLgxoe3C
         IPMaMefpitXYy1lLSoZ7+8nkLhvdVWURBshPuiYEcvZ/ZU3oIw/EcIdSftRuuaz1/k
         y794G8LHW9GZZZXsyDPQzqYNQ96kBPg6uAOy1lHQ=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: add missing counter update
Date:   Wed, 25 Nov 2020 19:09:54 +0200
Message-Id: <20201125170957.30494-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global CS drop-on-reset counter wasn't updated together with
the context counter.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/hw_queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index d1d30fb36410..7caf868d1585 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -529,6 +529,7 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 	hdev->asic_funcs->hw_queues_lock(hdev);
 
 	if (!hl_device_operational(hdev, &status)) {
+		atomic64_inc(&cntr->device_in_reset_drop_cnt);
 		atomic64_inc(&ctx->cs_counters.device_in_reset_drop_cnt);
 		dev_err(hdev->dev,
 			"device is %s, CS rejected!\n", hdev->status[status]);
-- 
2.17.1

