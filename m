Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C542C754A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbgK1WXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 17:23:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbgK1WWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 17:22:54 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79E242231B;
        Sat, 28 Nov 2020 22:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606602134;
        bh=e99u5WHs77TPcq1uVgcgLqysK1hrXGyhq4vIclJwst4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0IvsZ6yL0izfPgRbE5T81is32gCfgHllCBj8QelRPRj0t9g8A+buzDwHh0A+TVc6W
         Q3yqZ+3aTOnO2AluRSKxKKIr+l+ibVdGmW48ahl21xLMov6U7K6SPhuyaQV9fIo4rJ
         8qPuNNq8Z2gwyB4e/IiLvevjC6jIjSIJMeaVoSo4=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH] habanalabs: Add mask for CS type bits in CS flags
Date:   Sun, 29 Nov 2020 00:22:04 +0200
Message-Id: <20201128222207.23722-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201128222207.23722-1-ogabbay@kernel.org>
References: <20201128222207.23722-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

hl_cs_sanity_checks() extracts the CS type bits of the CS flags, by
masking out the non-type bits.
To save the need for updating the function whenever new bits for
non-type flags are added, add an explicit mask for the CS type bits.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index bd2f54399020..dc85ed6ab525 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -11,6 +11,9 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
+#define HL_CS_FLAGS_TYPE_MASK	(HL_CS_FLAGS_SIGNAL | HL_CS_FLAGS_WAIT | \
+				HL_CS_FLAGS_COLLECTIVE_WAIT)
+
 /**
  * enum hl_cs_wait_status - cs wait status
  * @CS_WAIT_STATUS_BUSY: cs was not completed yet
@@ -737,8 +740,7 @@ static int hl_cs_sanity_checks(struct hl_fpriv *hpriv, union hl_cs_args *args)
 		return -EBUSY;
 	}
 
-	cs_type_flags = args->in.cs_flags &
-			~(HL_CS_FLAGS_FORCE_RESTORE | HL_CS_FLAGS_TIMESTAMP);
+	cs_type_flags = args->in.cs_flags & HL_CS_FLAGS_TYPE_MASK;
 
 	if (unlikely(cs_type_flags && !is_power_of_2(cs_type_flags))) {
 		dev_err(hdev->dev,
-- 
2.17.1

