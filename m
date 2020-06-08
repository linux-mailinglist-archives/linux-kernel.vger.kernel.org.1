Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9451F12D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 08:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgFHG0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 02:26:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45828 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbgFHG0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:26:54 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jiBEx-0003lu-Q2; Mon, 08 Jun 2020 06:26:36 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Alexander Tsoy <alexander@tsoy.me>,
        Stefan Sauer <ensonic@google.com>,
        Gregor Pintar <grpintar@gmail.com>,
        Dmitry Panchenko <dmitry@d-systems.ee>,
        Ard van Breemen <ard@kwaak.net>,
        =?UTF-8?q?Franti=C5=A1ek=20Ku=C4=8Dera?= <franta-linux@frantovo.cz>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: usb-audio: Add vendor, product and profile name for HP Thunderbolt Dock
Date:   Mon,  8 Jun 2020 14:26:28 +0800
Message-Id: <20200608062630.10806-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP Thunderbolt Dock has two separate USB devices, one is for speaker
and one is for headset. Add names for them so userspace can apply UCM
settings.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/quirks-table.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 6d6492195bdc..90d65bfa733d 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -40,6 +40,26 @@
 		.ifnum = QUIRK_NO_INTERFACE				\
 	}
 
+/* HP Thunderbolt Dock Audio Headset */
+{
+	USB_DEVICE(0x03f0, 0x0269),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "HP",
+		.product_name = "Thunderbolt Dock Audio Headset",
+		.profile_name = "HP-Thunderbolt-Dock-Audio-Headset",
+		.ifnum = QUIRK_NO_INTERFACE
+	}
+},
+/* HP Thunderbolt Dock Audio Module */
+{
+	USB_DEVICE(0x03f0, 0x0567),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "HP",
+		.product_name = "Thunderbolt Dock Audio Module",
+		.profile_name = "HP-Thunderbolt-Dock-Audio-Module",
+		.ifnum = QUIRK_NO_INTERFACE
+	}
+},
 /* FTDI devices */
 {
 	USB_DEVICE(0x0403, 0xb8d8),
-- 
2.17.1

