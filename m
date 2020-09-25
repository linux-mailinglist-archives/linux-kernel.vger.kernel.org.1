Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADE3278EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgIYQnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgIYQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:43:31 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F70C0613CE;
        Fri, 25 Sep 2020 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bkS+waRwerACov79/m/rcNqbMgeSjcgfK2jH3Ym5UJE=; b=ORB843nsDvTeeyde3VZBJBU8c0
        fowWSFjNYhEAqeFwfhfzfqHiR8Pr8pfFyLdkUaaKNZj79bxsIxDC/k+qGg+VnIiCdWEV2iVbGiNo8
        qcu9gEV+FpcT8MZ3BNoUdJijDw+BeNz7ljZ6olsP+AxFjmxYFGcRLjWaPxfItw+WO4vjHI9tUi9jR
        U6Lgo1CHdWQfsTrbUDDWjlI+s+eOmp+cUcRXO37boMTt4mPWQGO+N2IFfGB/Ri4dJfpdebDpHsBfP
        wXKq1RODOTEiF5lIow66SosN17zrCm0oIPbCk1hNZh7Oh4U+RZFRtfyEJ2KDH29jUASK2Gi2Vz6aM
        EjbubAig==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLqoi-0005LP-D0; Fri, 25 Sep 2020 16:43:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] mmc: host: fix depends for MMC_MESON_GX w/ COMPILE_TEST
Date:   Fri, 25 Sep 2020 09:43:23 -0700
Message-Id: <20200925164323.29843-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build errors for meson-gx-mmc.c when CONFIG_COMMON_CLK is not
set/enabled. This can happen when COMPILE_TEST is set/enabled.

ERROR: modpost: "clk_divider_ops" [drivers/mmc/host/meson-gx-mmc.ko] undefined!
ERROR: modpost: "devm_clk_register" [drivers/mmc/host/meson-gx-mmc.ko] undefined!
ERROR: modpost: "clk_mux_ops" [drivers/mmc/host/meson-gx-mmc.ko] undefined!
ERROR: modpost: "__clk_get_name" [drivers/mmc/host/meson-gx-mmc.ko] undefined!

Fixes: 54d8454436a2 ("mmc: host: Enable compile testing of multiple drivers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200925.orig/drivers/mmc/host/Kconfig
+++ linux-next-20200925/drivers/mmc/host/Kconfig
@@ -425,6 +425,7 @@ config MMC_SDHCI_IPROC
 config MMC_MESON_GX
 	tristate "Amlogic S905/GX*/AXG SD/MMC Host Controller support"
 	depends on ARCH_MESON|| COMPILE_TEST
+	depends on COMMON_CLK
 	help
 	  This selects support for the Amlogic SD/MMC Host Controller
 	  found on the S905/GX*/AXG family of SoCs.  This controller is
