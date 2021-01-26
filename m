Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9452303E39
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391959AbhAZNLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391801AbhAZMse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:48:34 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24CFC0698D8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m13so1876364wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iORMEqJhCnrh6wIXXy7N9zvOdfWOGFh+mnFrMk+Wc4I=;
        b=Ut1+hsKMp53ICFgNhpIw0ZooAhqTLBGxRB1GLTU+ou42L9Dcz2FMt2o95jvhCa5CJf
         ZdlD9DBP1nU2IMrEQ9ly3HLM8tv74yCFWf3FpjdMVG0AGTNgKqPii/2dhd0ZSTMWHSke
         SfKwvE+l7fcjMACW9iCx/76oeGNAriPw3VvxzsJlySd9/zOTfQUIsd5T5jPfqnf+CfEn
         PEdLuEobbG2jPX0Gf/vBfIPoyJk2F6FLkDxVjXkK5SOztcfDLiR2N+b/QRpWjYsMV3c2
         o3wVGKiDJsO/jHItbpGtc7Eet8TetxgNijbinf81a/1UNccJcvd1b63IVx6aw38fnnvk
         54kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iORMEqJhCnrh6wIXXy7N9zvOdfWOGFh+mnFrMk+Wc4I=;
        b=q0IOUCbLkcMxXau3rm+cno+eFDFpN8mbho4Gz8YiDeDkPWzjgFuqdxlndHzhZYENJC
         qxCofKYWwkpYM3FcMpUZhNcdvSC12/FwuAD7aRF6yrIt6evEsDDpuQtf8izvYtpThaqT
         eu123gqZTTovzqKDgwbYRNgv6On2shApW1lMC6sdQD+8aIGc5YYcfEPcYyi5esO7JwHh
         5QJJNiNeYPRxOp/WXS/Q1/1D+ylvvcVcANTuBPqQt0Z+cqxRTfIUJZjEZIIoKPt2Dhs1
         ljWHBtgiB6zi+jplD1GIdaBRLHXx954LXV976OOzjgyC+dg23Rtfrkz+Vrbi2SkFtF05
         29jw==
X-Gm-Message-State: AOAM5320WiRVY8ALitvgyw5MWZzIAWXn3szcll89y5w5h3UHyyH3RcD+
        hDSaPCmxkmceg27ByyTpGf2w3A==
X-Google-Smtp-Source: ABdhPJw2nx2B0oh6rm7aHoz4WYg84KTipml2Niimp8U30RwYdhTXFbsI0bCANZV1kpnLUvqsibBRAw==
X-Received: by 2002:a5d:6c6b:: with SMTP id r11mr5998536wrz.38.1611665156576;
        Tue, 26 Jan 2021 04:45:56 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:45:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 10/21] clk: ti: dpll44xx: Fix some potential doc-rot
Date:   Tue, 26 Jan 2021 12:45:29 +0000
Message-Id: <20210126124540.3320214-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124540.3320214-1-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/ti/dpll44xx.c:114: warning: Function parameter or member 'hw' not described in 'omap4_dpll_regm4xen_recalc'
 drivers/clk/ti/dpll44xx.c:114: warning: Function parameter or member 'parent_rate' not described in 'omap4_dpll_regm4xen_recalc'
 drivers/clk/ti/dpll44xx.c:114: warning: Excess function parameter 'clk' description in 'omap4_dpll_regm4xen_recalc'
 drivers/clk/ti/dpll44xx.c:150: warning: Function parameter or member 'hw' not described in 'omap4_dpll_regm4xen_round_rate'
 drivers/clk/ti/dpll44xx.c:150: warning: Function parameter or member 'parent_rate' not described in 'omap4_dpll_regm4xen_round_rate'
 drivers/clk/ti/dpll44xx.c:150: warning: Excess function parameter 'clk' description in 'omap4_dpll_regm4xen_round_rate'

Cc: Tero Kristo <kristo@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-omap@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/ti/dpll44xx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/dpll44xx.c b/drivers/clk/ti/dpll44xx.c
index 89c3ed1a24b82..3fc2cab69a3fe 100644
--- a/drivers/clk/ti/dpll44xx.c
+++ b/drivers/clk/ti/dpll44xx.c
@@ -102,7 +102,8 @@ static void omap4_dpll_lpmode_recalc(struct dpll_data *dd)
 
 /**
  * omap4_dpll_regm4xen_recalc - compute DPLL rate, considering REGM4XEN bit
- * @clk: struct clk * of the DPLL to compute the rate for
+ * @hw: pointer to the clock to compute the rate for
+ * @parent_rate: clock rate of the DPLL parent
  *
  * Compute the output rate for the OMAP4 DPLL represented by @clk.
  * Takes the REGM4XEN bit into consideration, which is needed for the
@@ -134,8 +135,9 @@ unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 
 /**
  * omap4_dpll_regm4xen_round_rate - round DPLL rate, considering REGM4XEN bit
- * @clk: struct clk * of the DPLL to round a rate for
+ * @hw: struct hw_clk containing the struct clk * of the DPLL to round a rate for
  * @target_rate: the desired rate of the DPLL
+ * @parent_rate: clock rate of the DPLL parent
  *
  * Compute the rate that would be programmed into the DPLL hardware
  * for @clk if set_rate() were to be provided with the rate
-- 
2.25.1

