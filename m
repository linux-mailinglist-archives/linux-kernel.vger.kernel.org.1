Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401502B2D5F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 14:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgKNNlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 08:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgKNNlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 08:41:35 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0D1C0613D1;
        Sat, 14 Nov 2020 05:41:35 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id y17so12232456ejh.11;
        Sat, 14 Nov 2020 05:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oCiHauMY/pbQZ8o5QcU4bw23qyqCEf72jnXhjHhGCU8=;
        b=HQ3r1+UAbF1vLX/yrABgaISynyAIxVDSRJHXPrRcg+pNNpjXsjcmYCDe60r4A2uOxI
         39Ftn8FFmhFnivyUIk/wKHp4WjjPrMrxfshblRMjyA7EtSq9FJeLhV6WPtNSizI1FOu3
         tYW0pV7KPFVO9e7ldqpv+m6VqsRs9Rcuv8ob3x5AaWpQZfDIfH8J0oh/t+mWB2+mkpt2
         mva/bLpxUxTJkqbSCA53R0e3LH1Y3/oL9Ud/Bwaw/KTkoze7ixobBQCsy7RTaRHakBXT
         kobQCrKVUkS7g7TMgn2YYL5s8ZxZn9CqzyOvIa5F8fli/LSgEK2dicriiu/hoFCc4KGW
         H3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oCiHauMY/pbQZ8o5QcU4bw23qyqCEf72jnXhjHhGCU8=;
        b=WQDqJhcFFEihX31mTix4sHtIsM1SYk3Fup0JYyJYQj5ZxY4qvBXCjQ7L9S+wKvpBlE
         vNfinmnKod1L3nysJNROjPVwrFd0SxpbuFEPULeHIPhLCsd+xaI/Kt9SrmL4Um3GfeIV
         gj4MFt/Eqh956Kgeeok5cIe5c3eTCwyJPpelUoxP/KjdBVZ1Jcj6TbC7nrmmQvsuBYFP
         ZjW1cMiTDYpFS+dHRDHYSpm5bKv/S/DlyTHKbXoCk4zTU3P8sGxF+Vg9Z2kd3OlN0DhL
         qh9cjdcacT6QvtOrtKArjW0WFp4FEH+ScxF2Xp2nTBjHhSpjR2eSuckDLr9SlKtxSCfU
         AiFg==
X-Gm-Message-State: AOAM530m8aFPRCJ708+sIijyN9TFereuUJSrBxJKtL4kvrzFwtW4u91C
        FLiDSjE9k8DoKKFw0XPCHYQ=
X-Google-Smtp-Source: ABdhPJw45tu2V6Tj+ePi7yM5zSpKrIu1abxfh7y0HE3exy81Q5qjskb8dFZdJ8H/g3zx8oKAAn6uXg==
X-Received: by 2002:a17:906:d784:: with SMTP id pj4mr6420803ejb.78.1605361293854;
        Sat, 14 Nov 2020 05:41:33 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l20sm6589314eja.40.2020.11.14.05.41.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Nov 2020 05:41:33 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     zhangqing@rock-chips.com, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: rockchip: fix i2s gate bits on rk3066 and rk3188
Date:   Sat, 14 Nov 2020 14:41:25 +0100
Message-Id: <20201114134125.6169-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201114134125.6169-1-jbx6244@gmail.com>
References: <20201114134125.6169-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip PX2/RK3066 TRM under CRU_CLKGATE7_CON
gives this info:

hclk_i2s_8ch_gate_en  bit 4 (dtsi: i2s0)
hclk_i2s0_2ch_gate_en bit 2 (dtsi: i2s1)
hclk_i2s1_2ch_gate_en bit 3 (dtsi: i2s2)

The Rockchip PX3/RK3188 TRM under CRU_CLKGATE7_CON
gives this info:

hclk_i2s_2ch_gate_en  bit 2 (dtsi: i2s0)
hclk_i2s_8ch_gate_en  bit 4 (not used in rk3188.dtsi)

The bits got somehow mixed up in the clk-rk3188.c file.
The labels in the dtsi files are not suppose to change.
The sclk and hclk names should match for
"trace_event=clk_disable,clk_enable",
so remove GATE HCLK_I2S0 from the common clock tree and
fix the bits in the rk3066 and rk3188 clock tree.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/clk/rockchip/clk-rk3188.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index db8c58813..0b76ad34d 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -449,7 +449,6 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 
 	/* hclk_cpu gates */
 	GATE(HCLK_ROM, "hclk_rom", "hclk_cpu", 0, RK2928_CLKGATE_CON(5), 6, GFLAGS),
-	GATE(HCLK_I2S0, "hclk_i2s0", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
 	GATE(HCLK_SPDIF, "hclk_spdif", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 1, GFLAGS),
 	GATE(0, "hclk_cpubus", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 8, GFLAGS),
 	/* hclk_ahb2apb is part of a clk branch */
@@ -634,8 +633,9 @@ static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(0), 12, GFLAGS,
 			&rk3066a_i2s2_fracmux),
 
-	GATE(HCLK_I2S1, "hclk_i2s1", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 3, GFLAGS),
-	GATE(HCLK_I2S2, "hclk_i2s2", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 4, GFLAGS),
+	GATE(HCLK_I2S0, "hclk_i2s0", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 4, GFLAGS),
+	GATE(HCLK_I2S1, "hclk_i2s1", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
+	GATE(HCLK_I2S2, "hclk_i2s2", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 3, GFLAGS),
 	GATE(HCLK_CIF1, "hclk_cif1", "hclk_cpu", 0, RK2928_CLKGATE_CON(6), 6, GFLAGS),
 	GATE(HCLK_HDMI, "hclk_hdmi", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 14, GFLAGS),
 
@@ -728,6 +728,7 @@ static struct rockchip_clk_branch rk3188_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(0), 10, GFLAGS,
 			&rk3188_i2s0_fracmux),
 
+	GATE(HCLK_I2S0, "hclk_i2s0", "hclk_cpu", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
 	GATE(0, "hclk_imem0", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 14, GFLAGS),
 	GATE(0, "hclk_imem1", "hclk_cpu", 0, RK2928_CLKGATE_CON(4), 15, GFLAGS),
 
-- 
2.11.0

