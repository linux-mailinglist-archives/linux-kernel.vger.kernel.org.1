Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006DA2D3F29
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgLIJvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729571AbgLIJuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:50:50 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F9EC061285
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 01:49:37 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id l23so612889pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 01:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PrCTAg81K8KnVj0cwCcOSdceG5jg9Rol6nxvrFRqC7s=;
        b=aqQDQl6MRjWwoP2yw4T8/K3BRlu3VlimxLymxRpw6oZ2TIBzSNeg6cCnFH7tWWJMdg
         0asBiYxpTxfD/nW01e/qQlpBO25LWiWIA6VbQ5iCmTk75sT85lwAOWo4Y+Zk59CUPxz9
         bRhTHfv3Ed+m1BOFXV6Paijjxg2HJtWMz7aaGOtyt4yQ9e+zWwqFacDq2tcWlktp2Y/6
         9OE5FEu1uN3nTV5X7m0+jrLNs+NOCpk2SfimO0JSlk0KM6VD3s2LBTHzGanhCAu8LlDQ
         qnSSWoe6ogW0CCw0pUGaMPenl6ZnVAOhEZIyMMJ/Axb9MlUi8DWqGfrgPSctp7pInxzk
         fAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PrCTAg81K8KnVj0cwCcOSdceG5jg9Rol6nxvrFRqC7s=;
        b=oZnBZMP0XJ2eCdiiBk81WXxOv4888wz9QVDqrviQuK9sGc21/4d9vWXmBaqjAHsMhY
         NPHsOPAW8lTxi2zMQYxmVrP/5OSYdf9ETDDRSrscnAErl0iwqYPGECoCmwlw2Sg52jNB
         b9RbaOSz3LPDNAyg1Qv6J4ppabLlGSrgTE21cJCXVRjq+Wcsj/UpCwr7mP50zixysmAk
         M4OHRKjHgk0q3NVt/mEXqW+g8JRvqcQgUr4A936R7ydYQhfsm18+6RKF4JU+zAFlBxOa
         /rU9CqOzZ361d3O94ku0z8ZjpMF9lq71dqadix+AJ476jVkgo303/WJ6/C/+QZ7/HPJe
         rNHQ==
X-Gm-Message-State: AOAM5313FaRFVGcm5Pp+6N+8UuKxOOWe0D467fHHrumdC+IFZIc/LXZA
        re1aw7d1gBHLPUSkR3VZG4B7ew==
X-Google-Smtp-Source: ABdhPJyrwB5UR6zn1ToVfsm2FNS047MMOHPkD6Jq+cWszUtiT4M68q2Zgdzn5wo1XzVbdMyoKARRvw==
X-Received: by 2002:a17:90b:b0d:: with SMTP id bf13mr1471187pjb.194.1607507377289;
        Wed, 09 Dec 2020 01:49:37 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 129sm1890354pfw.86.2020.12.09.01.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 01:49:36 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>
Subject: [PATCH v7 4/5] clk: sifive: Fix the wrong bit field shift
Date:   Wed,  9 Dec 2020 17:49:15 +0800
Message-Id: <20201209094916.17383-5-zong.li@sifive.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209094916.17383-1-zong.li@sifive.com>
References: <20201209094916.17383-1-zong.li@sifive.com>
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

