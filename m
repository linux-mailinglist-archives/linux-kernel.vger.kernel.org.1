Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682F02C7FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgK3IZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbgK3IZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:25:00 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503B3C061A49
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:23:48 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b63so9903843pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PrCTAg81K8KnVj0cwCcOSdceG5jg9Rol6nxvrFRqC7s=;
        b=lt0l2V3uqwgrOX/KWWmPjQ+STQ7rfmcGtdnYPy8xaVV2vUWvn5MIcbKX+FU6bf1t+k
         PMSNLeIx2s56sZBrSUHmxwFvsrbBnMZsSZ53/j67DulJnCXJt/rudQYsQL1CLmKvrfBf
         n3fSLN/XHnloQImpzF4cdtzPBq/G7WYseUNFERjM3jowk60VGbfoWgFlE9lbPXmtsc2O
         AMWUKwKoePv3VqpYf+RnQU10bNnxB7pFfwVYRl6P9abGqaLj3xsToyuwNdY5KqKsBAOk
         psx71FVYVJjSG9PlNlno4QN39HRl8vIIjSrgEKW+aYZXzT2K+Mi00m/fmQl4WCEJkk3S
         Ueyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PrCTAg81K8KnVj0cwCcOSdceG5jg9Rol6nxvrFRqC7s=;
        b=ZrwbZgiMcoiXd8zuux+GUHUof6XCIyqrkCGvsEUNlomiM3VSha6lTfHEBlyT3vuULH
         bnL7r7OuDGTXsJ8vYxfq94t3CEPVlsWq7wTpAsPhuTO83Z2ACwLZD7u79pn3I32bvnGw
         qShfcZcHuuW5aRAJu7ZXUT7jF5fijqe7L5qhB0zluz6Bcefgf/ApuJQZjMMhQOtSeV46
         03eSRxIVoJm5dbgbVEwztnU+w0UWgyc33Q1ChwEfFoZmV2ssxZt/raYq4XRSTSM+FL5O
         TwiW7e5Vm3mnfA6+zPHL1gBlVsslMb6SWpNrR9s/CGxdLrLEhB2T33BjN3WytLl/W30n
         xBsw==
X-Gm-Message-State: AOAM530QFMW4RxGVabIR5X5e8EG50LZk2tFIeR5xIxuuueQvvAYCDJun
        RzhYf1xGRu+xymmw2G0KFUUx4A==
X-Google-Smtp-Source: ABdhPJwm8bzingF0I/74ejGc/kgQfw750DP5StvzaRpp/51pCP7HUnslf5gGjaXL7cVJsH1YUNBv1A==
X-Received: by 2002:a62:1d4b:0:b029:18a:df98:515f with SMTP id d72-20020a621d4b0000b029018adf98515fmr18055282pfd.30.1606724627920;
        Mon, 30 Nov 2020 00:23:47 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id u1sm21265338pjn.40.2020.11.30.00.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 00:23:47 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>
Subject: [PATCH v5 4/5] clk: sifive: Fix the wrong bit field shift
Date:   Mon, 30 Nov 2020 16:23:29 +0800
Message-Id: <20201130082330.77268-5-zong.li@sifive.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130082330.77268-1-zong.li@sifive.com>
References: <20201130082330.77268-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk enable bit should be 31 instead of 24.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reported-by: Pragnesh Patel <pragnesh.patel@sifive.com>
---
 drivers/clk/sifive/sifive-prci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
index 7e509dfb72d1..88493f3b9edf 100644
--- a/drivers/clk/sifive/sifive-prci.h
+++ b/drivers/clk/sifive/sifive-prci.h
@@ -59,7 +59,7 @@
 
 /* DDRPLLCFG1 */
 #define PRCI_DDRPLLCFG1_OFFSET		0x10
-#define PRCI_DDRPLLCFG1_CKE_SHIFT	24
+#define PRCI_DDRPLLCFG1_CKE_SHIFT	31
 #define PRCI_DDRPLLCFG1_CKE_MASK	(0x1 << PRCI_DDRPLLCFG1_CKE_SHIFT)
 
 /* GEMGXLPLLCFG0 */
@@ -81,7 +81,7 @@
 
 /* GEMGXLPLLCFG1 */
 #define PRCI_GEMGXLPLLCFG1_OFFSET	0x20
-#define PRCI_GEMGXLPLLCFG1_CKE_SHIFT	24
+#define PRCI_GEMGXLPLLCFG1_CKE_SHIFT	31
 #define PRCI_GEMGXLPLLCFG1_CKE_MASK	(0x1 << PRCI_GEMGXLPLLCFG1_CKE_SHIFT)
 
 /* CORECLKSEL */
-- 
2.29.2

