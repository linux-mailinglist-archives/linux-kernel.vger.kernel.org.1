Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2812769F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgIXHDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgIXHDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:03:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AACC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:03:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so2344661wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aO7bASJ04QbcCD8y5/noP2Lml10J7qRtNgaZtcBkskQ=;
        b=JTDExfYkRhqRGg/FD1waotO5jbpXz+hhPzHrntF7yXyVVUMY6oiC3BkjZhNqVhZ1Td
         TOeSkRNZ0RImCFCLrlcdnNTDxalKZ7mnr0MnvmAq5vX/CYv0WbeySBi946K6fWk91av7
         ddexe/dJdE5sdMkXDooUX9mam88bTNeqyKDtsNtugf6kgQJqyvaMjNIRW2IMLs/ffz/m
         JL0w5rK4MjwGM7JW5M12SAEx/iQj2S3IlYe0yq6imBYRgTCWdOqZClWu17zaWJO4ZNRq
         qSr0T5ogGana5umkSYgtNlgxZrzkNbyAlgE3zi20VQCQGfMgLs/D78xowN4Ven/zoqn7
         qqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aO7bASJ04QbcCD8y5/noP2Lml10J7qRtNgaZtcBkskQ=;
        b=DZiaYxnCpIPV6i8ln9+5mWo6HsLfxtyELsMct5yenwH/ixpcyACTL/BZIIYulf25Uw
         AY2vGr6ghBJ1Gjjo8Hk8dwf8nyzvoI3QNCX/JG5mdHqsbbCsY5/LGhZGvQ5HBs7HCwYN
         OAy6NOwFGBVGjh+A11HQOClCPth4wJ4jRFNGoKUF3i2mohOhqg+Qf8f66XDseUxM31Ca
         K92qvnGxUhXIcrnz/wctZ96EYEVQnrT4sLhrgLr2i/y+BJTHyXbwi/+sXF+5/KQtzPr5
         Q60bDci0c8oWZa14w/JUsZ3mudWuFv5EvTFXmV7QG5BfeL3KWu7eSlZicATRHPUv9FFs
         dkog==
X-Gm-Message-State: AOAM533shJHoU2y7DWsSSA9Md8Mxw9lVUagcekVHc9wY2V6Stmbo3c6m
        0v2nOwThtQsjOCrAko6bCowLhBDz85c=
X-Google-Smtp-Source: ABdhPJxZDjUAKj0RIFcqtKWi8MFlamu4cDueKAFeSHNgYlbBbYbCwvdsGCtSpLU7QtYq0QTY9vWCvg==
X-Received: by 2002:a1c:9ec1:: with SMTP id h184mr3202484wme.180.1600930987820;
        Thu, 24 Sep 2020 00:03:07 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id n4sm2320628wrp.61.2020.09.24.00.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:03:06 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH 4/4] habanalabs: add notice of device not idle
Date:   Thu, 24 Sep 2020 10:02:59 +0300
Message-Id: <20200924070259.19833-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924070259.19833-1-oded.gabbay@gmail.com>
References: <20200924070259.19833-1-oded.gabbay@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device should be idle after a context is closed. If not, print a
notice.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/context.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index bd03ef074eed..7a59dd7c6450 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -12,6 +12,7 @@
 static void hl_ctx_fini(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev = ctx->hdev;
+	u64 idle_mask = 0;
 	int i;
 
 	/*
@@ -42,6 +43,13 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 		hl_cb_va_pool_fini(ctx);
 		hl_vm_ctx_fini(ctx);
 		hl_asid_free(hdev, ctx->asid);
+
+		if ((!hdev->pldm) && (hdev->pdev) &&
+				(!hdev->asic_funcs->is_device_idle(hdev,
+							&idle_mask, NULL)))
+			dev_notice(hdev->dev,
+				"device not idle after user context is closed (0x%llx)\n",
+				idle_mask);
 	} else {
 		dev_dbg(hdev->dev, "closing kernel context\n");
 		hl_mmu_ctx_fini(ctx);
-- 
2.17.1

