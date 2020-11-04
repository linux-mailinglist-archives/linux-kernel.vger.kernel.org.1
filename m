Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D8D2A65E6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgKDOJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:09:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbgKDOJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:09:20 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2331B221E2;
        Wed,  4 Nov 2020 14:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604498959;
        bh=7Q1t1P53SeJW7x7JKHpZQQEehOBnN+lwHKEw4M+V2qE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJK5E60a6r6ecMciwu34fbD1IUvp5SaXGL/AleDnzpiiIbGYXOv5E65/A0fyawn8p
         h6HGtdrpxTnKh/Bqq+YU9N0gUiJVk3tcc2jVKMnZIuX+PGAIRWE+dRUiRAw82j3Q0f
         S9fuRUVd9DZgLRSeTtn1oSfL91S4/utePWogQC4A=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH] habanalabs: fix hard reset print and comment
Date:   Wed,  4 Nov 2020 16:08:58 +0200
Message-Id: <20201104140908.10178-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104140908.10178-1-ogabbay@kernel.org>
References: <20201104140908.10178-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

One of the first steps of a hard reset flow is to close all open user
contexts. This user process teradown might take some time due to long
cleanup in our driver or some other reason even before our cleanup flow.
Hence fix the relevant print and comment to be more accurate.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 421e37123b03..3b82020648c7 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -793,17 +793,20 @@ static int device_kill_open_processes(struct hl_device *hdev)
 
 	mutex_unlock(&hdev->fpriv_list_lock);
 
-	/* We killed the open users, but because the driver cleans up after the
-	 * user contexts are closed (e.g. mmu mappings), we need to wait again
-	 * to make sure the cleaning phase is finished before continuing with
-	 * the reset
+	/*
+	 * We killed the open users, but that doesn't mean they are closed.
+	 * It could be that they are running a long cleanup phase in the driver
+	 * e.g. MMU unmappings, or running other long teardown flow even before
+	 * our cleanup.
+	 * Therefore we need to wait again to make sure they are closed before
+	 * continuing with the reset.
 	 */
 
 	pending_cnt = pending_total;
 
 	while ((!list_empty(&hdev->fpriv_list)) && (pending_cnt)) {
 		dev_info(hdev->dev,
-			"Waiting for all unmap operations to finish before hard reset\n");
+			"Waiting for all user contexts to get closed before hard reset\n");
 
 		pending_cnt--;
 
-- 
2.17.1

