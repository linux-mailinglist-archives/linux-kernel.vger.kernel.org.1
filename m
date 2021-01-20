Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25582FCE05
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbhATKQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731397AbhATJcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:32:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBC2C06179A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:52 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c127so2168507wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bl3ZcRKmZS4HxdqARjxCZVUBXdgf/EJ6RpkdvaEOCdc=;
        b=pY0GsnMn4gmD2ge9U3lJIxZsM+l6cJl1kCMqXpiHVrfP0HvMIX9M+/aq8DbwtDyJqy
         YcPJQ54ZlWCgYjaygeNanshMMlXgi3Hp4BCeGHn/59fmidFS7v9OHnDti0955IHSSU7r
         WvaXVSR7+dLzNdHFU5cXx2sL/jtxQBFzomb8PUvAq0CBBfOW2wquWBbjAep23otLx68t
         0+bI26L+HLuGPNuOAxoEOjS67pBwXaOQzISkOeRky+a41Ofz+WdLeTb9QX6L14xMXbQX
         RAaARl19H3isMUfwCvUdQpCli4C0SzLZPO22XNw850O32LTmNp4Jfry7rqjS2gElXg7e
         Uhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bl3ZcRKmZS4HxdqARjxCZVUBXdgf/EJ6RpkdvaEOCdc=;
        b=BtlugXDv/NedPuLbBBQQNCMwPIncDqe9Ov3bQ2slP4TsD1IkbfXttQJykT9Gu9Bjya
         E36tgdzEIR0zXgUMNvttktisf23SvE1tj2OKodJAXWIL5vwLu1PkFX2/thhnHYQV8ma+
         V1/LEZQpM5K8gYl8v4hY26sitMeAl5UVuVUYoVon05IDU6Bi5YzSLQkibVBfIXVCyjr0
         1nVGXigwfFzji6OTpQ+UUV5ENjEA8oeSWbUY/HOP4GkipUfacp9reR0VkZzvs2grWdu8
         bp1AybKA9hzPjqr2WX7dHv86QRdkdrqftkslYqrtIudkwMj+s8GQJG4u8LcyPk+i/VzF
         SDJA==
X-Gm-Message-State: AOAM531+OHoXEOPSM7ds/yNxjoeLd1jz5YihgiiBoS7bLSyL+GSnINL+
        4xXMyrG+9NoejLyXYbwWZg9S9g==
X-Google-Smtp-Source: ABdhPJzAKQ58Tef4aS2NktoFCutcy4kxigfx/GU4jNbB0hg2UUSg9n4CG2bkXxQuuR8Ms4acU4KrgA==
X-Received: by 2002:a1c:98c6:: with SMTP id a189mr3388765wme.88.1611135051160;
        Wed, 20 Jan 2021 01:30:51 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:30:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Pragnesh Patel <Pragnesh.patel@sifive.com>,
        Zong Li <zong.li@sifive.com>, linux-clk@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 06/20] clk: sifive: fu540-prci: Declare static const variable 'prci_clk_fu540' where it's used
Date:   Wed, 20 Jan 2021 09:30:26 +0000
Message-Id: <20210120093040.1719407-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120093040.1719407-1-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/sifive/fu540-prci.h:16:35: warning: ‘prci_clk_fu540’ defined but not used [-Wunused-const-variable=]
 drivers/clk/sifive/fu540-prci.h:16:35: warning: ‘prci_clk_fu540’ defined but not used [-Wunused-const-variable=]

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Pragnesh Patel <Pragnesh.patel@sifive.com>
Cc: Zong Li <zong.li@sifive.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/sifive/fu540-prci.h  | 5 -----
 drivers/clk/sifive/sifive-prci.c | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/sifive/fu540-prci.h b/drivers/clk/sifive/fu540-prci.h
index c8271efa7bdc7..c220677dc0108 100644
--- a/drivers/clk/sifive/fu540-prci.h
+++ b/drivers/clk/sifive/fu540-prci.h
@@ -13,9 +13,4 @@
 
 extern struct __prci_clock __prci_init_clocks_fu540[NUM_CLOCK_FU540];
 
-static const struct prci_clk_desc prci_clk_fu540 = {
-	.clks = __prci_init_clocks_fu540,
-	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu540),
-};
-
 #endif /* __SIFIVE_CLK_FU540_PRCI_H */
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index c78b042750e21..1490b01ce6290 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -12,6 +12,11 @@
 #include "fu540-prci.h"
 #include "fu740-prci.h"
 
+static const struct prci_clk_desc prci_clk_fu540 = {
+	.clks = __prci_init_clocks_fu540,
+	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu540),
+};
+
 /*
  * Private functions
  */
-- 
2.25.1

