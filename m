Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96632D64D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393048AbgLJSYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393034AbgLJSYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:24:03 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193EAC0617B0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:23:05 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id o5so4968024pgm.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V8NX24ubqKWwH6xcjmH3A9pX91w8R968uRF5N8yhVWE=;
        b=X1NfbcczKoiYmOYzwW198suAQMOFZglPRX7eTrZfPsVcAbxctN96ddIgRSk+VptxUW
         rm/bjqHurs7HwEsywnBWkhhSNVsem3OCFjT4bN7/GOjLVJdoa4XEVqi5IlLd1L7CecD9
         hEdbHq99Ys+fdrvB2QgmOmW30beJfWKf26cRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V8NX24ubqKWwH6xcjmH3A9pX91w8R968uRF5N8yhVWE=;
        b=fbTJndkuyzOJ07DvDvsRzn5ShcLIwRgipUOCBB+2vk2QDE3UY3DKLRMFIeOlh/jCyG
         Azssuox+kMo4zK8eR971eS7xoIkX7iPZBbGspuqnfPHkvGNkPfiRl8L4uX2l9+khLN3t
         IqF1Lr6ZHV+NWHR+OEAm9/lzLdJMIRPD4dQ49ruVJAV0QLETrCfAy6sJXgwLZ7Xjyb9t
         Q5DQ0Lx/VdVopdDrPgdPXMbvKR20FWjE0s6RzOPleTDlvCNh7MOl54wRqMZUtDiMs/GM
         0AdlERMrbRZkcViORvmILUYbDC2/aulfcc4cW3/51hyrwnpTDl8t1s7jZ9+sElovgU7L
         nP9A==
X-Gm-Message-State: AOAM531l2sJuks4LpshlY9hWzZTMH203dzsf2mEjk9Ar9PDVCeWlnZE8
        hllYn0qm7hB0QjztK6X6Weh1jQ==
X-Google-Smtp-Source: ABdhPJzc1Cqx+KcUzhvwKx11PppWAktpydpvH6zqRuG+56ah0c3TI6CMKpRwNO7UMWe+aI5oW56wPg==
X-Received: by 2002:a17:90a:f412:: with SMTP id ch18mr9070061pjb.69.1607624584641;
        Thu, 10 Dec 2020 10:23:04 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id a10sm6898376pfi.168.2020.12.10.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 10:23:04 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Taniya Das <tdas@codeaurora.org>, vbadigan@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: qcom: gcc-sc7180: Add 50 MHz clock rate for SDC2
Date:   Thu, 10 Dec 2020 10:22:39 -0800
Message-Id: <20201210102234.2.I26dcc0cee374f5571d9929c9985f463773167e68@changeid>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210102234.1.I096779f219625148900fc984dd0084ed1ba87c7f@changeid>
References: <20201210102234.1.I096779f219625148900fc984dd0084ed1ba87c7f@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

50 MHz is an incredibly common clock rate for SD cards to run at.
It's "high speed" mode in SD (not very fast these days, but it used to
be) or:
  #define HIGH_SPEED_MAX_DTR	50000000

If we don't support this then older "high speed" cards can only run at
25 MHz or at half their normal speed.  There doesn't seem to be any
reason to skip this clock rate, so add it.

Fixes: 17269568f726 ("clk: qcom: Add Global Clock controller (GCC) driver for SC7180")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/clk/qcom/gcc-sc7180.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index b080739ab0c3..d82d725ac231 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -651,6 +651,7 @@ static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
 	F(9600000, P_BI_TCXO, 2, 0, 0),
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(25000000, P_GPLL0_OUT_EVEN, 12, 0, 0),
+	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
 	F(100000000, P_GPLL0_OUT_EVEN, 3, 0, 0),
 	F(202000000, P_GPLL7_OUT_MAIN, 4, 0, 0),
 	{ }
-- 
2.29.2.576.ga3fc446d84-goog

