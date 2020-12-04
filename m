Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC54A2CE9F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgLDIhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:37:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgLDIhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:37:11 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Tzung-Bi Shih <tzungbi@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <groeck@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ASoC: cros_ec_codec: fix uninitialized memory read
Date:   Fri,  4 Dec 2020 09:36:11 +0100
Message-Id: <20201204083624.2711356-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc points out a memory area that is copied to a device
but not initialized:

sound/soc/codecs/cros_ec_codec.c: In function 'i2s_rx_event':
arch/x86/include/asm/string_32.h:83:20: error: '*((void *)&p+4)' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   83 |   *((int *)to + 1) = *((int *)from + 1);

Change the length of the command to only pass down the
part of the structure that has been initialized, as
Tzung-Bi Shih explains that only that member is meant to
be used.

Cc: Tzung-Bi Shih <tzungbi@google.com>
Fixes: 727f1c71c780 ("ASoC: cros_ec_codec: refactor I2S RX")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/cros_ec_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 58894bf47514..6ec673573c70 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -348,7 +348,7 @@ static int i2s_rx_event(struct snd_soc_dapm_widget *w,
 	}
 
 	return send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
-				    (uint8_t *)&p, sizeof(p), NULL, 0);
+				    &p.cmd, sizeof(p.cmd), NULL, 0);
 }
 
 static struct snd_soc_dapm_widget i2s_rx_dapm_widgets[] = {
-- 
2.27.0

