Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08932A5FB5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgKDIgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:36:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbgKDIgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:36:45 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F15D2080C;
        Wed,  4 Nov 2020 08:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604479005;
        bh=eAFGfAK2Vf/P0E/MJkXacrK12HOrl57I6kEdOdRQt2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRDW9gJvrnFN8LQ4YLCpzMm8Im/lHW31st/64tEUfOWROJMTZVHFYvYoCqiJgbz8z
         J1oSDJftyX4XIRyv51GahM+//0bDOqffYNh9h4pv2N9bGq5C4ZBk0/bOYHa7RFxHg9
         Z0t+HKKhCph+8S2r3AO48ynts9esU6U3M02qjcbo=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: make sure cs type is valid in cs_ioctl_signal_wait
Date:   Wed,  4 Nov 2020 10:36:29 +0200
Message-Id: <20201104083630.28402-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104083630.28402-1-ogabbay@kernel.org>
References: <20201104083630.28402-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although we get a valid cs type from the callee, in case new values
will be added in the future, it is best to check the expected values
in that function.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index f5bf8684f8aa..46c36b385c95 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1070,9 +1070,11 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	if (cs_type == CS_TYPE_WAIT || cs_type == CS_TYPE_SIGNAL)
 		rc = cs_ioctl_signal_wait_create_jobs(hdev, ctx, cs, q_type,
 				q_idx);
-	else
+	else if (cs_type == CS_TYPE_COLLECTIVE_WAIT)
 		rc = hdev->asic_funcs->collective_wait_create_jobs(hdev, ctx,
 				cs, q_idx, collective_engine_id);
+	else
+		rc = -EINVAL;
 
 	if (rc)
 		goto free_cs_object;
-- 
2.17.1

