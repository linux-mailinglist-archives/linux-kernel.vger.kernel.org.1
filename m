Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6FE2C6AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbgK0RxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732435AbgK0RxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:53:02 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBB0C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:02 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id j19so4877782pgg.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GJXYp4Km0agTKmcKwAJJCl1K2VfvncDElm5EaJE1GqM=;
        b=tZX3jsO7XY1d7Bx+/7oRpk9LW+lIL2TY8F7PQ43sF9DcYtl43CZZQxZqg2Tp2jeTW0
         0fJoHEufWTa+wY/cTgiJDC89f8qz2DWP3MSqguJnUojSvcukb6Ijx4ny7s7WlXPXF53w
         49DeTJd4e+7hWT7QoS/gYKv6HxtJTstrmM26taT7T7SsCZW4o/ULWPCA9PbmqP1mZ0lF
         hqFb7eJZO8UAU1dMKrGpI8hmhthBgWvwshwEuawkkJ3lRxNnErFnTCEkTU1ojzSMjX+7
         ge/GkDKxE6a7kvRiuLzpcE884df/tRjDLSlPiwabZw8jU3MNS5qF7JqrF0D9NjTBKfEE
         Z5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GJXYp4Km0agTKmcKwAJJCl1K2VfvncDElm5EaJE1GqM=;
        b=o1O46i87B4IfwTmGgKCSIWGeUZeJBZ/fWQmpvkbf/SweufJ1ElOwDeNdGmMD4pRE2n
         NoahhOYG6jw70+3BZVNBZxdOdw4e51CdP54a03M291p1CCe8Xb50yP1pUNuVNV1NWP8B
         eA4xGGP7+pYwUbIKy9N3PGIWfQ4Ty20axbhIFXqapIsq8Ubx2mG2b6QjRQFGgd0n9idi
         A+r5+KYqR4NaC0rttOpOhrBAF2SfttUT+z0xeI4jlBAGnnTgTVVI8DQluj1rPSSoCgY6
         RH2I5rbkcvpfyI4NqKM5QdCWbqtUs1Ae5MdUZKfBL2n0x0st8ryJGiIXxJgUiix/2wrz
         J0Vw==
X-Gm-Message-State: AOAM5328YnbY77dWR6WyEJR4aOOU22eqsiDw5YN+AQHZ9pC9cIYyYYQH
        a8rC6rmMHXgNcbthl2Ls7s7aHg==
X-Google-Smtp-Source: ABdhPJwipCEQSTbORTgFzsLXhdZhD5ZneY/MHZ0luRGd+ozj+YTZGkjNA7l+NBF/crg+DTUcsttiQA==
X-Received: by 2002:a63:6e45:: with SMTP id j66mr7428918pgc.238.1606499582001;
        Fri, 27 Nov 2020 09:53:02 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:53:01 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] coresight: etm4x: Fix accesses to TRCCIDCTLR1
Date:   Fri, 27 Nov 2020 10:52:45 -0700
Message-Id: <20201127175256.1092685-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
References: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

The TRCCIDCTLR1 is only implemented if TRCIDR4.NUMCIDC > 4.
Don't touch the register if it is not implemented.

Cc: stable@vger.kernel.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index e67365d1ce28..af0ab2f44865 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -187,7 +187,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		writeq_relaxed(config->ctxid_pid[i],
 			       drvdata->base + TRCCIDCVRn(i));
 	writel_relaxed(config->ctxid_mask0, drvdata->base + TRCCIDCCTLR0);
-	writel_relaxed(config->ctxid_mask1, drvdata->base + TRCCIDCCTLR1);
+	if (drvdata->numcidc > 4)
+		writel_relaxed(config->ctxid_mask1, drvdata->base + TRCCIDCCTLR1);
 
 	for (i = 0; i < drvdata->numvmidc; i++)
 		writeq_relaxed(config->vmid_val[i],
@@ -1241,7 +1242,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		state->trcvmidcvr[i] = readq(drvdata->base + TRCVMIDCVRn(i));
 
 	state->trccidcctlr0 = readl(drvdata->base + TRCCIDCCTLR0);
-	state->trccidcctlr1 = readl(drvdata->base + TRCCIDCCTLR1);
+	if (drvdata->numcidc > 4)
+		state->trccidcctlr1 = readl(drvdata->base + TRCCIDCCTLR1);
 
 	state->trcvmidcctlr0 = readl(drvdata->base + TRCVMIDCCTLR0);
 	if (drvdata->numvmidc > 4)
@@ -1352,7 +1354,8 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 			       drvdata->base + TRCVMIDCVRn(i));
 
 	writel_relaxed(state->trccidcctlr0, drvdata->base + TRCCIDCCTLR0);
-	writel_relaxed(state->trccidcctlr1, drvdata->base + TRCCIDCCTLR1);
+	if (drvdata->numcidc > 4)
+		writel_relaxed(state->trccidcctlr1, drvdata->base + TRCCIDCCTLR1);
 
 	writel_relaxed(state->trcvmidcctlr0, drvdata->base + TRCVMIDCCTLR0);
 	if (drvdata->numvmidc > 4)
-- 
2.25.1

