Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B4A2BB00B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgKTQTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:19:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbgKTQTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:19:20 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4543238E6;
        Fri, 20 Nov 2020 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889160;
        bh=+j1OMI4byGz3lhkFhbKgRErhPASUUpHiO1mBssgMMAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAmJZUQtRR6NeoLmC45vn0OLu2Hghp+k74GpwUVn4mFlh0HOiVp3CRsIXmowF19l4
         XB5k10Xi+YHf1YkVsT27vAHgZtKOdKUncqHqgwi/1xknpYMqinDkEfQ4SIeho0c+Uc
         vOySrgXO3ZAnKUThh0gMqSQ6IyjHyIH0/8aZroMo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 27/38] ASoC: pcm179x: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:41 +0100
Message-Id: <20201120161653.445521-27-krzk@kernel.org>
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

  sound/soc/codecs/pcm179x-i2c.c:33:34: warning: ‘pcm179x_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/pcm179x-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/pcm179x-i2c.c b/sound/soc/codecs/pcm179x-i2c.c
index 36e01678bef4..34a3d596f288 100644
--- a/sound/soc/codecs/pcm179x-i2c.c
+++ b/sound/soc/codecs/pcm179x-i2c.c
@@ -30,11 +30,13 @@ static int pcm179x_i2c_probe(struct i2c_client *client,
 	return pcm179x_common_init(&client->dev, regmap);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id pcm179x_of_match[] = {
 	{ .compatible = "ti,pcm1792a", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pcm179x_of_match);
+#endif
 
 static const struct i2c_device_id pcm179x_i2c_ids[] = {
 	{ "pcm179x", 0 },
-- 
2.25.1

