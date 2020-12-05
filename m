Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F44C2CFEAF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 21:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgLEUIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 15:08:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgLEUIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 15:08:40 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH] habanalabs: Revise comment to align with mirror list name
Date:   Sat,  5 Dec 2020 22:07:52 +0200
Message-Id: <20201205200752.1468-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201205200752.1468-1-ogabbay@kernel.org>
References: <20201205200752.1468-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

hw_queues_mirror was renamed to cs_mirror, so revise accordingly a
comment that refers to this list.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index beb482310a58..92c1c516b65f 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -562,7 +562,7 @@ void hl_cs_rollback_all(struct hl_device *hdev)
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		flush_workqueue(hdev->cq_wq[i]);
 
-	/* Make sure we don't have leftovers in the H/W queues mirror list */
+	/* Make sure we don't have leftovers in the CS mirror list */
 	list_for_each_entry_safe(cs, tmp, &hdev->cs_mirror_list, mirror_node) {
 		cs_get(cs);
 		cs->aborted = true;
-- 
2.17.1

