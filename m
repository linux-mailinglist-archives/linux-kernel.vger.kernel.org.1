Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A092D64D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393058AbgLJSYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392991AbgLJSXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:23:44 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B791CC061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:23:03 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q22so4876275pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlYQYIjOvFUGV9u7dpq2U2XXQsFEp9E3/SIg8yeU14c=;
        b=lfAUoVooAJ+yZelRCF1lgwM6D/zfU4rspDyNoX6xa0cXBLmS4Q8uHwzVgpD/XO/YHX
         NI6xvXysReS7dVoo+JAiKd3wLVPfpN3fuXKfTksDsw7hN50MLKpt1RDN/PN0mVLvlFN1
         u4ciX4vfPzlIihO7TcjIgeZltITIHXyKqb+so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlYQYIjOvFUGV9u7dpq2U2XXQsFEp9E3/SIg8yeU14c=;
        b=lS5gaWnRaWD4PvG2miAg6cBl+sMeqNSrd4z8+2u2389FNB8/N6dv6kwrWWLto6MHY8
         d/9WEUjaZcoLMgd4Dlp9vfJ6keauc9NSVnLLEqAtgfBNMTEYhz5vjS+tM8J57spvaf63
         R0P9mPOWd38Bl+1h6lSf8PUSrEDueTY1i0+FqJeeX4hENhjg/xDdNbDAcgGJjL/HhUuo
         cWePX9bsmGe1n5G0Te8fYqk1gUrcWvb8ig8Qy1wCpIk5WY16XASURSy7a/loDBrTib8U
         q/ckldy7Ir0IVvIeJudZL/CErVFNH7xUG8WVVMiLFmjruqNu13W5tMSdsuzcGUKWxRez
         nYQw==
X-Gm-Message-State: AOAM533FptZcWqe84mh+DjVVOZHfigcHfqQUlKq1lFRataXcojtPxkpf
        N1TOb6mSlXZt56z47sxWZJnYeCm8LcdwVw==
X-Google-Smtp-Source: ABdhPJwgG5kTouSLHoe+Vwf59Jl4L2D9kVPzpdismtc1CdZVXS5GKmSp1sJsBJe70lDLPVNI7C9smA==
X-Received: by 2002:a65:490c:: with SMTP id p12mr7783319pgs.98.1607624583260;
        Thu, 10 Dec 2020 10:23:03 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id a10sm6898376pfi.168.2020.12.10.10.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 10:23:02 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Taniya Das <tdas@codeaurora.org>, vbadigan@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: qcom: gcc-sc7180: Use floor ops for sdcc clks
Date:   Thu, 10 Dec 2020 10:22:38 -0800
Message-Id: <20201210102234.1.I096779f219625148900fc984dd0084ed1ba87c7f@changeid>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would repeat the same commit message that was in commit 5e4b7e82d497
("clk: qcom: gcc-sdm845: Use floor ops for sdcc clks") but it seems
silly to do so when you could just go read that commit.

NOTE: this is actually extra terrible because we're missing the 50 MHz
rate in the table (see the next patch AKA ("clk: qcom: gcc-sc7180: Add
50 MHz clock rate for SDC2")).  That means then when you run an older
SD card it'll try to clock it at 100 MHz when it's only specced to run
at 50 MHz max.  As you can probably guess that doesn't work super
well.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Fixes: 17269568f726 ("clk: qcom: Add Global Clock controller (GCC) driver for SC7180")
---
Taniya: can you please update whatever process is used to generate
these clock files to use floor for SD card clocks.  I hope you can
also scour through these files looking for similar problems on other
SoCs and submit patches for them.

 drivers/clk/qcom/gcc-sc7180.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index 68d8f7aaf64e..b080739ab0c3 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -642,7 +642,7 @@ static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
 		.name = "gcc_sdcc1_ice_core_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -666,7 +666,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_5,
 		.num_parents = 5,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
-- 
2.29.2.576.ga3fc446d84-goog

