Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B572BB013
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgKTQTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbgKTQTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:19:43 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B38D2408E;
        Fri, 20 Nov 2020 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889182;
        bh=evb6wjGRVMwrWJRqEySL6t4LzK9d/Rg6xYP1e4Vt620=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHxY6yDE1rg6TPjAUR4pvA1eKCHn2JKmG1cx7McdjEANBo+yt1PCJM4d6dOqbG0ip
         2h5f/mgPxao2TkncQLmtdB3tWN3nyucKDgG9bK6fqtJJqj0r2LnHSzJANbcYFqW56A
         GCML3GdaINH8gaS1ctG9GlEJUvAvGRaEf1Kvu5a4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 31/38] ASoC: ts3a227e: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:45 +0100
Message-Id: <20201120161653.445521-31-krzk@kernel.org>
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

  sound/soc/codecs/ts3a227e.c:369:34: warning: ‘ts3a227e_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/ts3a227e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 3ed3b45fa7ba..962f5d48378a 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -366,11 +366,13 @@ static const struct i2c_device_id ts3a227e_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ts3a227e_i2c_ids);
 
+#ifdef CONFIG_OF
 static const struct of_device_id ts3a227e_of_match[] = {
 	{ .compatible = "ti,ts3a227e", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ts3a227e_of_match);
+#endif
 
 #ifdef CONFIG_ACPI
 static struct acpi_device_id ts3a227e_acpi_match[] = {
-- 
2.25.1

