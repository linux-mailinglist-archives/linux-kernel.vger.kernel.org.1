Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B63A2E9601
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbhADN34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADN3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:29:54 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F606C061795;
        Mon,  4 Jan 2021 05:29:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n16so7707281wmc.0;
        Mon, 04 Jan 2021 05:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N0ICd7gjWpI+u44o7fGulyQewlvcHmYQ4mPyDcl0N/Y=;
        b=KYr5DfgA5liPJkd48Mrj1k+lb8ObI4YW8MoTs/LZJSQY1rQkG5bQuKaPlkHHq/2WdC
         Uz4QdeAVD43drFI2JM32/IE/V0IgPHiI0yI7H5Nnd2cUk3LiLtB3kYk+dAMNZVErqt0Z
         WIsDVjV1229ydaJNNxe27vSHnLa6SdUW38jlpTTBm+ElH+mhieunnn3xO5M5oiM0zppP
         2fDAYZZPc33b5kH5CbUew073VctIkaL3zwyKY5z00NXmacvlWXkmqSmJAeiIlpOTrTtE
         Io3rotHVY1oDq0/Bqw7KzUg48kRlw3ToWBgS5mInL0mTVTfsXw9VhyGPdxEqbjvSPBlb
         gecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N0ICd7gjWpI+u44o7fGulyQewlvcHmYQ4mPyDcl0N/Y=;
        b=sBbTqJjSrLGT40eOAIWOIKdpZZ44MYWVQV6h35bNMCWU2K4dZY6vbqoObvZxL3ra6e
         XLskUrwi7Nm5sKLO7Oo8wrzqTejgq/WDa66h/vkca4Hsemh74EiM523oOJhB8pgZmKSL
         9lkFPQ6IqC2HaR04jEmhBqhk1IFPkhdvxAp5VwXCynQ2H8t3xagBqYgmlWiTbJBlykok
         3G0keKpYHBrSVwGHSwQXW6oKIBXiGQMC/FhWdyXyxoyuq51ynSPkRwbGsXHKNHhLmOE/
         zgK8tUjHltCUXR+1D0Vsb3YSVKkc/5Y6i94y4zHfQ0asp91gQmUzhqU9a35IRWskU29P
         NFIA==
X-Gm-Message-State: AOAM532sZJ+QjDubQ88cOx4xPepGzTvgfamxsTuk5qlU/4vMaO8UiCUd
        yM3DISKWrDwO2cBUTUk5mWY=
X-Google-Smtp-Source: ABdhPJywuE2u9mR3LAhtBrTJHq+1D8WBmP3LHVUQJhGBFbugfODpsKR6wzD1kLMNzPlpsdtU8xmBMw==
X-Received: by 2002:a1c:ba07:: with SMTP id k7mr27284102wmf.34.1609766952936;
        Mon, 04 Jan 2021 05:29:12 -0800 (PST)
Received: from localhost.localdomain (p200300f13724fd00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3724:fd00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c4sm99916521wrw.72.2021.01.04.05.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 05:29:12 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/5] clk: meson: meson8b: don't use MPLL1 as parent of vclk_in_sel
Date:   Mon,  4 Jan 2021 14:28:02 +0100
Message-Id: <20210104132806.720558-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210104132806.720558-1-martin.blumenstingl@googlemail.com>
References: <20210104132806.720558-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPLL1 is needed for audio output. Drop it from the vclk_in_sel parent
list so we only use the (mutable) vid_pll_final_div tree or one of the
(fixed) FCLK_DIV{3,4,5} clocks.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index a844d35b553a..f8bd211db720 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1154,6 +1154,10 @@ static struct clk_regmap meson8b_vid_pll_final_div = {
 	},
 };
 
+/*
+ * parent 0x6 is meson8b_mpll1 but we don't use it here because it's reserved
+ * for the audio outputs.
+ */
 static const struct clk_hw *meson8b_vclk_mux_parent_hws[] = {
 	&meson8b_vid_pll_final_div.hw,
 	&meson8b_fclk_div4.hw,
@@ -1161,7 +1165,6 @@ static const struct clk_hw *meson8b_vclk_mux_parent_hws[] = {
 	&meson8b_fclk_div5.hw,
 	&meson8b_vid_pll_final_div.hw,
 	&meson8b_fclk_div7.hw,
-	&meson8b_mpll1.hw,
 };
 
 static struct clk_regmap meson8b_vclk_in_sel = {
-- 
2.30.0

