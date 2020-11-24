Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA5C2C2109
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbgKXJVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgKXJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:20:59 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296E9C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:20:59 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id y7so17875700pfq.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MSd8fQ2Z7XOPGPcHecwDpB20TgWxQRqNoHhLdX8IkDc=;
        b=RfMftqQOg85uPUKLl6YdeCX0mc3SF9t2JFSQ1rldu4uEdWfAXlzm41oxlWsU2wasxa
         9yT3w5ywWsqAcJ8+ghNFxDVUpTU6C14FOD7TPPNZ74gy0F9hQfgaW5GtMqEosO98gYnm
         Vq1pWRHCpEDThA5OxNUv6oeX6UurJW2gqQo6L6QRX8di5MSKFaTDasm9oU77xaafZST+
         Mx+C7cb/nPGmx8GaU6gEnn7DX1GV7aoIXyhKEDS5nOom6hDswCOrEJXLKL0VjLE6+unm
         gYe2oq9go5lPoyq1kwl0xDidIns1rvqdHqFrEhBwFRhmFVs7LGmHNVoLEaoQlU5cK8DM
         ljpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MSd8fQ2Z7XOPGPcHecwDpB20TgWxQRqNoHhLdX8IkDc=;
        b=RVVSleMyhQVd2mv5j2BU+I+s0W3Tn9uZaOV3hXEPnDzSgmkOdALIntRJSLnmupBYbG
         1rqxyMpu03V/tz+j8Ag+f9j2i3Son0X/22UzkCBDrKnYUxyl1mOsMppgPBQJQ3AQqHrH
         r6qybvSA5Ds7P86nobckM0Rr19h9GO0Xv2gfJyran4ZAD7iPw4J5UOHM1b6OqMv5VEn/
         mFsXabAcYdFS+ryvDLqETlSDIl4rClQA+g2cpOTrg91nPrir/e0BOQ2APPRQOfwLnza7
         u3GTmW+0bitGAN5T88noa6sR1EQn3M9m3kaA0LG3uu5R1kcRDF9EhnnGIsPyozKHu6x+
         1WbA==
X-Gm-Message-State: AOAM530KH5tdAPU07OP3CNeUmf3ZRihX40vqGdCIvVXKukP6h1AXFA19
        vC+wegTOj61qf5opXmU1cgx0vw==
X-Google-Smtp-Source: ABdhPJyfwkxJ8xWTVoSEl+yofIYURTHESQSLyF3ib8fdGmtTbBkmesBixh3nX12Eqvq22JXS3MALvw==
X-Received: by 2002:a63:1959:: with SMTP id 25mr2937986pgz.201.1606209658665;
        Tue, 24 Nov 2020 01:20:58 -0800 (PST)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id w9sm2417709pjq.0.2020.11.24.01.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 01:20:58 -0800 (PST)
From:   Jian-Hong Pan <jhp@endlessos.org>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessos.org,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH] ALSA: hda/realtek: Enable headset of ASUS UX482EG & B9400CEA with ALC294
Date:   Tue, 24 Nov 2020 17:20:25 +0800
Message-Id: <20201124092024.179540-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some laptops like ASUS UX482EG & B9400CEA's headset audio does not work
until the quirk ALC294_FIXUP_ASUS_HPE is applied.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 739dbaf54517..1aafc55f1505 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8585,6 +8585,9 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0293, 0x1028, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC292_STANDARD_PINS,
 		{0x13, 0x90a60140}),
+	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_HPE,
+		{0x17, 0x90170110},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_MIC,
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},
-- 
2.29.2

