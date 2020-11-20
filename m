Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F209D2BB00F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgKTQTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:19:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729454AbgKTQSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:55 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AAC02245B;
        Fri, 20 Nov 2020 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889135;
        bh=pK2aXxPdlgp8adWwLZSWyw3m60lda9J3oEtug2jUDCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EAjomR1lz/jTDyJe2lPCvCIEC8I18OrztlCe1eDcsXdKbxTD6x9flsZsDNk/z/GyP
         GCY5upWeOINt6mbHm3h5UyJXdVvAxa9nAiLG/9DstU8uiugAbM/zoguc8Dr+Jc4zQl
         21E44+uleClrd4f+O/I6QyTTgz5MCrsPetTM/+bE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 20/38] ASoC: max98090: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:34 +0100
Message-Id: <20201120161653.445521-20-krzk@kernel.org>
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

  sound/soc/codecs/max98090.c:2671:34: warning: ‘max98090_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/max98090.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 945a79e4f3eb..06276ff5f8a3 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2668,12 +2668,14 @@ static const struct i2c_device_id max98090_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max98090_i2c_id);
 
+#ifdef CONFIG_OF
 static const struct of_device_id max98090_of_match[] = {
 	{ .compatible = "maxim,max98090", },
 	{ .compatible = "maxim,max98091", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max98090_of_match);
+#endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id max98090_acpi_match[] = {
-- 
2.25.1

