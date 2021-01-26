Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9240E303E60
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404210AbhAZNQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403854AbhAZMrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:47:24 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CCEC0698C5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:48 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c127so2614880wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HHkd09sGQoktrv+rkNaMJyxZ3/BBMappx4i1qFyA51o=;
        b=TnYbFNbQymHArsvv6uMgb5tO3NV5ZnbJxvZzMuj+1YlGF4WEMMgKVeViAGi6q+qoFc
         rYEHRkr8wrhzIEJ0KYFizjHBZBjPUmAsSX6B5wGaskQglrH5c5UrsbeGazcmS4NCeKZN
         TSs37HB8TICrWogbEReV4KE2rUwYlSEIGChJJpEOQRJ14zYlsqmuH2ASFKwrrazTfWr8
         VILbJQ0gzu9SJzW4ozcjvP5X86pRPWJ3yrCL9TdRNXG/eX+lfARbzE0B34srRPyLEGZI
         hpdL8SOAnlS8c9NJf96iFNX4CEopinC21YSoHPMIAmS1K3vJl9xlXnezvOkzEHpxNqRb
         N4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHkd09sGQoktrv+rkNaMJyxZ3/BBMappx4i1qFyA51o=;
        b=OfW/91LwIvLgimiDb9NExTJRtyjpGTy46U7WBtTJamJAWLIcsUGThaOrXe+qQeuJK+
         hqUIMIQGpBraiBg5Sq+Vd+qwTJ7qe5bOxwN5zXzUs9uGm/QNrXBzPhx74lYcd8+6bqzl
         aQuj1kZUbzE9fOjCxg6uA3V7QhNbNr2KzlvVN/IMzZ5h1DpY0z8z8nDy1L15Twyrmveq
         nsxrtRKpX+VshwkNcjbxOHCmlvqx+RMzzWkGo3cjFdM2qvHOM6quKWPhVa4HovrAOnJs
         rhH6D3TA28LNDMyj2MG/l6NbqRrQevF/cjUkkFoV4mCRNEScP4UfxSixIbodH4dGSZMu
         QEWw==
X-Gm-Message-State: AOAM533+6M6BZmtBXPII5QCwVKmyfsUNDgI6cHBu14OQBjAB4MwjWw8h
        JCh8Zoa4HUrqKnN7EyXdQSoW2A==
X-Google-Smtp-Source: ABdhPJznDZLr3xkcd36SC/SloQ9HjiUzc0tkJlFOigVXQd5LVJLP45/rs7+AF+735jAMGyeQsWkaDQ==
X-Received: by 2002:a1c:9648:: with SMTP id y69mr4463242wmd.40.1611665147239;
        Tue, 26 Jan 2021 04:45:47 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:45:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Richard Woodruff <r-woodruff2@ti.com>,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 02/21] clk: ti: clkt_dpll: Fix some kernel-doc misdemeanours
Date:   Tue, 26 Jan 2021 12:45:21 +0000
Message-Id: <20210126124540.3320214-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124540.3320214-1-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/ti/clkt_dpll.c:284: warning: Function parameter or member 'hw' not described in 'omap2_dpll_round_rate'
 drivers/clk/ti/clkt_dpll.c:284: warning: Function parameter or member 'parent_rate' not described in 'omap2_dpll_round_rate'
 drivers/clk/ti/clkt_dpll.c:284: warning: Excess function parameter 'clk' description in 'omap2_dpll_round_rate'

Cc: Tero Kristo <kristo@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/ti/clkt_dpll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clkt_dpll.c b/drivers/clk/ti/clkt_dpll.c
index 87ece6cd4226b..dfaa4d1f0b64b 100644
--- a/drivers/clk/ti/clkt_dpll.c
+++ b/drivers/clk/ti/clkt_dpll.c
@@ -269,8 +269,9 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
 
 /**
  * omap2_dpll_round_rate - round a target rate for an OMAP DPLL
- * @clk: struct clk * for a DPLL
+ * @hw: struct clk_hw containing the struct clk * for a DPLL
  * @target_rate: desired DPLL clock rate
+ * @parent_rate: parent's DPLL clock rate
  *
  * Given a DPLL and a desired target rate, round the target rate to a
  * possible, programmable rate for this DPLL.  Attempts to select the
-- 
2.25.1

