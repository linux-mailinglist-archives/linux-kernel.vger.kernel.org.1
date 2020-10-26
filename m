Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43E7299145
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784269AbgJZPki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784261AbgJZPkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:40:35 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4099E22400;
        Mon, 26 Oct 2020 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603726835;
        bh=9ZA2eUlao+W2wjkHccyiO9YyGNF586SIGj+ZQg6YKD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjXnh3M0/liuMV7QyGMmlKiUKrc4da3ovQD6nsgOscWexQ1B3/1ZaXpLMAEH/Nupb
         ZH+QHvTCcSUdS0J0xrRICdPfwI+gNeiIC9u5NQqb1ZUJmpQL6yGI3oyK4CovvTnX9I
         fUEABGcBlM83g6o3JVrWVUybcjau9hiUfVcKf3GI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/3] mmc: sunxi: drop of_match_ptr from of_device_id table
Date:   Mon, 26 Oct 2020 16:38:10 +0100
Message-Id: <20201026153810.89512-3-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026153810.89512-1-krzk@kernel.org>
References: <20201026153810.89512-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via DT table so it should be always used and
the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant for sunxi).  This
fixes compile warning:

    drivers/mmc/host/sunxi-mmc.c:1181:34: warning: ‘sunxi_mmc_of_match’ defined but not used [-Wunused-const-variable=]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sunxi-mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index fc62773602ec..6310693f2ac0 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -26,6 +26,7 @@
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -1515,7 +1516,7 @@ static struct platform_driver sunxi_mmc_driver = {
 	.driver = {
 		.name	= "sunxi-mmc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.of_match_table = of_match_ptr(sunxi_mmc_of_match),
+		.of_match_table = sunxi_mmc_of_match,
 		.pm = &sunxi_mmc_pm_ops,
 	},
 	.probe		= sunxi_mmc_probe,
-- 
2.25.1

