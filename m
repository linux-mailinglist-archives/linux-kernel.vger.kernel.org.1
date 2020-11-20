Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B23C2BAFE7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgKTQSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgKTQSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:00 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 205252240B;
        Fri, 20 Nov 2020 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889080;
        bh=ChOCDUScCs5YAoH84wIqNvXhgQCuBvRtWLK6xI5v49s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3hmm2p0BsbPONUDoqU01jkZGX1KKmLwFSnBX0jIv3YFhxUh4wyrbFfM3qYuhW5+R
         ephwVApyEEx6NJ60RAl4zNVD+EtuWmUJy5aP4WTggCJn5/u/uS93Z6l3Fn3vhkREXT
         0s1wga/1JhFQqGQrSuk2SxHl5hjNsD9XVM0UYiaA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 04/38] ASoC: rk3328: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:16:18 +0100
Message-Id: <20201120161653.445521-4-krzk@kernel.org>
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

  sound/soc/codecs/rk3328_codec.c:502:34: warning: ‘rk3328_codec_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/rk3328_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rk3328_codec.c b/sound/soc/codecs/rk3328_codec.c
index 940a2fa933ed..d955525b0354 100644
--- a/sound/soc/codecs/rk3328_codec.c
+++ b/sound/soc/codecs/rk3328_codec.c
@@ -508,7 +508,7 @@ MODULE_DEVICE_TABLE(of, rk3328_codec_of_match);
 static struct platform_driver rk3328_codec_driver = {
 	.driver = {
 		   .name = "rk3328-codec",
-		   .of_match_table = of_match_ptr(rk3328_codec_of_match),
+		   .of_match_table = rk3328_codec_of_match,
 	},
 	.probe = rk3328_platform_probe,
 };
-- 
2.25.1

