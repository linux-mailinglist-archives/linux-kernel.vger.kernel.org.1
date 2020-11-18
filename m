Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92142B7ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgKRN6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgKRN6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:58:33 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02A1C0613D4;
        Wed, 18 Nov 2020 05:58:32 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id f23so2906096ejk.2;
        Wed, 18 Nov 2020 05:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iGo+ZN3tAXAxv3w8yNYuIIpSkiLbRMRp3Fk34AunwFo=;
        b=BXefqVtVvxsq8fHp6xdGBhXTYpb54Bw6UuyKcLv8wj57fnSkeylXM6zGlGgn05j3t5
         CzwVgEfHCpv0VmHrKnsn1hQiBF3ISHAAalBE0QqtH7vp0P7xvqUHf+nilx9dgsziY0Hi
         8/JZm7HPQb8U/LgOuydzxvPSkgO3JW3ah7TGvTkZOaGIPRVwOvLZAjDdG1BXFFngc7kD
         XEicIVtBW7TGXjlGt3pukgG7sb4njjusZ3EnZ7sLuodsB5CRbtME2+V8URBuIMTGt2y7
         JuCOyFzWX+KVRiWR07bO6j9U2tp3CIK5cJ5tePaWmTr8YfjlY6fWSeLDND0Jod8i+sn6
         m8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iGo+ZN3tAXAxv3w8yNYuIIpSkiLbRMRp3Fk34AunwFo=;
        b=kow8kiSdb8ujlVkNFaYCpV+gnEE3PlgriVLAsWTaHv0GvA33WaagbPy/oicgy8WFAF
         T+ItvWBz28lGfO6UZd3sAwznI8oFneHiLm70jDENKcfWNncAwJSLvx8OwnC1nM999SpH
         DIsoR1Cv1mZTu4rVQ2J+2EB7aTmqIMUl5e4LOfUp9SPSihmn34/ZhIKVWIm6lujs4A+H
         PwMJjrbIbX7FtUiBnys/FLtFU1ihckDD9xd5VPlfBlPEMfeD4RQcfUQIFpzDzdMKwKvx
         gAaOLUgZP5wDHMYSVF+ppUiBMxs6XmGRwoPWBnETTdd+GmAZH11XhBTbwSWTkBqRmnzQ
         ZLzQ==
X-Gm-Message-State: AOAM533QxfdOoIb2pDzQnmNbF2cS1LsUT1BVG2GiIZFrxwrUuovvKSBP
        k5H1S/sSv3hY2uhJIe9BlWc=
X-Google-Smtp-Source: ABdhPJzGkwvMghVx+eQ7qO0wtkopELk5Lccddvd1lmFjxtvj2Q2p7qXDUdyAzDKYJ6LI0ODcRg8rZw==
X-Received: by 2002:a17:906:4145:: with SMTP id l5mr23250136ejk.317.1605707911662;
        Wed, 18 Nov 2020 05:58:31 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cx6sm13721384edb.61.2020.11.18.05.58.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 05:58:31 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/7] clk: rockchip: add CLK_SET_RATE_PARENT to sclk for rk3066a i2s and uart clocks
Date:   Wed, 18 Nov 2020 14:58:16 +0100
Message-Id: <20201118135822.9582-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201118135822.9582-1-jbx6244@gmail.com>
References: <20201118135822.9582-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CLK_SET_RATE_PARENT to sclk for rk3066a i2s and uart clocks,
so that the parent COMPOSITE_FRACMUX and COMPOSITE_NOMUX
also update.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/clk/rockchip/clk-rk3188.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 730020fcc..db8c58813 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -255,19 +255,19 @@ static struct rockchip_clk_branch common_spdif_fracmux __initdata =
 			RK2928_CLKSEL_CON(5), 8, 2, MFLAGS);
 
 static struct rockchip_clk_branch common_uart0_fracmux __initdata =
