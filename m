Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B366E2B35D5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 16:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgKOPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 10:39:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36270 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgKOPjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 10:39:10 -0500
Received: from 61-220-137-34.hinet-ip.hinet.net ([61.220.137.34] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1keK7B-0007bG-AP; Sun, 15 Nov 2020 15:38:54 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Chris Wulff <crwulff@gmail.com>,
        Alexander Tsoy <alexander@tsoy.me>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andrew Oakley <andrew@adoakley.name>,
        Chris Boyle <chris@boyle.name>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: usb-audio: Use ALC1220-VB-DT mapping for ASUS ROG Strix TRX40 mobo
Date:   Sun, 15 Nov 2020 23:38:42 +0800
Message-Id: <20201115153843.1109200-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS ROG Strix also uses ALC1220-VB-DT, so adjust the mapping and add
profile name to let userspace pick correct UCM profile.

BugLink: https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/1031
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/card.c       | 4 ++++
 sound/usb/mixer_maps.c | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index fa764b61fe9c..4457214a3ae6 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -379,6 +379,10 @@ static const struct usb_audio_device_name usb_audio_names[] = {
 
 	DEVICE_NAME(0x046d, 0x0990, "Logitech, Inc.", "QuickCam Pro 9000"),
 
+	/* ASUS ROG Strix */
+	PROFILE_NAME(0x0b05, 0x1917,
+		     "Realtek", "ALC1220-VB-DT", "Realtek-ALC1220-VB-Desktop"),
+
 	/* Dell WD15 Dock */
 	PROFILE_NAME(0x0bda, 0x4014, "Dell", "WD15 Dock", "Dell-WD15-Dock"),
 	/* Dell WD19 Dock */
diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index c369c81e74c4..a7212f16660e 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -561,7 +561,8 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 	},
 	{	/* ASUS ROG Strix */
 		.id = USB_ID(0x0b05, 0x1917),
-		.map = asus_rog_map,
+		.map = trx40_mobo_map,
+		.connector_map = trx40_mobo_connector_map,
 	},
 	{	/* MSI TRX40 Creator */
 		.id = USB_ID(0x0db0, 0x0d64),
-- 
2.28.0

