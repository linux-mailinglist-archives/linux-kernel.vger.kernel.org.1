Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440B22E9603
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbhADN36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbhADN34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:29:56 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C01C061798;
        Mon,  4 Jan 2021 05:29:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k10so18468321wmi.3;
        Mon, 04 Jan 2021 05:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yU3i8q3LKfNlAY9hUH3bx+fqfznLSPg6/fe82VNqq7E=;
        b=AMtwZS2an8TZOKdgEL4gqeYjLriuWPqWRgYbrgrbbN40Xtqp44B8JLfh21SaF1Lvo0
         4Mhpet6kOwKrWQy/Qg7Eo6+hfr9ySEzMcWNp4IXPI3oiuWxKEtqYqxlbs+PpEdaZkxPR
         7e2f9JwBINuQ7UHZKKsDcMN9NNi/UPfm2aYqcut1mwGu79RYC013VAPScPi9Z+h7iDhF
         /5YW/WsJtc4efxS6mVyxN+IWNJvc5xl3fGsda90wiG9IG9n/xDfNd+ZB/WPtrNCtywxT
         EE3njDXCQuXdY9X2Y2Xi/iWy3q0iPT0e734llu2PhPOrG7M1cm2mPFVnwORl7gkD+0+3
         kiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yU3i8q3LKfNlAY9hUH3bx+fqfznLSPg6/fe82VNqq7E=;
        b=bE9VXxHZxZ0xnWwvHbvfnNQvo+Tb+2+sN0FnF5Gzop8+beCovbiGpxyjEzUSc7QOt0
         FC2JVBN+sd1HxnuzKNAaob1gFiSFMMV+uKVQkWiPgdSEpPSSwhdwTzE5SOqdHNZsE/Cx
         VscIOZI+RPVvPWvRWKN3kJMtWTohbV9eB0Nt2BuvvBlgTeeMFYD2fo8yMzwGJW7lqd3J
         MRTGB6ClAvkmLwBJVZJ7xQah+cHhIcZcrtTZzPGGvvLUYrLH7Ox0jY0Xf0Lo6kD/L8Ko
         C3bheX/iGUrMXsispkqLFUjFnsRRUnSsNhkLAAq6FsV0JcdqXfaOMf60WN9hibLFXjap
         ZQUg==
X-Gm-Message-State: AOAM533u+xZxVTu+BgH+xryi4Yo+XmCZldPcPX0HzaRV7Ux7mVxnnqfp
        D9qW/bcs83HW1GX7qaGPcVQbZT14Qo8=
X-Google-Smtp-Source: ABdhPJyVpXksZHxu5YZkIIRBN6VRNV0RdPiMJnbeiaBdMGsMHagAhSvke15twbTrOcTpAUNR0RhXfg==
X-Received: by 2002:a1c:741a:: with SMTP id p26mr27847111wmc.47.1609766954825;
        Mon, 04 Jan 2021 05:29:14 -0800 (PST)
Received: from localhost.localdomain (p200300f13724fd00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3724:fd00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c4sm99916521wrw.72.2021.01.04.05.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 05:29:14 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/5] clk: meson: meson8b: add the video clock divider tables
Date:   Mon,  4 Jan 2021 14:28:04 +0100
Message-Id: <20210104132806.720558-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210104132806.720558-1-martin.blumenstingl@googlemail.com>
References: <20210104132806.720558-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all known clock dividers from Amlogic's 3.10 vendor kernel. If not
stated otherwise the values given in the tables are the only ones used
by the 3.10 vendor kernel even if the hardware is capable of other
dividers as well:
- vid_pll_pre_div can divide by 5 or 6 and if u-boot did not initialize
  this clock then it divides by 1 by default (only 5 and 6 are used at
  runtime by the vendor kernel though)
- vid_pll_post_div is either 1 or 2
- vid_pll_final_div is either 1, 2 or 4

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 16ab595ab1a4..1ae771bac4a5 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1084,11 +1084,19 @@ static struct clk_regmap meson8b_vid_pll_in_en = {
 	},
 };
 
+static const struct clk_div_table vid_pll_pre_div_table[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 4, .div = 5 },
+	{ .val = 5, .div = 6 },
+	{ /* sentinel */ }
+};
+
 static struct clk_regmap meson8b_vid_pll_pre_div = {
 	.data = &(struct clk_regmap_div_data){
 		.offset =  HHI_VID_DIVIDER_CNTL,
 		.shift = 4,
 		.width = 3,
+		.table = vid_pll_pre_div_table,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vid_pll_pre_div",
@@ -1101,11 +1109,18 @@ static struct clk_regmap meson8b_vid_pll_pre_div = {
 	},
 };
 
+static const struct clk_div_table vid_pll_post_div_table[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ /* sentinel */ }
+};
+
 static struct clk_regmap meson8b_vid_pll_post_div = {
 	.data = &(struct clk_regmap_div_data){
 		.offset =  HHI_VID_DIVIDER_CNTL,
 		.shift = 12,
 		.width = 3,
+		.table = vid_pll_post_div_table,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vid_pll_post_div",
@@ -1137,11 +1152,19 @@ static struct clk_regmap meson8b_vid_pll = {
 	},
 };
 
+static const struct clk_div_table meson8b_vid_pll_final_div_table[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 1, .div = 2 },
+	{ .val = 3, .div = 4 },
+	{ /* sentinel */ }
+};
+
 static struct clk_regmap meson8b_vid_pll_final_div = {
 	.data = &(struct clk_regmap_div_data){
 		.offset =  HHI_VID_CLK_DIV,
 		.shift = 0,
 		.width = 8,
+		.table = meson8b_vid_pll_final_div_table,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vid_pll_final_div",
-- 
2.30.0

