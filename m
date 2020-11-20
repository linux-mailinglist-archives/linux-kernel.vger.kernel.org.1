Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EA92BB004
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgKTQTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:36424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbgKTQS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:59 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F8B424101;
        Fri, 20 Nov 2020 16:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889138;
        bh=3c6rCQg3s9pP9r49SYDWD3DSdrQ2njFVAGckFzgPq0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAZ1G5N81Oe+yFCRXPExwNod7fyv8UdQ5BnXF/hb6vtDoy4WiKPcmabg3cvAMkX5A
         sksR0NgAKXKvXIu6JnpK4PmV6u4/CH6wk2MQMVv67+xVOugf8S1cDENgzfXlZGCoe6
         gc//ovme0YL6yVdZOS7tKiuBq4+MEQrX2FUVpDbo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 21/38] ASoC: max98095: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:35 +0100
Message-Id: <20201120161653.445521-21-krzk@kernel.org>
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

  sound/soc/codecs/max98095.c:2151:34: warning: ‘max98095_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/max98095.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 9bdc6392382a..736cd70be725 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2148,11 +2148,13 @@ static const struct i2c_device_id max98095_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max98095_i2c_id);
 
+#ifdef CONFIG_OF
 static const struct of_device_id max98095_of_match[] = {
 	{ .compatible = "maxim,max98095", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max98095_of_match);
+#endif
 
 static struct i2c_driver max98095_i2c_driver = {
 	.driver = {
-- 
2.25.1

