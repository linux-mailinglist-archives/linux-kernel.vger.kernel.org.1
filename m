Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC8C2E9607
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbhADNaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbhADNaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:30:05 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D9AC06179A;
        Mon,  4 Jan 2021 05:29:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v14so18435993wml.1;
        Mon, 04 Jan 2021 05:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eG1xGDdg+wVn6kBQHz9xXAfAxIcsHz4S2Cf7VpGA6MY=;
        b=JwU/JaI2mt7vyQnZwF1uRoiSIij1S0clOARve6g/26V0ruwEIIWim3n0HKxM6zL5Hq
         5yg1T3X0RxdZpIdAnegcX9Wkywc64fJEo0oa8aVxPGIwNNywPfi+9ANJE5EL0mXG7tZ+
         jLS83lpdEGGstdDWN6VwMMCPpUORmahsP4SQThK7MrcVMVC0tKQ7xIx//Kn1Gatr26X5
         qMOcEIEH/bRhyOZqiWdXOaNcOhrJ24Ewq+elnXai0XbONk8gdlWNdhzDzveAyApQJIdM
         IObhsKQE4yeGMHOFJlLVLZ2nqo5bz82hjYXeRbUUfZrppCvF6f5XYs9jNC/HDzjvP3x1
         NFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eG1xGDdg+wVn6kBQHz9xXAfAxIcsHz4S2Cf7VpGA6MY=;
        b=ZfDibuPj0hj2iQ9FjLCPar6AMFGWOoUUnI+7Efsn3JFjjQ+LZo11cVlLVVW0u389Zv
         NSNuI++36jnf22EX3kU5sVyE97Z+w4CloDjUwoxNLhek5E+NjZZusPYZSYr3x4tgyL1V
         OqaxOhzNhaFkFp4OEFH/ADaYQbKCp5SpH5WuN6Iwbro/PrJHftAZwv2LphFSHpsGAogU
         scjRhgdHvlDd4OAKi1YbWly+SgqjuLcUQGAQNVsYwdQvU0B0L/kXGaGcZFq/tSzelm2I
         B1Q+WGPvoyMvmifkCM5B0S4NCIkp6SRbFvHGZ6nfBGXVyc0B8XnZyR+/VYiJwO/dM/lf
         6TRg==
X-Gm-Message-State: AOAM533ryU24hfLg1szH5ZRKlyykW5flW6sNfP2cUwqNztShqWmLeT91
        0zllZLwdJ502/ytl9KWAzSg=
X-Google-Smtp-Source: ABdhPJz10OScIcWsisjFbhe0vAj1ffZY2RyCYyFfttGsKIoZ4R3v0ipEAKM637NRGBtoluBUf0650g==
X-Received: by 2002:a1c:f70c:: with SMTP id v12mr25365543wmh.77.1609766955742;
        Mon, 04 Jan 2021 05:29:15 -0800 (PST)
Received: from localhost.localdomain (p200300f13724fd00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3724:fd00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c4sm99916521wrw.72.2021.01.04.05.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 05:29:15 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/5] clk: meson: meson8b: add the HDMI PLL M/N parameters
Date:   Mon,  4 Jan 2021 14:28:05 +0100
Message-Id: <20210104132806.720558-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210104132806.720558-1-martin.blumenstingl@googlemail.com>
References: <20210104132806.720558-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 3.10 vendor kernel uses only specific HDMI PLL M/N parameter
combinations. The PLL won't lock for values smaller than 50 if the
internal doubling (which is yet unknown how to use it) is disabled.
However, when this doubling is enabled then the values smaller than 50
will lock just fine. The only restriction for values greater than 50 is
that the resulting frequency must not exceed the 3.0GHz limit.

These values are taken from the endlessm 3.10 kernel which includes some
additional M/N combinations for some VESA and 75Hz display modes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 1ae771bac4a5..8061c11389a9 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -118,6 +118,28 @@ static struct clk_regmap meson8b_fixed_pll = {
 	},
 };
 
+static const struct pll_params_table hdmi_pll_params_table[] = {
+	PLL_PARAMS(34, 1),
+	PLL_PARAMS(40, 1),
+	PLL_PARAMS(42, 1),
+	PLL_PARAMS(44, 1),
+	PLL_PARAMS(45, 1),
+	PLL_PARAMS(49, 1),
+	PLL_PARAMS(52, 1),
+	PLL_PARAMS(54, 1),
+	PLL_PARAMS(56, 1),
+	PLL_PARAMS(59, 1),
+	PLL_PARAMS(60, 1),
+	PLL_PARAMS(61, 1),
+	PLL_PARAMS(62, 1),
+	PLL_PARAMS(64, 1),
+	PLL_PARAMS(66, 1),
+	PLL_PARAMS(68, 1),
+	PLL_PARAMS(71, 1),
+	PLL_PARAMS(82, 1),
+	{ /* sentinel */ }
+};
+
 static struct clk_regmap meson8b_hdmi_pll_dco = {
 	.data = &(struct meson_clk_pll_data){
 		.en = {
@@ -150,6 +172,7 @@ static struct clk_regmap meson8b_hdmi_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
+		.table = hdmi_pll_params_table,
 	},
 	.hw.init = &(struct clk_init_data){
 		/* sometimes also called "HPLL" or "HPLL PLL" */
-- 
2.30.0

