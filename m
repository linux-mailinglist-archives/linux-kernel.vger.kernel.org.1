Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1282BB008
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgKTQTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:19:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729494AbgKTQTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:19:09 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35155223BE;
        Fri, 20 Nov 2020 16:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889149;
        bh=LwuY+QphNSlol8EMRcR5P6MUxE335Jn/IU89vq73g8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0XpUs8fjYpRuS6/6EM+734ir+JsthvaJX5ckkJRq1U9Kn0EdeSlrYp7XTgug5oiP9
         b56YQZDww61i7Sqsg6z6Z23h7zloesVU4cDcrEZfbM4iXcQg6ezGkQnglW2Y3DO/1Q
         i4uSoddqCNfGsOR8rEfpf+60iDqO23khb7UZbS84=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 24/38] ASoC: max98925: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:38 +0100
Message-Id: <20201120161653.445521-24-krzk@kernel.org>
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

  sound/soc/codecs/max98925.c:630:34: warning: ‘max98925_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/max98925.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index b3e1a54fff88..e18d0022c3f4 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -627,11 +627,13 @@ static const struct i2c_device_id max98925_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max98925_i2c_id);
 
+#ifdef CONFIG_OF
 static const struct of_device_id max98925_of_match[] = {
 	{ .compatible = "maxim,max98925", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max98925_of_match);
+#endif
 
 static struct i2c_driver max98925_i2c_driver = {
 	.driver = {
-- 
2.25.1

