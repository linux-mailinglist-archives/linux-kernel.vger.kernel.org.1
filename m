Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786711C2615
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 16:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgEBO0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 10:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgEBO0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 10:26:49 -0400
Received: from localhost (p5486C608.dip0.t-ipconnect.de [84.134.198.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6E2621835;
        Sat,  2 May 2020 14:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588429609;
        bh=gfo0+53nZKqY2J8lkt8Dedhyctwf66+BUftOGRVc4vA=;
        h=From:To:Cc:Subject:Date:From;
        b=Wcdl4Zu8Xe1B1O2RTQI8v0aI66PyZSi1nmiDTcuJ8nWK7NgaEsR3LsirhAxLWoSQy
         maAx7jvV8ExDAXp+ckA1cBePnheG+U3raL0F4bRmSdLVgF9a0tAW5Vjl/VRl/On+P2
         mw00w/HGZDarPGlQ+lL1smIuYY6IceH06RZOH9G0=
From:   Wolfram Sang <wsa@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, Wolfram Sang <wsa@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: codecs: max9768: update contact email
Date:   Sat,  2 May 2020 16:26:46 +0200
Message-Id: <20200502142646.19033-1-wsa@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'pengutronix' address is defunct for years. Use the proper contact
address.

Signed-off-by: Wolfram Sang <wsa@kernel.org>
---
 sound/soc/codecs/max9768.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index d0737db5868a..39dda1b03b3d 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -220,6 +220,6 @@ static struct i2c_driver max9768_i2c_driver = {
 };
 module_i2c_driver(max9768_i2c_driver);
 
-MODULE_AUTHOR("Wolfram Sang <w.sang@pengutronix.de>");
+MODULE_AUTHOR("Wolfram Sang <kernel@pengutronix.de>");
 MODULE_DESCRIPTION("ASoC MAX9768 amplifier driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

