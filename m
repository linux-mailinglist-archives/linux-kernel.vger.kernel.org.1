Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28762BAFE6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgKTQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgKTQR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:17:56 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 223BB223FD;
        Fri, 20 Nov 2020 16:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889075;
        bh=AY66yUY4/KsmbzR9anhXbPdKuRXMHxLghrRWY/tQB1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jnVEq6LBEMyL9JgrvA9LtzSBOkbMQW8wU08A5SuBqp9FDA07MB9uoMMYIBpq2hx7U
         Q03fuBEr4FhqIHV/nNHQvjRaBnhr130kCsM0hDRBR4ixKB30S0I40EJk+Bbcvjq8A7
         /XH3Zw3NIL88GJrpp0NHza/nHy7MtbZElXjK71FU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 03/38] ASoC: inno_rk3036: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:16:17 +0100
Message-Id: <20201120161653.445521-3-krzk@kernel.org>
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

  sound/soc/codecs/inno_rk3036.c:470:34: warning: ‘rk3036_codec_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/inno_rk3036.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/inno_rk3036.c b/sound/soc/codecs/inno_rk3036.c
index d0e8f0d2fbc1..af74251e08b0 100644
--- a/sound/soc/codecs/inno_rk3036.c
+++ b/sound/soc/codecs/inno_rk3036.c
@@ -476,7 +476,7 @@ MODULE_DEVICE_TABLE(of, rk3036_codec_of_match);
 static struct platform_driver rk3036_codec_platform_driver = {
 	.driver = {
 		.name = "rk3036-codec-platform",
-		.of_match_table = of_match_ptr(rk3036_codec_of_match),
+		.of_match_table = rk3036_codec_of_match,
 	},
 	.probe = rk3036_codec_platform_probe,
 	.remove = rk3036_codec_platform_remove,
-- 
2.25.1

