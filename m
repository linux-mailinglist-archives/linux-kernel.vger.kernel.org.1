Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8792BB00A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgKTQTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:19:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbgKTQTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:19:17 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B1322269;
        Fri, 20 Nov 2020 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889156;
        bh=JZdCvslmdZjGvWjDcbc1iXckf5mLTjz/4L3axX6TOLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZgCd1/fwhghbockXSnxLa+zrQpyJCe0NL7XOPefjlSdZ3oiS4al7SJjDlnM2X/lQW
         78EMDCuzcvf07/em8HzUoSyC6AhU/0Apksvl3ER3ThqRbBkcTeWKVRxRHraRMK3gIl
         1tteWt04jG1wMT4LXZx9xDd1OnsUZE7PlOa7JL6k=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 26/38] ASoC: pcm1789: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:40 +0100
Message-Id: <20201120161653.445521-26-krzk@kernel.org>
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

  sound/soc/codecs/pcm1789-i2c.c:36:34: warning: ‘pcm1789_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/pcm1789-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/pcm1789-i2c.c b/sound/soc/codecs/pcm1789-i2c.c
index 327ec584f240..7a6be45f8149 100644
--- a/sound/soc/codecs/pcm1789-i2c.c
+++ b/sound/soc/codecs/pcm1789-i2c.c
@@ -33,11 +33,13 @@ static int pcm1789_i2c_remove(struct i2c_client *client)
 	return pcm1789_common_exit(&client->dev);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id pcm1789_of_match[] = {
 	{ .compatible = "ti,pcm1789", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pcm1789_of_match);
+#endif
 
 static const struct i2c_device_id pcm1789_i2c_ids[] = {
 	{ "pcm1789", 0 },
-- 
2.25.1

