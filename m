Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267FE23DBD6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 18:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgHFQeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 12:34:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50371 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgHFQdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:33:25 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k3dUk-00067j-86; Thu, 06 Aug 2020 10:51:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb: fix spelling mistake "buss" -> "bus"
Date:   Thu,  6 Aug 2020 11:51:34 +0100
Message-Id: <20200806105134.46447-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a usb_audio_dbg debug message. Also
replace "param" with "parameter".  Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/mixer_us16x08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 986145fd2ce0..a4d4d71db55b 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -329,7 +329,7 @@ static int snd_us16x08_bus_put(struct snd_kcontrol *kcontrol,
 		elem->cached |= 1;
 		elem->cache_val[0] = val;
 	} else {
-		usb_audio_dbg(chip, "Failed to set buss param, err:%d\n", err);
+		usb_audio_dbg(chip, "Failed to set bus parameter, err:%d\n", err);
 	}
 
 	return err > 0 ? 1 : 0;
-- 
2.27.0

