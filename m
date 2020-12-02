Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606E12CC755
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388136AbgLBUBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:01:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388036AbgLBUBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:01:16 -0500
From:   Krzysztof Kozlowski <krzk@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 1/2] soc: samsung: exynos-chipid: order list of SoCs by name
Date:   Wed,  2 Dec 2020 21:59:54 +0200
Message-Id: <20201202195955.128633-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring some order to the list of SoCs.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/soc/samsung/exynos-chipid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 8d4d05086906..b4cd0cc00f45 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -20,6 +20,7 @@ static const struct exynos_soc_id {
 	const char *name;
 	unsigned int id;
 } soc_ids[] = {
+	/* List ordered by SoC name */
 	{ "EXYNOS3250", 0xE3472000 },
 	{ "EXYNOS4210", 0x43200000 },	/* EVT0 revision */
 	{ "EXYNOS4210", 0x43210000 },
@@ -29,10 +30,10 @@ static const struct exynos_soc_id {
 	{ "EXYNOS5260", 0xE5260000 },
 	{ "EXYNOS5410", 0xE5410000 },
 	{ "EXYNOS5420", 0xE5420000 },
+	{ "EXYNOS5433", 0xE5433000 },
 	{ "EXYNOS5440", 0xE5440000 },
 	{ "EXYNOS5800", 0xE5422000 },
 	{ "EXYNOS7420", 0xE7420000 },
-	{ "EXYNOS5433", 0xE5433000 },
 };
 
 static const char * __init product_id_to_soc_id(unsigned int product_id)
-- 
2.25.1

