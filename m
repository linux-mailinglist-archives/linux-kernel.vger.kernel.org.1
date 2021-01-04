Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01DC2E9604
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbhADNaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbhADN34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:29:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7436FC061796;
        Mon,  4 Jan 2021 05:29:15 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y17so32160059wrr.10;
        Mon, 04 Jan 2021 05:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ju+fvznWpdnqKgL0XY4kkDus/LAK39t8IpQPOIIruIQ=;
        b=McBUAzMdLiwYXD5jLCbq0wTAXfCoJ093gSi/QpaxlQr0YZKpvEOIWm95LBuOwPAWMo
         cFTd/0EBuKZP2EKuzGxry+pOeCmeXVoqYjwImBgDg7+lAdgeL6ZFqICN1eoNwbwIASVa
         yRQWBi6E5ghBLs6J81QGYsdYfteZGCY5KAjMmeHseB8hjVqYxWEgDCq5OYdrNY3/Gmfg
         YM2QkFqj4c2qHqnr7Pg2/N70/kffN/Uv3LaA/pfsFVVD+XsQgDXcZ+BECc8UWUw/fFS9
         5D/qd3KjxpYfMn6qG4zl7o9zcfF1pS8K6EXYt32LNIuCNZ6ssIIXKFLiTvj76STyxO3R
         j8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ju+fvznWpdnqKgL0XY4kkDus/LAK39t8IpQPOIIruIQ=;
        b=toPu6+l+RFEy07RDReqgGhbyTdIiWhT8e+05aLgwAycNPB2UWfJHi2OAqiXS/a0fAi
         lrQnktz2T2NvXTFxDYTefWnfcGCRgmEK4rSow3WtqVDM89GYJoqtLX03QbPyY4kDUEwy
         U6EBZpUBTkGAskmzRD+5Y7CI7hejjHa7+p2KXuU9ToeMyA0eAyBw9ojz/m/wQjnnrZP8
         wmmoSkVdGrN5tOn+z8cehrtZiQl3uFT1ipYaFutdlwIkgj7TkCrjgbjaonpJxtEPgaL0
         1H2YjsrnwFxtMa91/Vtpxj71O4utkHHd78B+gjVvGzd7Gn3CMoe8eG/EB7HbGk+tQWHx
         Y6Nw==
X-Gm-Message-State: AOAM533lzXpFEdVBWjCVBD/S/6Z26oBPgheESWL0Ek7UJLIcjDOK/uAa
        X3hgU+Sw3fM3DaI/HPbimtg=
X-Google-Smtp-Source: ABdhPJy587NnvO7AefdsF/KjjG1iHKv9GXok92rFrI/AXc+PCpiFAKZ+4KV++7y69fgEPyBWbaMgNQ==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr79255592wrs.82.1609766953904;
        Mon, 04 Jan 2021 05:29:13 -0800 (PST)
Received: from localhost.localdomain (p200300f13724fd00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3724:fd00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c4sm99916521wrw.72.2021.01.04.05.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 05:29:13 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/5] clk: meson: meson8b: define the rate range for the hdmi_pll_dco clock
Date:   Mon,  4 Jan 2021 14:28:03 +0100
Message-Id: <20210104132806.720558-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210104132806.720558-1-martin.blumenstingl@googlemail.com>
References: <20210104132806.720558-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the public S805 datasheet the HDMI PLL VCO frequency has to
be between 1.2GHz and 3.0GHz. Add this range in our driver so we won't
get too low (which means the PLL won't lock) or too high.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index f8bd211db720..16ab595ab1a4 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -3781,6 +3781,11 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
 		return;
 	}
 
+	/* The HDMI PLL VCO is limited to 1.2G~3.0GHz */
+	clk_hw_set_rate_range(clk_hw_onecell_data->hws[CLKID_HDMI_PLL_DCO],
+			      1200 * 1000UL * 1000UL,
+			      3000 * 1000UL * 1000UL);
+
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
 				     clk_hw_onecell_data);
 	if (ret)
-- 
2.30.0

