Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6A5303E21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392048AbhAZNID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391975AbhAZMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:49:00 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE82C0698DB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c127so2615407wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HC9oGmsVO5oAzKPG00K8ovLaaiSlGT3tZa2rImR2jdE=;
        b=qtT+KJH+lKspIgo6IvnRoDbAhFLYau59bLEimbXlVRgym8AoBAMHvXmGYOOhCg4Igh
         gzwZXnfHKm+51ASEJvjnO1w1SIXW+N9KH4kNgtDG8b7y0kT5hjeIZvo3e0SdZZJol2HG
         elgJs/kVgO8UPCbWORn7Vo6GMjdaYb8L9icnkKVwRWKxbAbJJnxkWPsyauZGNPI3Udj+
         0rKtEex+MeckBdtl1VLSa7eliuAuYpzRf7b0JnJ3+wsOKCOj9w/ZVjkGWVvLyQYBkW4+
         3vI/Erlh+URfZV3eV0r47vz+QbO90L2yMztxUhxBNz6eWrv7vdmjvVwJ7OhnEuD8wHaR
         2hvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HC9oGmsVO5oAzKPG00K8ovLaaiSlGT3tZa2rImR2jdE=;
        b=JFzGkiN2hs8SbLcL3XXLAw7uIgsD3cNyFqkd1qSqp9+BMW5K5dsKm6vwJ6mPPmDcjs
         yIUIOMiM20tANRN53Nb3HaLEKlS6A3Goa/Fmh3QITsMG1UObiz28jmsbSnqes33iKTgx
         +QzYbsS/q8PkEqW1lHjLXu8VycEmh6qRe4iwoNOoryfyOHVA1IKrgrWLdE54ZEw5TLcb
         xWdR2AwI0d8nbOLL912Qz4MVywcDF8F7eAPXBAwCi8fTn7uZbPHY9apJWjmInrqyts62
         xXXAYYSsb2MQd2j4E9B9a7BiIGn4Q6qsX1J5R2BCRMPWKgCzupMv1j5rQIBrBm5UUXEo
         nNuA==
X-Gm-Message-State: AOAM532vg6CDmZBF5KpXkQlfYBQ212gZxP+4DDWoJG0csanyrydrVmff
        brqsSYjINfhLHC6j9YUPk1Zx0g==
X-Google-Smtp-Source: ABdhPJx+9ryinrcrzNqRBnQheOhsDKyqDTA69GbijOK1wMVO2OJRSAEClu1EGu535Mt4uLL9Slra/g==
X-Received: by 2002:a1c:df04:: with SMTP id w4mr1944888wmg.66.1611665157661;
        Tue, 26 Jan 2021 04:45:57 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:45:57 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 11/21] clk: renesas: renesas-cpg-mssr: Fix formatting issues for 'smstpcr_saved's documentation
Date:   Tue, 26 Jan 2021 12:45:30 +0000
Message-Id: <20210126124540.3320214-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124540.3320214-1-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/renesas/renesas-cpg-mssr.c:168: warning: Function parameter or member 'smstpcr_saved' not described in 'cpg_mssr_priv'

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 1c3215dc4877c..bffbc3d2faf5f 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -136,8 +136,8 @@ static const u16 srstclr_for_v3u[] = {
  * @control_regs: Pointer to control registers array
  * @reset_regs: Pointer to reset registers array
  * @reset_clear_regs:  Pointer to reset clearing registers array
- * @smstpcr_saved[].mask: Mask of SMSTPCR[] bits under our control
- * @smstpcr_saved[].val: Saved values of SMSTPCR[]
+ * @smstpcr_saved: [].mask: Mask of SMSTPCR[] bits under our control
+ *                 [].val: Saved values of SMSTPCR[]
  * @clks: Array containing all Core and Module Clocks
  */
 struct cpg_mssr_priv {
-- 
2.25.1

