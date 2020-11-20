Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057892BB000
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgKTQSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgKTQSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:51 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB4A422D0A;
        Fri, 20 Nov 2020 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889130;
        bh=P+vy5VoZ2F85soXfnFUh9AixDyXElRDgch2cjs4F6Is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFPHGAxvywvtyjufvhmejf5xCuap0U8vCCa/Y4kerIpsTO8ZY/XvScJ547FdtxtCt
         LXqgDgKvolHqpRKgG4rTndeNpG8QMcc9Ro05s3bcV0l4L55904q2uBJrd6ryHjGbTE
         3HbDxUUr98DoD4tmFJN0X5NM0a17JsBONFGrSxcM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 19/38] ASoC: es8316: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:33 +0100
Message-Id: <20201120161653.445521-19-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match by multiple methods.  Its of_device_id table is
referenced via of_match_ptr() so it will be unused for !CONFIG_OF
builds:

  sound/soc/codecs/es8316.c:837:34: warning: ‘es8316_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/es8316.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index bd5d230c5df2..f9ec5cf82599 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -834,11 +834,13 @@ static const struct i2c_device_id es8316_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, es8316_i2c_id);
 
+#ifdef CONFIG_OF
 static const struct of_device_id es8316_of_match[] = {
 	{ .compatible = "everest,es8316", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, es8316_of_match);
+#endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id es8316_acpi_match[] = {
-- 
2.25.1

