Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41A2303DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391383AbhAZMu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391930AbhAZMsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:48:17 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E41EC0698D4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p15so9651672wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hzg/8SeTRT9UK29/olnLfJGacHt08VbSRV0nHnvSoU=;
        b=lWLMnRxvowPMTlaDJFbNmxhWgm9vJFK+V3MilmPDueEgsYLNCwYZs2Mw5//Msre6qQ
         YcjO+ASNJk3CbvBVUYwwHcHahYoOqtB8ehm1UpFkqSIJBT8QAJ024vozCOPtLzFd+3b5
         g4fxKhngoF4xS+5GGHYywN6bcClh8Wl19yOJD32Z251yGQg5GdhAKtHiYMwdMt4WSw1q
         HN/GXTIpG0IqWFvdZUHU0z9s4P2Ot6ijnJNAK7WFc1RXG/G+0qpBigJQ+LjjIT2CxTlr
         68+rz+iOskjnDT95YnpRsbrsFvhIZVm8X5CyOTHiOLvH909RbcktdBJbIospbxigq/qK
         +KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hzg/8SeTRT9UK29/olnLfJGacHt08VbSRV0nHnvSoU=;
        b=aK7zfFt86He9luxtBPIQ3BB4p3V/s80N/C4SSPLwReGbi1HG0b1TwtNL9iKKZCwvSR
         tZxtHz3YW4lQsxbZao3cNuHiKqw3QZY9d+UkFLTgOxVPuXqZ3fqWqHnaRnkiJHkL4TpM
         dLUrusPS0H2Tu6fjh9Sub3iuZl/Ni9Ym+JlIbrVwfexvld9Nv7AX43nH3ZwQttYM9gHN
         E+ldv5Wi0zT6HsW/eCLLcdBcoenStKy3nhIIsrpN+SHChEME6Oif/i1WvQ/DrXOe7caG
         1QCme3cvzuYZC1M+nh/w4CYSjURJKDmaBbtCsCbgq89qB+2QKLYwNppaJkPkOvhvdB3b
         ZVPQ==
X-Gm-Message-State: AOAM530Su85YAUEHMpotW9t5mdwNSxSxuHOM4C9EQgoZbQoyX2HQGuKA
        Dcdc76+bxEGFJwEi5zB7xafcBQ==
X-Google-Smtp-Source: ABdhPJyjU0lvjeO1wQqSvovQaY4hrhJ2Yh/ZGBtMcXbxz0ciC4bx2nwk/1XVyHtHHP4m8h3In3D4QA==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr5719822wrk.89.1611665154192;
        Tue, 26 Jan 2021 04:45:54 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:45:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/21] clk: clkdev: Ignore suggestion to use gnu_printf() as it's not appropriate here
Date:   Tue, 26 Jan 2021 12:45:27 +0000
Message-Id: <20210126124540.3320214-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124540.3320214-1-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/clkdev.c: In function ‘vclkdev_alloc’:
 drivers/clk/clkdev.c:173:3: warning: function ‘vclkdev_alloc’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/clkdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 0f2e3fcf0f19f..5e5f25d568724 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -153,6 +153,11 @@ struct clk_lookup_alloc {
 	char	con_id[MAX_CON_ID];
 };
 
+#pragma GCC diagnostic push
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
+#endif
+
 static struct clk_lookup * __ref
 vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	va_list ap)
@@ -177,6 +182,8 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	return &cla->cl;
 }
 
+#pragma GCC diagnostic pop
+
 static struct clk_lookup *
 vclkdev_create(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	va_list ap)
-- 
2.25.1

