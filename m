Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314FC2E8E17
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 21:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbhACU35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 15:29:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbhACU34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:29:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FFFF207C9;
        Sun,  3 Jan 2021 20:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609705755;
        bh=pFunUICnNr36Fr7XgxKIBT9QGuGjARlSp169vt7rVog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s4FqAGOzIk7wqIXUe0ko3F+54MkrSP32T4Ah9hzY5CcCufjW5qVAb1Ovz7+gygmcb
         xuFXFyy4sNslUhE6qREzrtQ/+6ZIbgFDj0Sh/5uSU/ESo061aBCQCxkQ2ATzfsQbU6
         075mMlhKowxBoVG/npQGk66IJAVvJhVmT/Xn0rina1PW0j1g2RzsdvjSEKYALENznh
         HMM7TVOzu0LFgUzb+zCcrPIk31Jr/9E39E1Q1fuR0I4tudFHmHd7g7W8Vb5R8qG48X
         sbZzi/1va1Ke3b1MlRitU5vQMjPuWL48igRBecqzuZLWHaGJTZLES2aiU3yptpD+i2
         ySVUSl8pq257A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/4] habanalabs: increment ctx ref from within a cs allocation
Date:   Sun,  3 Jan 2021 22:29:07 +0200
Message-Id: <20210103202909.243-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210103202909.243-1-ogabbay@kernel.org>
References: <20210103202909.243-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

A CS must increment the relevant context reference count.
We want to increment the reference inside the CS allocation function
as opposed for today where we increment it outside.
This is logical since we want to avoid explicitly incrementing
the context every time we call the CS allocate function.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_submission.c   | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index f7fac82ac41d..3affb350070c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -479,6 +479,9 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 		return -ENOMEM;
 	}
 
+	/* increment refcnt for context */
+	hl_ctx_get(hdev, ctx);
+
 	cs->ctx = ctx;
 	cs->submitted = false;
 	cs->completed = false;
@@ -550,6 +553,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	kfree(cs_cmpl);
 free_cs:
 	kfree(cs);
+	hl_ctx_put(ctx);
 	return rc;
 }
 
@@ -827,14 +831,9 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 	if (rc)
 		goto out;
 
-	/* increment refcnt for context */
-	hl_ctx_get(hdev, hpriv->ctx);
-
 	rc = allocate_cs(hdev, hpriv->ctx, CS_TYPE_DEFAULT, &cs);
-	if (rc) {
-		hl_ctx_put(hpriv->ctx);
+	if (rc)
 		goto free_cs_chunk_array;
-	}
 
 	cs->timestamp = !!(flags & HL_CS_FLAGS_TIMESTAMP);
 	*cs_seq = cs->sequence;
@@ -1276,15 +1275,11 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 		}
 	}
 
-	/* increment refcnt for context */
-	hl_ctx_get(hdev, ctx);
-
 	rc = allocate_cs(hdev, ctx, cs_type, &cs);
 	if (rc) {
 		if (cs_type == CS_TYPE_WAIT ||
 			cs_type == CS_TYPE_COLLECTIVE_WAIT)
 			hl_fence_put(sig_fence);
-		hl_ctx_put(ctx);
 		goto free_cs_chunk_array;
 	}
 
-- 
2.25.1

