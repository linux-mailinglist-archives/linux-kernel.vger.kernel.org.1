Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD9D2FCE06
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbhATKQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731406AbhATJcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:32:13 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA815C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:47 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id s24so2926295wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PqNANroWmMHlO1pRmhfJauWaSkV5jIwl7ipaqnMtcdc=;
        b=r0xJj3iB0NP1VzuG0B7s27YaKBg2dVt5KTN1XK54fbdJh0jq3G54zNMhnwwnyHT/PE
         tdsDlrHxHhQyOfxYkld8cwEZY9gbcAuJ87kUf6Fi2u7nqvFZ/lY+tMnvnavmzSybTP5a
         THX6J+XYLf/EDt62ObOWuQzrnu5L68ef/NL8d+2In/tmQaq98NILRUzgTy91mue5ljku
         QEb6rPIVAGiYwD2p1k1gqAcR5ZEDUcdpTTpOqoAonBKL2XcyYjHkuciDAt/4/4s/w788
         aYnWkFiI9ezQgbL8qWVj77H+i4lyNQEbtuF1/HgDSyM9gLCNRWieZJ6f889c5RAWifpI
         1e3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PqNANroWmMHlO1pRmhfJauWaSkV5jIwl7ipaqnMtcdc=;
        b=dIzt4Wq7AeybSoZdqZ5qlTFhgjetXqSpvBVLJJ6QFzljUpe38Vl/TxZlMWVuVx6Qjv
         GmwU7A5qkAtdVW2MybPcMwUTlXfRaQ037HV7OhZ740m+lzzmQKfnJbrLQtfyRq++xsFH
         wAuN0x6HQV1pHGa8l7Ap2cBUCMOlJ9Beg9YzLAaCOVZe2fAPDTHtTEn1FrW4Feas00B2
         /vob68jMUanxRexA5x/s5Qbe7JK+NtRQYP6rbCsb6xCGPhnmBP1MhIJ0t1VPeD/rLh0Z
         55A9ZfYIa4zwWCL8Xmo0lc72T8N48QYXPeCHPaSkJF5ZNHJ/MstBLrd9q+bYrdyyuLol
         IxlQ==
X-Gm-Message-State: AOAM531K1qqENt0EO7+3nlZmV5xjm5eio9QW1yhGLN1OEvPJxmFWvXrQ
        L4cbT0qXgbgzgwYK9idsyvEqxbFyvLUfP36X
X-Google-Smtp-Source: ABdhPJwsXAxMF8Ve1yt/YsnaYPprvYXsGFiL+2XiIwlYnp0wwtvGw07v4C3WFGTMZ5NOkVV9nw9TSw==
X-Received: by 2002:a1c:9c84:: with SMTP id f126mr3505815wme.152.1611135046604;
        Wed, 20 Jan 2021 01:30:46 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:30:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Abraham <thomas.ab@samsung.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 02/20] clk: rockchip: clk-cpu: Remove unused/undocumented struct members
Date:   Wed, 20 Jan 2021 09:30:22 +0000
Message-Id: <20210120093040.1719407-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120093040.1719407-1-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/rockchip/clk-cpu.c:65: warning: Function parameter or member 'cpu_mux' not described in 'rockchip_cpuclk'
 drivers/clk/rockchip/clk-cpu.c:65: warning: Function parameter or member 'cpu_mux_ops' not described in 'rockchip_cpuclk'

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/rockchip/clk-cpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index 0dc478a19451b..fa9027fb1920a 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -51,10 +51,6 @@
  */
 struct rockchip_cpuclk {
 	struct clk_hw				hw;
-
-	struct clk_mux				cpu_mux;
-	const struct clk_ops			*cpu_mux_ops;
-
 	struct clk				*alt_parent;
 	void __iomem				*reg_base;
 	struct notifier_block			clk_nb;
-- 
2.25.1

