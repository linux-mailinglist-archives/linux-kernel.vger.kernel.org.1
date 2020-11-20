Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3822BAFEE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgKTQSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729065AbgKTQSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:20 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C0DA22464;
        Fri, 20 Nov 2020 16:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889099;
        bh=BHZ6nUetqig2aNv0C70O6rfOF+ARiHZiTexSCji7bWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qEKoIH8i5FwAd5ly1vMetYZhFMu1kpGGqVE0UUn9liC3Pi2D6HO3lIEMkW8i9iaIP
         sNmP3yJA84yDGQ6X8WBlUdXg32+sjozEnLCoNRgkwkHHoCYqRV7xID/N1XiaadZ4jB
         2FoLPoO6eL220nGxQEDKgQA4xBeZprhpFjIkGsag=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 10/38] ASoC: rockchip: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:16:24 +0100
Message-Id: <20201120161653.445521-10-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).  This fixes
compile warning (!CONFIG_OF on x86_64):

  sound/soc/rockchip/rockchip_i2s.c:569:34: warning: ‘rockchip_i2s_match’ defined but not used [-Wunused-const-variable=]
  sound/soc/rockchip/rockchip_pdm.c:463:34: warning: ‘rockchip_pdm_match’ defined but not used [-Wunused-const-variable=]
  sound/soc/rockchip/rockchip_spdif.c:44:34: warning: ‘rk_spdif_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c   | 2 +-
 sound/soc/rockchip/rockchip_pdm.c   | 2 +-
 sound/soc/rockchip/rockchip_spdif.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 593299675b8c..39d7ce1f53a7 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -714,7 +714,7 @@ static struct platform_driver rockchip_i2s_driver = {
 	.remove = rockchip_i2s_remove,
 	.driver = {
 		.name = DRV_NAME,
-		.of_match_table = of_match_ptr(rockchip_i2s_match),
+		.of_match_table = rockchip_i2s_match,
 		.pm = &rockchip_i2s_pm_ops,
 	},
 };
diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 5adb293d0435..171b55e4010a 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -614,7 +614,7 @@ static struct platform_driver rockchip_pdm_driver = {
 	.remove = rockchip_pdm_remove,
 	.driver = {
 		.name = "rockchip-pdm",
-		.of_match_table = of_match_ptr(rockchip_pdm_match),
+		.of_match_table = rockchip_pdm_match,
 		.pm = &rockchip_pdm_pm_ops,
 	},
 };
diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 674810851fbc..9869da7bccea 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -381,7 +381,7 @@ static struct platform_driver rk_spdif_driver = {
 	.remove = rk_spdif_remove,
 	.driver = {
 		.name = "rockchip-spdif",
-		.of_match_table = of_match_ptr(rk_spdif_match),
+		.of_match_table = rk_spdif_match,
 		.pm = &rk_spdif_pm_ops,
 	},
 };
-- 
2.25.1

