Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F352A65E9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgKDOJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:09:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730019AbgKDOJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:09:26 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD56621734;
        Wed,  4 Nov 2020 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604498965;
        bh=7Q93x05g8QOOufgWmR0/nAxTYkD6UJ/V5DYN5c3zWWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F+vNkCCNcpu0VZCoyOCgjjVwi4DyMky8zVElFgZ4s1VAjLd1TFg3LDSblYCCr0VUS
         lR0l8ZbAEyekaQYaU4JEts2OEFymZekVHjvnzzvcZPCYpcLUhsAeO94YG/v/LbrsJl
         wV1qTu3YWalGsDzzDMInUYIobnFRv+F5yOxoRi0Y=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: release signal if collective wait was dropped
Date:   Wed,  4 Nov 2020 16:09:02 +0200
Message-Id: <20201104140908.10178-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104140908.10178-1-ogabbay@kernel.org>
References: <20201104140908.10178-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As in standard wait cs, we must release a signal fence once
a collective wait cs was dropped and not submitted.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 18cd20eec4c5..6de4b161856c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -300,9 +300,11 @@ static void cs_do_release(struct kref *ref)
 
 	if (!cs->submitted) {
 		/* In case the wait for signal CS was submitted, the put occurs
-		 * in init_signal_wait_cs() right before hanging on the PQ.
+		 * in init_signal_wait_cs() or collective_wait_init_cs()
+		 * right before hanging on the PQ.
 		 */
-		if (cs->type == CS_TYPE_WAIT)
+		if (cs->type == CS_TYPE_WAIT ||
+				cs->type == CS_TYPE_COLLECTIVE_WAIT)
 			hl_fence_put(cs->signal_fence);
 
 		goto out;
-- 
2.17.1

