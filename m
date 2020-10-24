Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D35297D52
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 18:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762107AbgJXQVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 12:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759673AbgJXQVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 12:21:07 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D102C0613CE;
        Sat, 24 Oct 2020 09:21:07 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k21so5599588ioa.9;
        Sat, 24 Oct 2020 09:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJv7OiMikXXMbdvgcciK3mXRtlHAeNlbojgHERZfLF8=;
        b=iu8Z1xjus9qMOBAGRkQoVxOEo5dixzIfAda1oNH3q/uTowBPj+4jgjWrgR4hP4PiTp
         gn987eEDXFgxFgoRCQLUkBouNf9VnynQn3fSncMnuLbOHyum6S/NH6Tkb25D6lNEeXJA
         weaHIeaW55JzyaRuhO3hxjIOMrUWW+clw8VcGTwBO1z9T8bV1y++osrgbkVlBa+xxuyY
         VUWsy9XH2Lnv11UWbYPVE/t5yRqGzV6zfhk2Gdv1QK9cUZCr4rW0NZkTgGIw8751M4kO
         nn/jBtG9e5AzpRCPCxmlMzZktXEg7S2K3rT6620P7Jy0bb/i+ec/3jr9RZLs6HhlAEmM
         /d/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJv7OiMikXXMbdvgcciK3mXRtlHAeNlbojgHERZfLF8=;
        b=XjkX0Jj1DkQfVU9lkwhS/amPg7bUbUMfRe8p7jWPEnqM4zgYKyeV1F3BBvpU2NslgR
         dRpgcsAHg3o1kTqQZy4kiGPdpDsXsdWk2wlTzvvQ37jjK9X38oA0234dzxuMzBYsUO5a
         HPqtaxdKIsuUSylHA73EElrbdFD3E8wsfUwdBgFK/9N2b3Axwyyx6xKmH3pWNgMFR5ms
         bkcMDco3YucL+oegV0aDAj94YITjxU2n0BpktoGQ6VDTFqV6SCYAgW7uFslSijzMKxhC
         o3sX/rW7drwJ7T5i0XZJv5q2ZnzE/PQ5hvExHdEvhRiHegRnTWzJQVSqcgop8Ae/mGGT
         ShQQ==
X-Gm-Message-State: AOAM530F8hYYmw7z3zUsjWD5u3Yvzs4mc1pwz3dn2GDa56etzLVLsfDT
        JrTi5coiCfBfTuYRl23ugiH2jOb2Ofoj2A==
X-Google-Smtp-Source: ABdhPJx08Goj6W0lkWlmWsvqVP/nNXXTHXEr+AEoTnjdo1c3P/WjyD2cc5el5YPADM15Cm9X1g2NaA==
X-Received: by 2002:a05:6602:2ac3:: with SMTP id m3mr5594921iov.105.1603556466474;
        Sat, 24 Oct 2020 09:21:06 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:527:767:b750:2d3c])
        by smtp.gmail.com with ESMTPSA id m86sm3028587ilb.44.2020.10.24.09.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 09:21:05 -0700 (PDT)
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
Subject: [RFC 1/3] dt-bindings: clock: imx8mn: Add media blk_ctl clock IDs
Date:   Sat, 24 Oct 2020 11:20:13 -0500
Message-Id: <20201024162016.1003041-2-aford173@gmail.com>
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
 include/dt-bindings/clock/imx8mn-clock.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/dt-bindings/clock/imx8mn-clock.h b/include/dt-bindings/clock/imx8mn-clock.h
index 621ea0e87c67..2baaa2dccfd3 100644
--- a/include/dt-bindings/clock/imx8mn-clock.h
+++ b/include/dt-bindings/clock/imx8mn-clock.h
@@ -236,4 +236,15 @@
 
 #define IMX8MN_CLK_END				215
 
+#define IMX8MN_CLK_MEDIA_BLK_CTL_MIPI_DSI_PCLK	0
+#define IMX8MN_CLK_MEDIA_BLK_CTL_MIPI_DSI_CLKREF	1
+#define IMX8MN_CLK_MEDIA_BLK_CTL_MIPI_CSI_PCLK	2
+#define IMX8MN_CLK_MEDIA_BLK_CTL_MIPI_CSI_ACLK	3
+#define IMX8MN_CLK_MEDIA_BLK_CTL_LCDIF_PIXEL		4
+#define IMX8MN_CLK_MEDIA_BLK_CTL_LCDIF_APB		5
+#define IMX8MN_CLK_MEDIA_BLK_CTL_ISI_PROC		6
+#define IMX8MN_CLK_MEDIA_BLK_CTL_ISI_APB		7
+#define IMX8MN_CLK_MEDIA_BLK_CTL_BUS_BLK		8
+#define IMX8MN_CLK_MEDIA_BLK_CTL_END			9
+
 #endif
-- 
2.25.1