-	MUX(SCLK_UART0, "sclk_uart0", mux_sclk_uart0_p, 0,
+	MUX(SCLK_UART0, "sclk_uart0", mux_sclk_uart0_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(13), 8, 2, MFLAGS);
 
 static struct rockchip_clk_branch common_uart1_fracmux __initdata =
-	MUX(SCLK_UART1, "sclk_uart1", mux_sclk_uart1_p, 0,
+	MUX(SCLK_UART1, "sclk_uart1", mux_sclk_uart1_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(14), 8, 2, MFLAGS);
 
 static struct rockchip_clk_branch common_uart2_fracmux __initdata =
-	MUX(SCLK_UART2, "sclk_uart2", mux_sclk_uart2_p, 0,
+	MUX(SCLK_UART2, "sclk_uart2", mux_sclk_uart2_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(15), 8, 2, MFLAGS);
 
 static struct rockchip_clk_branch common_uart3_fracmux __initdata =
-	MUX(SCLK_UART3, "sclk_uart3", mux_sclk_uart3_p, 0,
+	MUX(SCLK_UART3, "sclk_uart3", mux_sclk_uart3_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(16), 8, 2, MFLAGS);
 
 static struct rockchip_clk_branch common_clk_branches[] __initdata = {
@@ -408,28 +408,28 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	COMPOSITE_NOMUX(0, "uart0_pre", "uart_src", 0,
 			RK2928_CLKSEL_CON(13), 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(1), 8, GFLAGS),
-	COMPOSITE_FRACMUX(0, "uart0_frac", "uart0_pre", 0,
+	COMPOSITE_FRACMUX(0, "uart0_frac", "uart0_pre", CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(17), 0,
 			RK2928_CLKGATE_CON(1), 9, GFLAGS,
 			&common_uart0_fracmux),
 	COMPOSITE_NOMUX(0, "uart1_pre", "uart_src", 0,
 			RK2928_CLKSEL_CON(14), 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(1), 10, GFLAGS),
-	COMPOSITE_FRACMUX(0, "uart1_frac", "uart1_pre", 0,
+	COMPOSITE_FRACMUX(0, "uart1_frac", "uart1_pre", CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(18), 0,
 			RK2928_CLKGATE_CON(1), 11, GFLAGS,
 			&common_uart1_fracmux),
 	COMPOSITE_NOMUX(0, "uart2_pre", "uart_src", 0,
 			RK2928_CLKSEL_CON(15), 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(1), 12, GFLAGS),
-	COMPOSITE_FRACMUX(0, "uart2_frac", "uart2_pre", 0,
+	COMPOSITE_FRACMUX(0, "uart2_frac", "uart2_pre", CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(19), 0,
 			RK2928_CLKGATE_CON(1), 13, GFLAGS,
 			&common_uart2_fracmux),
 	COMPOSITE_NOMUX(0, "uart3_pre", "uart_src", 0,
 			RK2928_CLKSEL_CON(16), 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(1), 14, GFLAGS),
-	COMPOSITE_FRACMUX(0, "uart3_frac", "uart3_pre", 0,
+	COMPOSITE_FRACMUX(0, "uart3_frac", "uart3_pre", CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(20), 0,
 			RK2928_CLKGATE_CON(1), 15, GFLAGS,
 			&common_uart3_fracmux),
@@ -543,15 +543,15 @@ static struct clk_div_table div_aclk_cpu_t[] = {
 };
 
 static struct rockchip_clk_branch rk3066a_i2s0_fracmux __initdata =
-	MUX(SCLK_I2S0, "sclk_i2s0", mux_sclk_i2s0_p, 0,
+	MUX(SCLK_I2S0, "sclk_i2s0", mux_sclk_i2s0_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(2), 8, 2, MFLAGS);
 
 static struct rockchip_clk_branch rk3066a_i2s1_fracmux __initdata =
-	MUX(SCLK_I2S1, "sclk_i2s1", mux_sclk_i2s1_p, 0,
+	MUX(SCLK_I2S1, "sclk_i2s1", mux_sclk_i2s1_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(3), 8, 2, MFLAGS);
 
 static struct rockchip_clk_branch rk3066a_i2s2_fracmux __initdata =
-	MUX(SCLK_I2S2, "sclk_i2s2", mux_sclk_i2s2_p, 0,
+	MUX(SCLK_I2S2, "sclk_i2s2", mux_sclk_i2s2_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(4), 8, 2, MFLAGS);
 
 static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
@@ -615,21 +615,21 @@ static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
 	COMPOSITE_NOMUX(0, "i2s0_pre", "i2s_src", 0,
 			RK2928_CLKSEL_CON(2), 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(0), 7, GFLAGS),
-	COMPOSITE_FRACMUX(0, "i2s0_frac", "i2s0_pre", 0,
+	COMPOSITE_FRACMUX(0, "i2s0_frac", "i2s0_pre", CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(6), 0,
 			RK2928_CLKGATE_CON(0), 8, GFLAGS,
 			&rk3066a_i2s0_fracmux),
 	COMPOSITE_NOMUX(0, "i2s1_pre", "i2s_src", 0,
 			RK2928_CLKSEL_CON(3), 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(0), 9, GFLAGS),
-	COMPOSITE_FRACMUX(0, "i2s1_frac", "i2s1_pre", 0,
+	COMPOSITE_FRACMUX(0, "i2s1_frac", "i2s1_pre", CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(7), 0,
 			RK2928_CLKGATE_CON(0), 10, GFLAGS,
 			&rk3066a_i2s1_fracmux),
 	COMPOSITE_NOMUX(0, "i2s2_pre", "i2s_src", 0,
 			RK2928_CLKSEL_CON(4), 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(0), 11, GFLAGS),
-	COMPOSITE_FRACMUX(0, "i2s2_frac", "i2s2_pre", 0,
+	COMPOSITE_FRACMUX(0, "i2s2_frac", "i2s2_pre", CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(8), 0,
 			RK2928_CLKGATE_CON(0), 12, GFLAGS,
 			&rk3066a_i2s2_fracmux),
-- 
2.11.0

