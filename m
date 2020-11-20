Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CED92BAFF8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgKTQSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbgKTQSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:40 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C58262240B;
        Fri, 20 Nov 2020 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889119;
        bh=iiT953SPfN8VyA44unfiNSwE/7K2fqWVO8986O34OFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K9FIVYG95MUxggUa8XxW0HhorpQe7pDunWk90auWEo/lslkQZKXGoa/rR+Izm11og
         M62CZ6yHK7IClWOvTZZB3hBB6xfU/WOZKxVoLGB25wDPc1RI1dR1BhdfUBNtkELpCY
         KkTXJV43y2y7EaQE1kqTndDJl2MAur7uBxnKrQGU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 15/38] ASoC: alc5632: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:29 +0100
Message-Id: <20201120161653.445521-15-krzk@kernel.org>
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

  sound/soc/codecs/alc5632.c:1170:34: warning: ‘alc5632_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/alc5632.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 9d6dcd3ffa57..bde5ded67754 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -1167,11 +1167,13 @@ static const struct i2c_device_id alc5632_i2c_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, alc5632_i2c_table);
 
+#ifdef CONFIG_OF
 static const struct of_device_id alc5632_of_match[] = {
 	{ .compatible = "realtek,alc5632", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, alc5632_of_match);
+#endif
 
 /* i2c codec control layer */
 static struct i2c_driver alc5632_i2c_driver = {
-- 
2.25.1

