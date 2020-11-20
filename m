Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CF22BAFEA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgKTQSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbgKTQSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:11 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E05472245F;
        Fri, 20 Nov 2020 16:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889091;
        bh=J7blZK/cQ3ZmyizEP/d5i6nwcrycLSH9do8+EQTrnvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oyp1w20Kw1+RhiKRTJPAXIyfn0T8xpfiE5F4+TNUDI/oON7uP3oNzlHQaE0wUt8aH
         00Dd7UYt0uF1WEEnTeh3YxFTn5Ck23fO2C4IPlPQOSw9tQsxKnMz+moFwx1oJfqapx
         nV9LNOrMbRA/oVCrOIHlP6+oXLzAicRUdmSARDhk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 07/38] ASoC: meson: t9015: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:16:21 +0100
Message-Id: <20201120161653.445521-7-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).  This fixes
compile warning (!CONFIG_OF on x86_64):

  sound/soc/meson/t9015.c:315:34: warning: ‘t9015_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/meson/t9015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/t9015.c b/sound/soc/meson/t9015.c
index 56d2592c16d5..0532a2b8c240 100644
--- a/sound/soc/meson/t9015.c
+++ b/sound/soc/meson/t9015.c
@@ -321,7 +321,7 @@ MODULE_DEVICE_TABLE(of, t9015_ids);
 static struct platform_driver t9015_driver = {
 	.driver = {
 		.name = "t9015-codec",
-		.of_match_table = of_match_ptr(t9015_ids),
+		.of_match_table = t9015_ids,
 	},
 	.probe = t9015_probe,
 };
-- 
2.25.1

