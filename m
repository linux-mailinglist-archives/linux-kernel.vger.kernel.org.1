Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D174C303E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392388AbhAZNJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403942AbhAZMsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:48:46 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABE3C03E934
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:04 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v15so16303510wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vsa1KLPM2HfEp5vPRGS+UCgmT+VY3fPWtM+ipeYcvaE=;
        b=ubNNa5o9m+gajTa5oKlGyu7B8gwi4nKoh16thJTW4WeFwRg1FKFeybQ9F+rIJulvaq
         EBfVO029Q4zaQwtL72rs90nuQLE7qUC254lKleHwmU2gYBcRoNvPjCCmN809zdwh/cYg
         nuTuk7O6VJ5r1Aectu/nUjCx7mj5cP2Av5If4PjQxp0iG/CE6S9ZF1zyADLrz97pGBhe
         8ogTNVz3DObwZ44MF+xEI5iPC8MwLjcDi2wxCQbsL5y49kSP2i9UWsjJCU5WqqspQVfL
         1h5+sY7XSdE72Mk4ujGNvdlCQBrssRRUo4ciOaaqWZABEL4HNRxtizPvRLPPQJgfJUo1
         CNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vsa1KLPM2HfEp5vPRGS+UCgmT+VY3fPWtM+ipeYcvaE=;
        b=ECggjSyALJcbGffRYTookSHJH35aalnqAZnQ18cgLgvm3EOMj7rvgpv4ucJ/zPss2U
         e4dks/WWm9LhRTZdrg+Ck3I/Zri+4USFVIecYsTSEKiU7LCbigG9+7/BNmzpnqpvIgIZ
         WhlF6EoTqyIefBArT0uldA2YED6np8KZWT1g4qUqutjbTDKQyisoNZwyVfKn3Q85TfxW
         5izAKJQiI6sq1vDnzz8F/eRkVYCAnD+/ZpByb+8Db7ubgTK+EArrBssp6h/zsTjhExWH
         pxnxLXquyMi+Bsm7oa4z+f3N5r9XPi/kVdqT9rdpQqpjzt9ncGlBNQqTwe9AgsB7B0ZI
         LLIw==
X-Gm-Message-State: AOAM530PaMAuXMxJyIObesxAC53kGDeP4IuqBVbz+QV2c7IcwZE2lrOb
        cEnrg0dRYsW4Al/lL3dydmXuhg==
X-Google-Smtp-Source: ABdhPJw96PjK5RdN98v/EC7iTHJqEnR7IM/3cvwe4dKecgDyNq/XlXgX/iw8xfudPIuyHSNiwCkb1Q==
X-Received: by 2002:adf:ecd2:: with SMTP id s18mr3963512wro.311.1611665163634;
        Tue, 26 Jan 2021 04:46:03 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:46:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 16/21] clk: qcom: mmcc-msm8974: Remove unused static const tables 'mmcc_xo_mmpll0_1_2_gpll0{map}'
Date:   Tue, 26 Jan 2021 12:45:35 +0000
Message-Id: <20210126124540.3320214-17-lee.jones@linaro.org>
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

 drivers/clk/qcom/mmcc-msm8974.c:85:27: warning: ‘mmcc_xo_mmpll0_1_2_gpll0’ defined but not used [-Wunused-const-variable=]
 drivers/clk/qcom/mmcc-msm8974.c:77:32: warning: ‘mmcc_xo_mmpll0_1_2_gpll0_map’ defined but not used [-Wunused-const-variable=]

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/qcom/mmcc-msm8974.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index 015426262d080..a1552b6771bc6 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -74,22 +74,6 @@ static const char * const mmcc_xo_mmpll0_dsi_hdmi_gpll0[] = {
 	"dsi1pll",
 };
 
-static const struct parent_map mmcc_xo_mmpll0_1_2_gpll0_map[] = {
-	{ P_XO, 0 },
-	{ P_MMPLL0, 1 },
-	{ P_MMPLL1, 2 },
-	{ P_GPLL0, 5 },
-	{ P_MMPLL2, 3 }
-};
-
-static const char * const mmcc_xo_mmpll0_1_2_gpll0[] = {
-	"xo",
-	"mmpll0_vote",
-	"mmpll1_vote",
-	"mmss_gpll0_vote",
-	"mmpll2",
-};
-
 static const struct parent_map mmcc_xo_mmpll0_1_3_gpll0_map[] = {
 	{ P_XO, 0 },
 	{ P_MMPLL0, 1 },
-- 
2.25.1

