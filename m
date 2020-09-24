Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE12769F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgIXHDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgIXHDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:03:11 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBD4C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:03:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x23so2349196wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jssa9n+zCohTd1HIhdeBPoBHmY2NZVlJogjq7LMj1Bk=;
        b=BdX995lVpEIofZzWCP2e0WjDmuHpbrLLnXQKseBxVhPqOVtIFldtVdYCxD7tF8EQpo
         Gkac/qUoYCg0/qdIUHWk4cA62qmb6ThSWXy/gNE+T2FofMsJ1dLso5F4ThEEk8INEIdb
         EjZLEpiNdHtf1oxmgyfnLiffZNrXQwsWVknwRRsOLCDmGxD1Iqw9qd58uzaHAh359MDM
         Iq+wdBLDPeQlUBHCDMUKTykm74Dbcz8h10MoPdeQ0loKObRLFLJEIpKOTzT1AUIO7x3Z
         lK0xMq2054Hx1G6/V9t2bVIcjgR4uCvrL2jhuUVwEAZtiJhjGKU6FzKXjIf9optlGlBY
         dLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jssa9n+zCohTd1HIhdeBPoBHmY2NZVlJogjq7LMj1Bk=;
        b=bZ6PtJ7Kg/1QrqLhXQazfbGcBREN84oBLrjjo87uy7vYAlhirIXS6Q1hZcBZdYgLs4
         jSNBWdM5H6jtPLV7RZOSoNAMQ7pzFP2WtPcFqLlpgzlXmHgqO2DSugzUhf5WoGDyPh3M
         ooOa3CGqR1oyDWKJc51L7V09/OWbDrfLOvNAG7vNDlDdlrkNiupNjkHmT0/VfMGxQB0y
         GPISgCyZqy9X9cwJfnt8VNB8OmOwpzFRwi20b/WKPTM1+ShD1XfRBhK8fPccSCLfQ+Eu
         FK0N4rlH+K1FS7vOqpKR2igaRWGIVVE5WszXbvjdjWfK/m973/7Lzyyy9aqItASE3osa
         TYDw==
X-Gm-Message-State: AOAM533QX3wSMGZbesi1nXGRSwj69CqMdCIpJVYi0H9HxE49IY2yemOk
        fkTj519bnKWf6PTKMO0EPliVVve0cao=
X-Google-Smtp-Source: ABdhPJyzWWhMkB3roFpqFuJn3OvBd76OH3d5N1UtdGNB7JaO8VoXQMmWXmROgIDZVtMIXdYBUqtjFA==
X-Received: by 2002:a1c:9885:: with SMTP id a127mr3168856wme.8.1600930986379;
        Thu, 24 Sep 2020 00:03:06 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id n4sm2320628wrp.61.2020.09.24.00.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:03:05 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH 3/4] habanalabs: add debug messages for opening/closing context
Date:   Thu, 24 Sep 2020 10:02:58 +0300
Message-Id: <20200924070259.19833-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924070259.19833-1-oded.gabbay@gmail.com>
References: <20200924070259.19833-1-oded.gabbay@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During debugging of error we sometimes need to know whether the error
happened when a user context was open. Add debug prints when opening and
closing user contexts.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/context.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index df8171a2226c..bd03ef074eed 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -28,6 +28,8 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 	kfree(ctx->cs_pending);
 
 	if (ctx->asid != HL_KERNEL_ASID_ID) {
+		dev_dbg(hdev->dev, "closing user context %d\n", ctx->asid);
+
 		/* The engines are stopped as there is no executing CS, but the
 		 * Coresight might be still working by accessing addresses
 		 * related to the stopped engines. Hence stop it explicitly.
@@ -41,6 +43,7 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 		hl_vm_ctx_fini(ctx);
 		hl_asid_free(hdev, ctx->asid);
 	} else {
+		dev_dbg(hdev->dev, "closing kernel context\n");
 		hl_mmu_ctx_fini(ctx);
 	}
 }
@@ -168,6 +171,8 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 			dev_err(hdev->dev, "ctx_init failed\n");
 			goto err_cb_va_pool_fini;
 		}
+
+		dev_dbg(hdev->dev, "create user context %d\n", ctx->asid);
 	}
 
 	return 0;
-- 
2.17.1

