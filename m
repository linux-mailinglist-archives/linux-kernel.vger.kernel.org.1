Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661CE2A2A0E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgKBLyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbgKBLyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:40 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEBCC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:39 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so7563556wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4FI0nTKy9xJSbbEI5xWFSlWi+PCjFwRWpkkSRoALdw=;
        b=GIKna396jzOVW+ALh0LB6+ecSjyaVMvuapts/jRS1AqNPMqMaPpMtRni5IRlzcPth5
         fWQ/PlLb1/md7AvJMfC69ciSqX8M4lLEIclzXGaw+RPlrCU46vZiALNQJKmMl4eI8IBr
         KsWHqX+T9db1tHrO8uv0v61lGo2DlxMPpo65GWmqxcivzr58SBQxev/WLu06ZCZduafW
         pssLs7UNPdgQ38bxU17NKpRz7rKwuwH0flKDVlW1CPvRJrflwoY3jRsIxANw+lTCjt8a
         a9jPfJ76vophYgYYqayQZtEO+tgsVQmd8Hh7VPIqKGpOx1Ula0NxPGfKkUOU9ttuysIM
         xQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4FI0nTKy9xJSbbEI5xWFSlWi+PCjFwRWpkkSRoALdw=;
        b=Tt4RLzIga0WPiAxUYjCK90mFKz/Zcdg6exw1UImIH7oFHslUIzEUQYL60nlM8Uz2OM
         VBK6WrnulfFgu4+OmdhNmZxXTopgNvr8vD4E9eBy7+PZk37ls2ZYYof6eKbnl3BTBE6n
         126wMUGdg8l6Bf1iBzM8cz2JA7hPPg1U9tehfh6CCACSZx2jIN6H796IH2zYSP+75iAr
         xqcgsY95JDj8yeymP5j54FBM0EAS4Qshgtyg0YF9I+piojkkyKYV/DCVIfMQ+1SbO/74
         bHlopy683ihDrVh/rDSuza7ifQlTUYKWGzOaPyL9ZJtR61PufJt7OKJN3FvYwcPy5USB
         dxfA==
X-Gm-Message-State: AOAM530er1BH6x+egZzYNaCYfc0o2u6FDmh4l/V6kmL9WrSqKI/9HAq6
        QN8F5TBzObm8nQNOfs7MgdC6bQ==
X-Google-Smtp-Source: ABdhPJyunu9SesmSMOXhFYwh8UpSFqq6TKtkRc/2EOGe+H0GSSE4EDyjDnhcCiPZINMH/kFiGK6WUA==
X-Received: by 2002:a1c:6484:: with SMTP id y126mr11934961wmb.141.1604318078529;
        Mon, 02 Nov 2020 03:54:38 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris BREZILLON <b.brezillon.dev@gmail.com>,
        Qiang Yu <yuq825@gmail.com>, Dmitriy B <rzk333@gmail.com>,
        Sergey Lapin <slapin@ossfans.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 20/23] mtd: nand: raw: sunxi_nand: Document 'sunxi_nfc's 'caps' member
Date:   Mon,  2 Nov 2020 11:54:03 +0000
Message-Id: <20201102115406.1074327-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
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

