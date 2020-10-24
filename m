Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6F8297D55
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 18:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762141AbgJXQVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 12:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762054AbgJXQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 12:21:10 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08053C0613D2;
        Sat, 24 Oct 2020 09:21:10 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id n6so5590739ioc.12;
        Sat, 24 Oct 2020 09:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DmYNWcDzAnUPRQg3cM/VYh7D0PDE+R8thr7Gr3d/KwY=;
        b=tfZBv9ovL7BaAq0jTmitzZtsR/oJmh1iNcLpOoLXbe5iQtaGg+bMMJKgd4QQCUf+4k
         rcplSN/Brn8hN24XiCYmBT4gWCNoAhbYwoChX01fU4modD5ThPhNYuWRxvZb9WTjNBTk
         TX4BNl4yu+Z0xh37ykOnBrMgH+sBZ3G+7pdNtKAdvdH0C6USE6uRWd1mTYF0AF6sXU1V
         uzm1b7ksEOy+tg9ul0hLHr5NUNgPgnb2wZe3kX976tsIGqwEfox3mcip+6/2dGfSmeMf
         LlnJYV69qFQbY4eGvtfnwCkXgssmEIQuyq+dNsvxjB+W75zrOyW4Ym4guhB8X1HJ905a
         NQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DmYNWcDzAnUPRQg3cM/VYh7D0PDE+R8thr7Gr3d/KwY=;
        b=R2wnGLCXJw+B059dS2DzxpR2ckbDpMRJkr9UmazcLForHjfCgxzrNc5bl9nYJ58m9w
         oafx0SQyAiTJrhjltqjSaaBu9Zsa2H6mnN0ZhLS9gpnImr8g8ariyVAsONgW7qrloHvK
         +R/noC/dAPWZBh0HhsPiRD0NLgHYxmvAm5CfW9VntnyR6wNnbpaKzH3GX9Qts34WCehm
         t1Bp0Cl+kA2cP+YRpHhCGHM0nZ6qEfRUiagKuYhRCnhq/xBNYJPahYOxtT7KUfqrZJLW
         CcxDurbJqOxxhwWO8WeBJujNloZ9TMA1AFQIaJq0EJ/DaOP90TW4zaMok84FZLG/yug1
         /6iw==
X-Gm-Message-State: AOAM530kbPl5rW5cEaiVNjOhUq3on4jvmsoW2ZFl7aHOjzq6wysokDQm
        Nzvdt3nzxca7BewUaSoPETSndTbktGoRKg==
X-Google-Smtp-Source: ABdhPJwb9Bt+Lu50N9TRHbiQm7gIzbOuF5p2bweesi4/dxe6M4QdxTY+/Ap91Lw2dZ7Ncpd6hqRRTw==
X-Received: by 2002:a02:a384:: with SMTP id y4mr6008244jak.63.1603556468376;
        Sat, 24 Oct 2020 09:21:08 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:527:767:b750:2d3c])
        by smtp.gmail.com with ESMTPSA id m86sm3028587ilb.44.2020.10.24.09.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 09:21:07 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     abel.vesa@nxp.com, marex@denx.de, Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [RFC 2/3] dt-bindings: reset: imx8mn: Add media blk_ctl reset IDs
Date:   Sat, 24 Oct 2020 11:20:14 -0500
Message-Id: <20201024162016.1003041-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201024162016.1003041-1-aford173@gmail.com>
References: <20201024162016.1003041-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be used by the imx8mn for blk_ctl driver.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 include/dt-bindings/reset/imx8mn-reset.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/dt-bindings/reset/imx8mn-reset.h b/include/dt-bindings/reset/imx8mn-reset.h
new file mode 100644
index 000000000000..89d402742b96
--- /dev/null
+++ b/include/dt-bindings/reset/imx8mn-reset.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Compass Electronics Group, LLC
+ */
+
+#ifndef DT_BINDING_RESET_IMX8MN_H
+#define DT_BINDING_RESET_IMX8MN_H
+
+#define IMX8MN_MEDIA_BLK_CTL_RESET_MIPI_DSI_PCLK	0
+#define IMX8MN_MEDIA_BLK_CTL_RESET_MIPI_DSI_CLKREF	1
+#define IMX8MN_MEDIA_BLK_CTL_RESET_MIPI_CSI_PCLK	2
+#define IMX8MN_MEDIA_BLK_CTL_RESET_MIPI_CSI_ACLK	3
+#define IMX8MN_MEDIA_BLK_CTL_RESET_LCDIF_PIXEL	4
+#define IMX8MN_MEDIA_BLK_CTL_RESET_LCDIF_APB		5
+#define IMX8MN_MEDIA_BLK_CTL_RESET_ISI_PROC		6
+#define IMX8MN_MEDIA_BLK_CTL_RESET_ISI_APB		7
+#define IMX8MN_MEDIA_BLK_CTL_RESET_BUS_BLK		8
+#define IMX8MN_MEDIA_BLK_CTL_RESET_MIPI_S_RESET	9
+#define IMX8MN_MEDIA_BLK_CTL_RESET_MIPI_M_RESET	10
+#define IMX8MN_MEDIA_BLK_CTL_RESET_NUM		11
+
+#endif
-- 
2.25.1

