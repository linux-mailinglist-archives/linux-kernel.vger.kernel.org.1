Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BAD2B43B4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgKPM1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbgKPM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:27:03 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A6C0613CF;
        Mon, 16 Nov 2020 04:27:01 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id t9so18503302edq.8;
        Mon, 16 Nov 2020 04:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mXd0/BioOUY4fbAfXivgHmV1JXCJNPj02bKxYT4teDw=;
        b=aF8hjcXSWh9E6HYJxpooFJWzfO1PGXseh1vu93W4ZUf9JbyYgZDV+Dtb08e2hzOLZE
         RvSkB6qzSlW4QYiDz4zAYNvvVltV9co3rCsJwUxHywMM5QWQuKrqJ+HVS5VVYUb6ZXdD
         zP4dD+VCvNyL7UPPJ44fOtS1l/Ofc7dsRTxkiTifl7vsn1VQ6+pajohv0Gw2fGIqjAEH
         c+robE9EUGVtf652RofdnwpDVJYuHIt4XsPEetOayyXMjsq/j66cEOYC0+IQNCjY+093
         wRxlJ3BPw6T7nbOQvT3CnPHTaVv7oPtGCzxEsUjb6hqxcxMwmwCgCidQVKenl05jDLfh
         yFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mXd0/BioOUY4fbAfXivgHmV1JXCJNPj02bKxYT4teDw=;
        b=VOy1DcRGsXAKsrRVddoXIfzErHIErTHJ87RD61pjQykeSKLvkOC7bUYCpkb0K/dPeB
         MGMgOdzdn2CeXbneJDHGsvsZ854MW50Qz+vDumMk3uOUDa6Vj42mEll/w3IfAQEaP6w4
         kXG0q1R3TVJ6nGvDT+yrOzsGyscSENJurToEErf/uXofg2O8G7+WHL/4oLejXhM5fxV8
         Q7RJMx4D4iQByn27suLw1k0J9lF2IXW7nzNQwlqYaeRZ+BqvWsHg+dFLoikpE3lmlBYS
         QqvycEaux8qnblUTvyBakcoVECep3YJU4VcfeDNcyX5+AW4HLtlGpIPPyyP+ZfwUwwbU
         NNXw==
X-Gm-Message-State: AOAM531BaGqlaqtLm7UdFS2FAVlWa4G5vuR5Gt6kyD6DA62Bdti+yDFK
        potXuiBZS8hHHrkOikX9aHc=
X-Google-Smtp-Source: ABdhPJx2PP7o7ipSQcri+CX6ZywaZ+1Bgit2Zrm/xG3cmUz3vjVE46tKFKxIG83Uj+s7MT1QYxBczg==
X-Received: by 2002:a05:6402:14cf:: with SMTP id f15mr15262633edx.18.1605529620686;
        Mon, 16 Nov 2020 04:27:00 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n22sm10704848edr.11.2020.11.16.04.26.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 04:27:00 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     zhangqing@rock-chips.com, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] clk: rockchip: fix i2s gate bits on rk3066 and rk3188
Date:   Mon, 16 Nov 2020 13:26:51 +0100
Message-Id: <20201116122651.4215-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201116122651.4215-1-jbx6244@gmail.com>
References: <20201116122651.4215-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip PX2/RK3066 uses these bits in CRU_CLKGATE7_CON:

hclk_i2s_8ch_gate_en  bit 4 (dtsi: i2s0)
hclk_i2s0_2ch_gate_en bit 2 (dtsi: i2s1)
hclk_i2s1_2ch_gate_en bit 3 (dtsi: i2s2)

The Rockchip PX3/RK3188 uses this bit in CRU_CLKGATE7_CON:

hclk_i2s_2ch_gate_en  bit 2 (dtsi: i2s0)

The bits got somehow mixed up in the clk-rk3188.c file.
The labels in the dtsi files are not suppose to change.
The sclk and hclk names should match for
"trace_event=clk_disable,clk_enable",
so remove GATE HCLK_I2S0 from the common clock tree and
fix the bits in the rk3066 and rk3188 clock tree.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed V3:
  reword
---
 drivers/clk/rockchip/clk-rk3188.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 81ecf348e..362d068a4 100644
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

