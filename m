Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6162C6AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbgK0RxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732435AbgK0RxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:53:05 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C673C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:05 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so4854815pgg.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N2E66pa7IBvbk/IdE1gRolkB3YRUxj5SwwwquVUhVR0=;
        b=pIpihkDY74fXrCHjsuncXZDFXvcA255ISOL8COtoKZArXL9njuSF09wIFKLtgXRBra
         LmQ1rTvtCDfKDHtgUiQJc21m2l37Sbi1pCQk6ONTWhA7MVRRk6J5PzRLSf2XeieL9NDd
         h4TLim34tz9UIUjyAQcU5spDp/puUHr46m98GyvNCmWWK9hLZg4lUQBmMMZUNFnpyJ0G
         40CnLRiPOCDjT4eToCGN7hbQf4nPu2mzqfULmKq9VyLRY7B5nZSQnM3AgMmfVJ9X7r/T
         lfcCGY0A41Ci3+uIf/APUkE4BWivszX5SNwT1ZrbN4A1whdVsR7CWoGD4+5eXVRZeANo
         mzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N2E66pa7IBvbk/IdE1gRolkB3YRUxj5SwwwquVUhVR0=;
        b=qheRvA1f/4VhL4Zt9p/8yX/Jr5i76Doimh8KygNTBTMnmE0CNyQuB/kI9TLnpXjnbT
         JxJC80DS58n75xSKyax9NNlXStc6bliduLRrixRTSAYwFPp0pSWLFvuEpj1nQMJPJoSx
         IAVsC7xIwph0HwkPltRhn/FrOYyRKCrpsOSxuZOq/OP0DtmjuphgEBMRp/sw3afa9uv5
         h7lAv1dMdSuGQYSnzd+KKIVA5GP7vkH2QN17fUJvRRwknhTrFd8nbMxaFsYVeEhbZG5i
         nD/773/cDQB8ooK0BivoZYAK2qckZYGzfewzckVjlzsprjFs9npn4ud9KUKu7ltRLoAL
         ZZnw==
X-Gm-Message-State: AOAM533aKF/A6TXMBgl6xsX/IiA5Psj1mOAAuUvpCKH8DP1cZx/d5qvU
        nGN2kZbL7MLSCR3e/IY6oXZ+V4SNXYm5CJWz
X-Google-Smtp-Source: ABdhPJzPAsxWzRLEs6bXY5Z3FEYuJROkKzl0rF7LTRBS0/IguKssWrIJfBDcUxZLKLhfC0QwtG0IOQ==
X-Received: by 2002:a17:90b:814:: with SMTP id bk20mr11114687pjb.61.1606499585063;
        Fri, 27 Nov 2020 09:53:05 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:53:04 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] coresight: etm4x: Handle TRCVIPCSSCTLR accesses
Date:   Fri, 27 Nov 2020 10:52:48 -0700
Message-Id: <20201127175256.1092685-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
References: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

TRCVIPCSSCTLR is not present if the TRCIDR4.NUMPC > 0. Thus we
should only access the register if it is present, preventing
any undesired behavior.

Cc: stable@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 28dd278f6d47..d78a37b6592c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -141,8 +141,9 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	writel_relaxed(config->viiectlr, drvdata->base + TRCVIIECTLR);
 	writel_relaxed(config->vissctlr,
 		       drvdata->base + TRCVISSCTLR);
-	writel_relaxed(config->vipcssctlr,
-		       drvdata->base + TRCVIPCSSCTLR);
+	if (drvdata->nr_pe_cmp)
+		writel_relaxed(config->vipcssctlr,
+			       drvdata->base + TRCVIPCSSCTLR);
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
 		writel_relaxed(config->seq_ctrl[i],
 			       drvdata->base + TRCSEQEVRn(i));
@@ -1202,7 +1203,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	state->trcvictlr = readl(drvdata->base + TRCVICTLR);
 	state->trcviiectlr = readl(drvdata->base + TRCVIIECTLR);
 	state->trcvissctlr = readl(drvdata->base + TRCVISSCTLR);
-	state->trcvipcssctlr = readl(drvdata->base + TRCVIPCSSCTLR);
+	if (drvdata->nr_pe_cmp)
+		state->trcvipcssctlr = readl(drvdata->base + TRCVIPCSSCTLR);
 	state->trcvdctlr = readl(drvdata->base + TRCVDCTLR);
 	state->trcvdsacctlr = readl(drvdata->base + TRCVDSACCTLR);
 	state->trcvdarcctlr = readl(drvdata->base + TRCVDARCCTLR);
@@ -1310,7 +1312,8 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	writel_relaxed(state->trcvictlr, drvdata->base + TRCVICTLR);
 	writel_relaxed(state->trcviiectlr, drvdata->base + TRCVIIECTLR);
 	writel_relaxed(state->trcvissctlr, drvdata->base + TRCVISSCTLR);
-	writel_relaxed(state->trcvipcssctlr, drvdata->base + TRCVIPCSSCTLR);
+	if (drvdata->nr_pe_cmp)
+		writel_relaxed(state->trcvipcssctlr, drvdata->base + TRCVIPCSSCTLR);
 	writel_relaxed(state->trcvdctlr, drvdata->base + TRCVDCTLR);
 	writel_relaxed(state->trcvdsacctlr, drvdata->base + TRCVDSACCTLR);
 	writel_relaxed(state->trcvdarcctlr, drvdata->base + TRCVDARCCTLR);
-- 
2.25.1

