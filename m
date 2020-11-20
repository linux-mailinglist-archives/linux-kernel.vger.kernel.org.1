Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E892BAFF5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgKTQSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbgKTQSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:32 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66315223FD;
        Fri, 20 Nov 2020 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889111;
        bh=0HugLJZa8zS4Le6aM6WdEG5ldLVgwL6aMNqW9XESAyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4WsHIiqUTGnjcpfkaCLf2SIVQPqJCkTuJcVG9dBcikacJujLkakkWoWFU8LKB0YJ
         kCiZFWoSSlT34pjSDM2iENswJzkt+hZuegWwUHREkcbqYKpBd7E6OY3qNhRoK7LXmL
         WiSxJklRnv+aTiMxJnmMtnVFonJDqm6G2dIF+NwI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 13/38] ASoC: ak4118: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:27 +0100
Message-Id: <20201120161653.445521-13-krzk@kernel.org>
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

  sound/soc/codecs/ak4118.c:407:34: warning: ‘ak4118_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/ak4118.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/ak4118.c b/sound/soc/codecs/ak4118.c
index f44d9a4a8507..5d46ae85566c 100644
--- a/sound/soc/codecs/ak4118.c
+++ b/sound/soc/codecs/ak4118.c
@@ -404,11 +404,13 @@ static int ak4118_i2c_probe(struct i2c_client *i2c,
 				&soc_component_drv_ak4118, &ak4118_dai, 1);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id ak4118_of_match[] = {
 	{ .compatible = "asahi-kasei,ak4118", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ak4118_of_match);
+#endif
 
 static const struct i2c_device_id ak4118_id_table[] = {
 	{ "ak4118", 0 },
-- 
2.25.1

