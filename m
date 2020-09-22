Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB54E27487F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgIVSrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVSrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:47:25 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AD6C061755;
        Tue, 22 Sep 2020 11:47:24 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m5so19195627lfp.7;
        Tue, 22 Sep 2020 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4Y/6FQqT3jIgw08v+cefw+FL1jMcOBl2bq1nWZI7IU=;
        b=W5jOyQGF/o1gTtJB67PyjuH/WJvsFGWvi/KtMENc6G7hj84QmRchtr5+4nYh/HzPpm
         VelY1RsM5GrZ2tZLUKk59JBeZ/zOAiF19bHud0RhbP5ppqLP+gV9+gQycCkLb3Sl0ebJ
         C/26XfS/XWVVnZ95NCTHAYn0bmDSs/gpwqpsiSEjEvrigljPsJ9MoIgGgXXkztHodYSc
         scCBln4Q+Flq97JTkZIqAi2q1PPX54VFzwA2ocqaKANLmnhpCTiETYrc9mV92zv7p0hR
         DPiZq+VAN8ANzs2iF2NzxT4BHMmB5fPxQpQ5xX+GhE/9Yzy3KbsesiUNbWbR9cOZ2ATY
         BayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q4Y/6FQqT3jIgw08v+cefw+FL1jMcOBl2bq1nWZI7IU=;
        b=gKS7Wlg9mL5Yz0xs93LRaXcowL7i/jZAnZP2bvCiC8172TSgx/bQHtzlqbYgLlXVk+
         Nz9Vrt/SLYev1rPVLJ/PWWTWC00DiZbhT0EDIwfBoLd72ZMe/2TFYcnnNBIAELLhyfiG
         PB+i7Cqayf/CtjKElCT/tx8Zr1ipGmxRI4yzRzcCHYHj/5FqlL6JEm/Xgsz46sMK5atV
         rkVtmq/N7LJuLtVIyzS4LaKCYqc+/rhJw9+nELbQPOEdsIgQC8ZtHwe6KLAiDw5iaJdr
         0tgYSEeDFsom+iH7njGJq2LMOyp8Cf0/PvJicWGM4iFef6iHHr5XVoMgsQpUWwu/yYz+
         b7+A==
X-Gm-Message-State: AOAM533iofRwm1UQXA0yykCFovjjhGchfbMh+eDPmsFO1W14dEVLrlQm
        1lQUUwpys0zuMfr4aFBtQFw=
X-Google-Smtp-Source: ABdhPJwshtxcNHfUvtKaZALwb//DGBaWq6PQP1Q+qcnT4Gm4WLYpoD8GFWPCfYR1FhXZz3HLkE71/g==
X-Received: by 2002:ac2:5f77:: with SMTP id c23mr2326967lfc.568.1600800443235;
        Tue, 22 Sep 2020 11:47:23 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id q6sm4067962ljg.115.2020.09.22.11.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 11:47:22 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] clk: pxa: Constify static struct clk_ops
Date:   Tue, 22 Sep 2020 20:47:15 +0200
Message-Id: <20200922184715.1854-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a couple of static struct clk_ops that are not modified. Their
only usage is inside the macros and their address is passed to
clk_register_composite() which takes pointers to const struct clk_ops.
This allows the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/clk/pxa/clk-pxa.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/pxa/clk-pxa.h b/drivers/clk/pxa/clk-pxa.h
index f131d2834af4..5768e0f728ce 100644
--- a/drivers/clk/pxa/clk-pxa.h
+++ b/drivers/clk/pxa/clk-pxa.h
@@ -19,11 +19,11 @@
 #define MUX_RO_RATE_RO_OPS(name, clk_name)			\
 	static struct clk_hw name ## _mux_hw;			\
 	static struct clk_hw name ## _rate_hw;			\
-	static struct clk_ops name ## _mux_ops = {		\
+	static const struct clk_ops name ## _mux_ops = {	\
 		.get_parent = name ## _get_parent,		\
 		.set_parent = dummy_clk_set_parent,		\
 	};							\
-	static struct clk_ops name ## _rate_ops = {		\
+	static const struct clk_ops name ## _rate_ops = {	\
 		.recalc_rate = name ## _get_rate,		\
 	};							\
 	static struct clk * __init clk_register_ ## name(void)	\
@@ -38,7 +38,7 @@
 
 #define RATE_RO_OPS(name, clk_name)				\
 	static struct clk_hw name ## _rate_hw;			\
-	static const struct clk_ops name ## _rate_ops = {		\
+	static const struct clk_ops name ## _rate_ops = {	\
 		.recalc_rate = name ## _get_rate,		\
 	};							\
 	static struct clk * __init clk_register_ ## name(void)	\
@@ -53,7 +53,7 @@
 
 #define RATE_OPS(name, clk_name)				\
 	static struct clk_hw name ## _rate_hw;			\
-	static struct clk_ops name ## _rate_ops = {		\
+	static const struct clk_ops name ## _rate_ops = {	\
 		.recalc_rate = name ## _get_rate,		\
 		.set_rate = name ## _set_rate,			\
 		.determine_rate = name ## _determine_rate,	\
-- 
2.28.0

