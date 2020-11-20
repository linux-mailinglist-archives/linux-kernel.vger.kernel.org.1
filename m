Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F9E2BB046
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgKTQSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbgKTQSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:42 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48E56238E6;
        Fri, 20 Nov 2020 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889121;
        bh=sO3ez0EZ5UNNfG4j2+8DCfucIft1SFisc/XRA8bljPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iu2G6q/lFfrOFsxMq4VY+LtkGiDw6vywWtAHTWo8BJpJ35bD23Z6Wk4nM8YbTsefq
         SjGUZM6xEW/6Y4PA14wQ1VBy+ZEiRo6de7xR5ddPh8PUm0yVk9r6BHMD3Du3u7vi2W
         uh3oKk+SOCq24uPaKwce9aEdv8Qzj/E/ydvtZM90=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 16/38] ASoC: da7218: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:30 +0100
Message-Id: <20201120161653.445521-16-krzk@kernel.org>
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

  sound/soc/codecs/da7218.c:2281:34: warning: ‘da7218_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/da7218.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 6d78bccb55c3..2bfafbe9e3dc 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -2278,12 +2278,14 @@ static irqreturn_t da7218_irq_thread(int irq, void *data)
  * DT
  */
 
+#ifdef CONFIG_OF
 static const struct of_device_id da7218_of_match[] = {
 	{ .compatible = "dlg,da7217", .data = (void *) DA7217_DEV_ID },
 	{ .compatible = "dlg,da7218", .data = (void *) DA7218_DEV_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da7218_of_match);
+#endif
 
 static inline int da7218_of_get_id(struct device *dev)
 {
-- 
2.25.1

