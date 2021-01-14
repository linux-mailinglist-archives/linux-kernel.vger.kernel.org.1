Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634CD2F5C62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbhANI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbhANI20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:28:26 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F58C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 00:27:40 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v3so2527073plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 00:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlp0Ya7zu9BzVSD7Qg7ivfoy7HFP536rfCtMI+DYOvY=;
        b=ohx/RaUXQ2dLL0l8qHkeqrFLndxV4612E0nM1uVgQK4CIvl1DR4jMu82wUJDogG44z
         kKHkmw1oHJYkpXU83dHC4T+af09UOSB4n7G+Nib+TRzNRRLKsjp2OvwNrxCHanubyh+U
         0QK/P59+DVU1yJVY1duwo3hmq1YoygDec7QmfcAUkFAKNMMNGJ3Xw/85J0568tMxXfiE
         rZLZNiQK7Z25wFU/j8kFkV41Ft508PfeBCtTw+VXTgjYX90WOtDjP1kYJNh3MizI37BV
         vATZDYOC6qqzQNNqI7Ym5kDQtaaKiYGZoa6eHnaO98f8qXMhpIBBTHO7BAGPP2auzs2N
         1k4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlp0Ya7zu9BzVSD7Qg7ivfoy7HFP536rfCtMI+DYOvY=;
        b=gB/IVn2msRU/9KRMPQmzb2frJHyt/0PsRHr5sf8cYfnXkNwlxDeAZym1pLVUJzhINp
         jH9J7YLPJRZodUqSk0brPt4WC+AQP1Ugi1AkIWKd4UscVAH3zq7wb0pPMlefNZGEfp8m
         KCdo4v4VwlF3o72qYlwlsC68EmZJo6ZGinTyzGsUymp6lYGO/UCfbVwZpy+EiJbBSJSu
         KX/GDAXKfBrQWt8LXlQkSsE/SmqWaXKhy5qNn4T3CYL2hiJXhEthsEVx9bU+1wS5Ca0V
         Th1p8QZPUn2DrjLuSiVqkU9+gSnZPOggVa81gTAOO+bT7yqfIt2zdBLQx5QBrxZ0TZg+
         vLcA==
X-Gm-Message-State: AOAM531ZXXoTyBVUUbMMbQDqDyMfbqXSWasL8Qzt8fRS3Nz7mHDsKLzz
        xT0pFrVdX+LEvB+OzivrW7lpLQ==
X-Google-Smtp-Source: ABdhPJzAlRrFZ6HBqyY7D5bN2DQri3LbmVWP1G6yVxzSCc53B+OeI1jYBH7Aaubf+PudSy+VDfaTkg==
X-Received: by 2002:a17:902:7793:b029:da:d44d:1968 with SMTP id o19-20020a1709027793b02900dad44d1968mr6696098pll.47.1610612860074;
        Thu, 14 Jan 2021 00:27:40 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id x23sm4591418pgk.14.2021.01.14.00.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 00:27:39 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH] ALSA: hda/realtek - Limit int mic boost on Acer Aspire E5-575T
Date:   Thu, 14 Jan 2021 16:27:28 +0800
Message-Id: <20210114082728.74729-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Acer Apire E5-575T laptop with codec ALC255 has a terrible
background noise comes from internal mic capture. And the jack
sensing dose not work for headset like some other Acer laptops.

This patch limits the internal mic boost on top of the existing
ALC255_FIXUP_ACER_MIC_NO_PRESENCE quirk for Acer Aspire E5-575T.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 sound/pci/hda/patch_realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3c1d2a3fb1a4..60eb8383a704 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6371,6 +6371,7 @@ enum {
 	ALC256_FIXUP_HP_HEADSET_MIC,
 	ALC236_FIXUP_DELL_AIO_HEADSET_MIC,
 	ALC282_FIXUP_ACER_DISABLE_LINEOUT,
+	ALC255_FIXUP_ACER_LIMIT_INT_MIC_BOOST,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7808,6 +7809,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE
 	},
+	[ALC255_FIXUP_ACER_LIMIT_INT_MIC_BOOST] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_limit_int_mic_boost,
+		.chained = true,
+		.chain_id = ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7826,6 +7833,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1065, "Acer Aspire C20-820", ALC269VC_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
+	SND_PCI_QUIRK(0x1025, 0x1094, "Acer Aspire E5-575T", ALC255_FIXUP_ACER_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1025, 0x1099, "Acer Aspire E5-523G", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x110e, "Acer Aspire ES1-432", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1166, "Acer Veriton N4640G", ALC269_FIXUP_LIFEBOOK),
-- 
2.20.1

