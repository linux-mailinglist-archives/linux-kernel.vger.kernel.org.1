Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E852BB012
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgKTQTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:19:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728819AbgKTQTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:19:39 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B1D724178;
        Fri, 20 Nov 2020 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889179;
        bh=WHszfzaet9THpQ07YzL3T8dCwt/v5KzLv3SE9+AV0Kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k6eKiic/ZVCN5JhVNd2H0OoIkVGtg88cRs2iQKlJ/8z3Y9INqtIpsGA4d+008iP4U
         M24BevRs39LgboeB6yyQBaB3kx7a6KdhY6eaPOOpLamvcRmkLYzKj6/uzQkqbUGsn/
         iX7qfbEIZMyFRJ46DU9bVzGAEc3fNlwJGw94DRvY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Dan Murphy <dmurphy@ti.com>,
        Camel Guo <camelg@axis.com>
Subject: [PATCH 30/38] ASoC: tlv320: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:44 +0100
Message-Id: <20201120161653.445521-30-krzk@kernel.org>
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

  sound/soc/codecs/tlv320aic23-i2c.c:38:34: warning: ‘tlv320aic23_of_match’ defined but not used [-Wunused-const-variable=]
  sound/soc/codecs/tlv320adcx140.c:1076:34: warning: ‘tlv320adcx140_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/tlv320adcx140.c   | 2 ++
 sound/soc/codecs/tlv320aic23-i2c.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 53a80246aee1..3f027c8234a6 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -1073,6 +1073,7 @@ static struct snd_soc_dai_driver adcx140_dai_driver[] = {
 	}
 };
 
+#ifdef CONFIG_OF
 static const struct of_device_id tlv320adcx140_of_match[] = {
 	{ .compatible = "ti,tlv320adc3140" },
 	{ .compatible = "ti,tlv320adc5140" },
@@ -1080,6 +1081,7 @@ static const struct of_device_id tlv320adcx140_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, tlv320adcx140_of_match);
+#endif
 
 static int adcx140_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
diff --git a/sound/soc/codecs/tlv320aic23-i2c.c b/sound/soc/codecs/tlv320aic23-i2c.c
index 5025e5c43783..dbb8f969274c 100644
--- a/sound/soc/codecs/tlv320aic23-i2c.c
+++ b/sound/soc/codecs/tlv320aic23-i2c.c
@@ -35,11 +35,13 @@ static const struct i2c_device_id tlv320aic23_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, tlv320aic23_id);
 
+#ifdef CONFIG_OF
 static const struct of_device_id tlv320aic23_of_match[] = {
 	{ .compatible = "ti,tlv320aic23", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tlv320aic23_of_match);
+#endif
 
 static struct i2c_driver tlv320aic23_i2c_driver = {
 	.driver = {
-- 
2.25.1

