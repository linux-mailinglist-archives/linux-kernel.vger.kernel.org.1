Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1F72BAFEC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgKTQSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbgKTQSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:16 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0E0122470;
        Fri, 20 Nov 2020 16:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889096;
        bh=/DycQ1hb3XETKxcgJtqoZZmUGffDzYpw1TgYfDhw+Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nY2He0xqB6LFhFYyPcS/lCdJ7Gs5C/ZsLZcQ7YZDAWcZA0pnLFldy0K38izU6tUaB
         +DFPOLMDCabAhy6KlnmE6T5+1EodBP3+38ktnvltT3JuIbkuYuNyPu1gcbOvjBnA7P
         yzf3B3LBriY2xJev3kA2K+6Oehsl7DdKJx1Q0Khc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 09/38] ASoC: samsung: smdk_wm8994: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:16:23 +0100
Message-Id: <20201120161653.445521-9-krzk@kernel.org>
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

  sound/soc/samsung/smdk_wm8994.c:139:34: warning: ‘samsung_wm8994_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/smdk_wm8994.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 64a1a64656ab..696ab6abd1f6 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -187,7 +187,7 @@ static int smdk_audio_probe(struct platform_device *pdev)
 static struct platform_driver smdk_audio_driver = {
 	.driver		= {
 		.name	= "smdk-audio-wm8994",
-		.of_match_table = of_match_ptr(samsung_wm8994_of_match),
+		.of_match_table = samsung_wm8994_of_match,
 		.pm	= &snd_soc_pm_ops,
 	},
 	.probe		= smdk_audio_probe,
-- 
2.25.1

