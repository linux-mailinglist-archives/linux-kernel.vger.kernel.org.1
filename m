Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20702268547
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 09:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgINHDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 03:03:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51263 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgINHDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 03:03:07 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kHiVX-0002Tq-2H; Mon, 14 Sep 2020 07:02:35 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Hui Wang <hui.wang@canonical.com>,
        Huacai Chen <chenhc@lemote.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda/realtek: Enable front panel headset LED on Lenovo ThinkStation P520
Date:   Mon, 14 Sep 2020 15:02:29 +0800
Message-Id: <20200914070231.13192-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Lenovo P520, the front panel headset LED isn't lit up right now.

Realtek states that the LED needs to be enabled by ALC233's GPIO2, so
let's do it accordingly to light the LED up.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c521a1f17096..ba941bd0b792 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6017,6 +6017,7 @@ static void alc_fixup_thinkpad_acpi(struct hda_codec *codec,
 #include "hp_x360_helper.c"
 
 enum {
+	ALC269_FIXUP_GPIO2,
 	ALC269_FIXUP_SONY_VAIO,
 	ALC275_FIXUP_SONY_VAIO_GPIO2,
 	ALC269_FIXUP_DELL_M101Z,
@@ -6194,6 +6195,10 @@ enum {
 };
 
 static const struct hda_fixup alc269_fixups[] = {
+	[ALC269_FIXUP_GPIO2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_gpio2,
+	},
 	[ALC269_FIXUP_SONY_VAIO] = {
 		.type = HDA_FIXUP_PINCTLS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -7013,6 +7018,8 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC233_FIXUP_LENOVO_MULTI_CODECS] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc233_alc662_fixup_lenovo_dual_codecs,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_GPIO2
 	},
 	[ALC233_FIXUP_ACER_HEADSET_MIC] = {
 		.type = HDA_FIXUP_VERBS,
-- 
2.17.1

