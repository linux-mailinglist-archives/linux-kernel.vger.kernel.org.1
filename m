Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BE8297D31
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762057AbgJXPoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756857AbgJXPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:44:29 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2922AC0613CE;
        Sat, 24 Oct 2020 08:44:29 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h20so4875395lji.9;
        Sat, 24 Oct 2020 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iVvngnWeIDGhbxLx06m+FoOELtVvu4vONgAX93A/tXY=;
        b=kvnx4TOKigpxlEKazViL6WLSKKrbU0dOmb5zHP7dZbPHHdved9KAw96ScO0YXfUbBL
         GWMcOZvfKBSte7uOI8XI+79DsSEDU+kukxn/3vHWgEJrM397fkjibfcIczl9akmjgoII
         XwGNe7impjNc3/qRrYCgpprD0BDRXXPjYBPnZjF9Qgp/cHwOBebv/QCnoYNh3y3RWTzP
         41HwRVcWSBJ4ojwoRWAMt/zZYBpN7UcTuoFJQe0bl42A83RmUNmDnihz18wCpUx1Av//
         mD0S0NHOQpzevaYzpcSIGNTViExTnluNLcOqoeL3JonjEVjRVKI8Cwzi9/5MtGCmEqXN
         3myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iVvngnWeIDGhbxLx06m+FoOELtVvu4vONgAX93A/tXY=;
        b=HqAmHaLgOvf8THcbS2kLNpzBMHM7EimI0z86qShhw1z9PfJVQ+kCe9R9/V3xhoCM0B
         wPKhmERvoooG3SHOdHt9/imgV5bf3Z2hQJjhkVDklzHCTbf3GQzHXOU+sTaontKYDfGj
         B0r6VyAlFlH8MJDLnuvCmu6LijtA3JMbHEtj18/kQBTUapgdja6ahtGAwriWOYke9K1V
         XJp/3d75qZRwbLkQARBHsMo2ZuVJBb7DhWsaGXdr7KOgWu44mtAlciG1wwO4nxkvIP1T
         9K27xIDZrB7n5C66ekHP01JtxhqhjmrtswQgj33FDAdpcB3doey1iNkjsLz5iI6tA53f
         OSQw==
X-Gm-Message-State: AOAM530QzFlhQuzuFFJivuJ50rfTjjixFFRPrJ5IzIkcmY2vdxFRQuzV
        phFGcfvRuW+fokpc36rzG7Z0alt3/48=
X-Google-Smtp-Source: ABdhPJz/klHWcs3bRbKDkYASeDigVNP3nTTs5rtGYA7UaR3O9h/X1CTwcak2v4Vg9hMKBIhvW+fi3w==
X-Received: by 2002:a2e:87cd:: with SMTP id v13mr2689614ljj.146.1603554266621;
        Sat, 24 Oct 2020 08:44:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:e9e3:358e:a790:ce1c])
        by smtp.googlemail.com with ESMTPSA id 76sm472536lfn.128.2020.10.24.08.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 08:44:25 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH] clk: exynos7: Mark aclk_fsys1_200 as critical
Date:   Sat, 24 Oct 2020 17:43:46 +0200
Message-Id: <20201024154346.9589-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clock must be always enabled to allow access to any registers in
fsys1 CMU. Until proper solution based on runtime PM is applied
(similar to what was done for Exynos5433), mark that clock as critical
so it won't be disabled.

It was observed on Samsung Galaxy S6 device (based on Exynos7420), where
UFS module is probed before pmic used to power that device.
In this case defer probe was happening and that clock was disabled by
UFS driver, causing whole boot to hang on next CMU access.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/clk/samsung/clk-exynos7.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index c1ff715e960c..1048d83f097b 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -538,7 +538,8 @@ static const struct samsung_gate_clock top1_gate_clks[] __initconst = {
 		ENABLE_ACLK_TOP13, 28, CLK_SET_RATE_PARENT |
 		CLK_IS_CRITICAL, 0),
 	GATE(CLK_ACLK_FSYS1_200, "aclk_fsys1_200", "dout_aclk_fsys1_200",
-		ENABLE_ACLK_TOP13, 24, CLK_SET_RATE_PARENT, 0),
+		ENABLE_ACLK_TOP13, 24, CLK_SET_RATE_PARENT |
+		CLK_IS_CRITICAL, 0),
 
 	GATE(CLK_SCLK_PHY_FSYS1_26M, "sclk_phy_fsys1_26m",
 		"dout_sclk_phy_fsys1_26m", ENABLE_SCLK_TOP1_FSYS11,
-- 
2.25.1

