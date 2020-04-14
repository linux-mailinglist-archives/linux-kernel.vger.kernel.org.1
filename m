Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390101A8BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 22:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505390AbgDNUAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 16:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505371AbgDNUAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:00:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B77C03C1A9;
        Tue, 14 Apr 2020 13:00:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so15707243wma.4;
        Tue, 14 Apr 2020 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QOT6jBh5RHTtvKF0ff1JDdUtPrhDEedCclbut6CMHz8=;
        b=ltgZG4pYMMJ6ZY7wVTwqMRmtGMNXJXPW1JBs5huXnLLaRWqURGzP/fixWgS5H8iSrx
         iHzXKkG0yUaEFarf2nj/Z68ZQ1wmM878ugSiUvGFF4tlyFYlh1GXKZu1CbnIfYra9r2I
         mBORt9ezjUeq+jxZ8rL+j07j1QOX4FdUKW6k9786hy0xN5t+HTUF1OPk7Q/sQObOoo7o
         SthNf1HbShAgFvvW3m9S1zZYlaCmc8RaOgAgkFX4F7SIo2Hc0BX6+3QZkxnI+NwClyRN
         70Nd0zBKyecbiGpKobA8HWVeI0DX+bhgRq0oEREm7avl6tmBOBBq8unBLCT691SoWiwS
         FDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QOT6jBh5RHTtvKF0ff1JDdUtPrhDEedCclbut6CMHz8=;
        b=TlKK2VoB4ly7qosrfiLYw08uYUeE1zPlgKWM4+/anJ8U5Fv9CkzBiMJm5SqCS+9C34
         fsoy8aRz5rcTjdw/cTEAI5/Xc6D+xekB4GQ2zk25SRD35+u8FHB/ckI32E+vP3BsSGVS
         DUqpTWfOyZaIAMYfrCouo2BhE2mNa6M/DhIaT+cXKhWZmrCSSCm7GZANVmWG+yeAkJap
         rh5885QdpO8UWfkihhp91KhqntlLTvhn+YwOuapcYgOqr65mz3oQfDokCgzOXvAkUGMT
         v1L0emX2qbkzffzdNOBWd0J5a7cbVYtMJ+jhGVLzyW9U30w3aAQPY/7GJLqwRnN+YACe
         Pa6Q==
X-Gm-Message-State: AGi0PuZD6C1/2YoJNJqbXF/nP/MTS6metegJBk52fOrjxBOOOWJxJkz2
        LFChmgaymPExCvKzuL9lKo7l4gbCfKM=
X-Google-Smtp-Source: APiQypJxSfupVcVY3tsTEfwY5Bo6ocg546NiCXQLE2PxKF7+H7AGFvO+rPQUNO8wobXymCcuF5vtjQ==
X-Received: by 2002:a1c:7d4b:: with SMTP id y72mr1493618wmc.11.1586894432487;
        Tue, 14 Apr 2020 13:00:32 -0700 (PDT)
Received: from localhost.localdomain (p200300F13717DF00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3717:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b4sm15540253wrv.42.2020.04.14.13.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:00:32 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/4] clk: meson: meson8b: Make the CCF use the glitch-free VPU mux
Date:   Tue, 14 Apr 2020 22:00:17 +0200
Message-Id: <20200414200017.226136-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414200017.226136-1-martin.blumenstingl@googlemail.com>
References: <20200414200017.226136-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "vpu_0" or "vpu_1" clock trees should not be updated while the
clock is running. Enforce this by setting CLK_SET_RATE_GATE on the
"vpu_0" and "vpu_1" gates. This makes the CCF switch to the "vpu_1"
tree when "vpu_0" is currently active and vice versa, which is exactly
what the vendor driver does when updating the frequency of the VPU
clock.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index ed4b70c2d4bd..427392678fec 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -2063,7 +2063,7 @@ static struct clk_regmap meson8b_vpu_0 = {
 			&meson8b_vpu_0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -2134,10 +2134,18 @@ static struct clk_regmap meson8b_vpu_1 = {
 			&meson8b_vpu_1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
 	},
 };
 
+/*
+ * The VPU clock has two two identical clock trees (vpu_0 and vpu_1)
+ * muxed by a glitch-free switch on Meson8b and Meson8m2. The CCF can
+ * actually manage this glitch-free mux because it does top-to-bottom
+ * updates the each clock tree and switches to the "inactive" one when
+ * CLK_SET_RATE_GATE is set.
+ * Meson8 only has vpu_0 and no glitch-free mux.
+ */
 static struct clk_regmap meson8b_vpu = {
 	.data = &(struct clk_regmap_mux_data){
 		.offset = HHI_VPU_CLK_CNTL,
@@ -2152,7 +2160,7 @@ static struct clk_regmap meson8b_vpu = {
 			&meson8b_vpu_1.hw,
 		},
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_NO_REPARENT,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.26.0

