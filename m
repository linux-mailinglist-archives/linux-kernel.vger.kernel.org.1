Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639E41B8E1F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 11:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgDZJBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 05:01:52 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:6672 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgDZJBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 05:01:52 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 89EBD48263D;
        Sun, 26 Apr 2020 17:01:48 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/exynos: make pointer to const data const type
Date:   Sun, 26 Apr 2020 02:01:42 -0700
Message-Id: <20200426090142.21251-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VLTEhCQkJDQ0pMT09IQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODI6Aww4ITg#LEkeKRwqLgwO
        NREaFBFVSlVKTkNMQ0JKTEtDQ01DVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSUNDSTcG
X-HM-Tid: 0a71b5b8a36f93bakuws89ebd48263d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe keep pointer which points to global const string data
in const type is better, make sure not change const data.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_mic.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index e080aa92338c..f60d99c85ac9 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -211,7 +211,7 @@
 
 #define OLD_SCLK_MIPI_CLK_NAME "pll_clk"
 
-static char *clk_names[5] = { "bus_clk", "sclk_mipi",
+static const char *const clk_names[5] = { "bus_clk", "sclk_mipi",
 	"phyclk_mipidphy0_bitclkdiv8", "phyclk_mipidphy0_rxclkesc0",
 	"sclk_rgb_vclk_to_dsim0" };
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index f41d75923557..a86abc173605 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -88,7 +88,7 @@
 
 #define MIC_BS_SIZE_2D(x)	((x) & 0x3fff)
 
-static char *clk_names[] = { "pclk_mic0", "sclk_rgb_vclk_to_mic0" };
+static const char *const clk_names[] = { "pclk_mic0", "sclk_rgb_vclk_to_mic0" };
 #define NUM_CLKS		ARRAY_SIZE(clk_names)
 static DEFINE_MUTEX(mic_mutex);
 
-- 
2.26.2

