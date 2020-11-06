Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B29A2A9F36
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgKFVh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbgKFVh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:27 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2916CC0613D4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:27 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 33so2754484wrl.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4FI0nTKy9xJSbbEI5xWFSlWi+PCjFwRWpkkSRoALdw=;
        b=ee6qc24y2pZj9YDGDyPb8gjcUxoCDS7QqwPqzOGliCMPjVE4hgUQnxfc/cQbX6pLMi
         jG7ZqRhHvXFutGqqB7qlZ1utF3tXCnfzjnNmXVGS7K5rmrZnunhCXCeVP4EJb3tkXBT5
         IMcjiFXPx6FVS4GwzziYMnIm5VAX5PGlS4vKGgeCfExaU8VkhpNVy48HXGeWq+R2l7Ip
         UTJGoQppPVyfPXOwpWOXXkzIwWofB9xZkAKvglS22VfyKaviEajKSzjHlQFD8fvxUDSC
         Io3a2xSTn5Oz/BPqRo++gn/Vn95v7JiToXxq2feqYe8fVU7IseAJ35+s/dZm4yY/bDL7
         wjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4FI0nTKy9xJSbbEI5xWFSlWi+PCjFwRWpkkSRoALdw=;
        b=PGLdmFezPQrqFnKB2YtA4gEk79NWOSxEkxNATDtwGRybObgGXJn0KXTVGGjdu/nsFp
         hMY1R7/dATZqaXd8hPaFRZiNZoSATxgLn395c9ALA2lng1QbecIqAuQRqy24G3quSD1x
         VdTWfsVqNhLv2l+g97HkollmINeD11NRe9sparjATs4crp02qp8o7bVjRLTsgyhcoF+G
         Ep57gFmyNUGaI+ecnTcE+u5KuQAprSAyS1nbSkTkjghnX7AAdWKkwCLSESYWZ0kZHVQQ
         fonMVbrv/g52mGPnNjbALm6zQj/ePAjSE173Ikm6C2GBJbrh71YP4ngePv3WJkXWPGkI
         rDbA==
X-Gm-Message-State: AOAM533aTIcJBcrm14NjRXf0tjZaWRv+HSWfG4zYWx6hsvwp6fyrSnbM
        ZuI9VcwaUDEXGB++sX0AoTTLBA==
X-Google-Smtp-Source: ABdhPJyVxA3gZ7tVm2WMN26zWZSqXfJm4SZWp1+Daeu4mASzQFbu+ZGYKkEI0v5B8IJEINqyH8FT7A==
X-Received: by 2002:adf:fb12:: with SMTP id c18mr4481368wrr.99.1604698645863;
        Fri, 06 Nov 2020 13:37:25 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris BREZILLON <b.brezillon.dev@gmail.com>,
        Qiang Yu <yuq825@gmail.com>, Dmitriy B <rzk333@gmail.com>,
        Sergey Lapin <slapin@ossfans.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 20/23] mtd: nand: raw: sunxi_nand: Document 'sunxi_nfc's 'caps' member
Date:   Fri,  6 Nov 2020 21:36:52 +0000
Message-Id: <20201106213655.1838861-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/raw/sunxi_nand.c:250: warning: Function parameter or member 'caps' not described in 'sunxi_nfc'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Boris BREZILLON <b.brezillon.dev@gmail.com>
Cc: Qiang Yu <yuq825@gmail.com>
Cc: Dmitriy B <rzk333@gmail.com>
Cc: Sergey Lapin <slapin@ossfans.org>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 1ec672bbd459d..923a9e236fcf6 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -236,6 +236,7 @@ struct sunxi_nfc_caps {
  *	   controller
  * @complete: a completion object used to wait for NAND controller events
  * @dmac: the DMA channel attached to the NAND controller
+ * @caps: NAND Controller capabilities
  */
 struct sunxi_nfc {
 	struct nand_controller controller;
-- 
2.25.1

