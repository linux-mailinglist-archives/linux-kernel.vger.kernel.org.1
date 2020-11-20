Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0552BB04A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgKTQUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729723AbgKTQUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:20:05 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25BB624073;
        Fri, 20 Nov 2020 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889204;
        bh=f0BWrScl8LITa0d86tCyNbDAQAWGAEq1uHJr2/X1yxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaXpA6SX4OCwRvl0+77HJqDJYPPAtCgwmWemHCkMpkuup8b4u9UXHztiV2HXSfmcv
         +dYMOIMOt0FvoW0cpEL3UgHsEFG6wqSrcWUOzQJKJPL/S0AWxsLXGNiKWHcifm1FDJ
         6tuOesWrFDNw0U3ewyI8vyvv4IrAlU+Yq6N/WFM4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 38/38] ASoC: samsung: smdk_wm8994: remove redundant of_match_ptr()
Date:   Fri, 20 Nov 2020 17:16:52 +0100
Message-Id: <20201120161653.445521-38-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device() already handles properly !CONFIG_OF case, so passing
the argument via of_match_ptr() is not needed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/smdk_wm8994.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
index 696ab6abd1f6..8166e41e685b 100644
--- a/sound/soc/samsung/smdk_wm8994.c
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -170,7 +170,7 @@ static int smdk_audio_probe(struct platform_device *pdev)
 		smdk_dai[0].platforms->of_node = smdk_dai[0].cpus->of_node;
 	}
 
-	id = of_match_device(of_match_ptr(samsung_wm8994_of_match), &pdev->dev);
+	id = of_match_device(samsung_wm8994_of_match, &pdev->dev);
 	if (id)
 		*board = *((struct smdk_wm8994_data *)id->data);
 
-- 
2.25.1

