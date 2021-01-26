Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE86303DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392652AbhAZNBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391990AbhAZMtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:49:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA92C0698E1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:01 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m187so2342939wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4mll2lpwENE608kX1kOhep+FnuspDxHBBTIWjYWHVv4=;
        b=pN4lfLmmVBgLX1q2BKk4RyuM8nfGi0iSK2p5oFzqbwR48oc2/k0GoyukN3ekRynO06
         FKaAaAsWyotTSplcMwQPMAZVfJizyGQiOJBMk0yYcAymhgu9N2ZSbUSh6qjy288ou0pc
         HqtayVh1cyMBIbzfiBYPHmvVjr9IdO/PtWWdjNpPkVFE2CynLfawGQEBle+vluHgUEPi
         XIkSyDlNFtRmGLri4EMRNLpm0jF2EqbuLb6EDwAkGFdlQ5TAMlRTr4lVHYp6w+0UpvW3
         IMv+nTm9wowh7LVp4WikScVxnNSItGlVg6V+ACms+OKjBP2oRnEDQeXLGZ596/KJomrY
         KMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4mll2lpwENE608kX1kOhep+FnuspDxHBBTIWjYWHVv4=;
        b=MXm/RPwC7OaPgHFePm0rygI6/eWqrScReiOQr2UoQ3LcaDHFi1u47MjdIR7hfxr4vg
         fbCa475K7i6hhuoQEFCc7p73SC5SPvp/KyV6RmQTAzuvlAH4C2KY2+2+b/TyhzgN5tUI
         xSCe4n9Y/0SGBFmCwH/G+0KKTO6GUJF4FdMecprY9CvhRYamEF89Zo+seGYo1PT9g1aB
         KtzxL4pRw4aZzzo9AEvL8tlJAcItxQym1EeIu9er/Mj2nWi1IOZk/SqHOzHHEkjzD4aS
         dCaOKrJhSlc5HEqVKJMvb9wleOb5yHWrFpPTWT8hM5H9GOqckq+QCc6chD2uYfI9ZiV8
         KFbA==
X-Gm-Message-State: AOAM530subIA45Cl0JehubBoM6EXudM6KWjujZwwIF1uGUPoFrixBIBK
        CWP9SWAYqHaA4WibxIEtsaahYA==
X-Google-Smtp-Source: ABdhPJwsLKoq02G2opNkx2KyZBjwCJrT1QWUMlzjgyZlIH/qv0W5suRHKqypiyBgXWhP7zNqj62Grg==
X-Received: by 2002:a05:600c:1911:: with SMTP id j17mr4552481wmq.63.1611665159968;
        Tue, 26 Jan 2021 04:45:59 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:45:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 13/21] clk: qcom: gcc-ipq4019: Remove unused variable 'ret'
Date:   Tue, 26 Jan 2021 12:45:32 +0000
Message-Id: <20210126124540.3320214-14-lee.jones@linaro.org>
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

 drivers/clk/qcom/gcc-ipq4019.c: In function ‘clk_cpu_div_set_rate’:
 drivers/clk/qcom/gcc-ipq4019.c:1279:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/qcom/gcc-ipq4019.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq4019.c b/drivers/clk/qcom/gcc-ipq4019.c
index ef5137fd50f3f..8abad4032de71 100644
--- a/drivers/clk/qcom/gcc-ipq4019.c
+++ b/drivers/clk/qcom/gcc-ipq4019.c
@@ -1276,16 +1276,15 @@ static int clk_cpu_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_fepll *pll = to_clk_fepll(hw);
 	const struct freq_tbl *f;
 	u32 mask;
-	int ret;
 
 	f = qcom_find_freq(pll->freq_tbl, rate);
 	if (!f)
 		return -EINVAL;
 
 	mask = (BIT(pll->cdiv.width) - 1) << pll->cdiv.shift;
-	ret = regmap_update_bits(pll->cdiv.clkr.regmap,
-				 pll->cdiv.reg, mask,
-				 f->pre_div << pll->cdiv.shift);
+	regmap_update_bits(pll->cdiv.clkr.regmap,
+			   pll->cdiv.reg, mask,
+			   f->pre_div << pll->cdiv.shift);
 	/*
 	 * There is no status bit which can be checked for successful CPU
 	 * divider update operation so using delay for the same.
-- 
2.25.1

