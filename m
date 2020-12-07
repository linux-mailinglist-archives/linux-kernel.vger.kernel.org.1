Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB902D0B1E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgLGHaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLGHaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:30:14 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830BCC0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 23:29:34 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id l23so6933021pjg.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 23:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eiXnTypx8iGHIDHIpH1IqsjSnkTqPj/jp8psF8GKGy0=;
        b=iWBTJq5CjoMlZFZhqFEKiDqt6rcSYwjwk4CTH+p9nD+eLKAiX5IYedxQDbp478e3q4
         Fha9ke1nTNbO2cxiNsxcEYCFL8Yv7VatnzbFR4HQyjii/Pug1EOzlsJC98s9ZF/T1FZQ
         y05gjA/L+0Wck547YPostvoKm5uCCUqctc/yEgqDo1mBClPGjRqLlODxJO4Xn3IqCAO9
         VBvhgxD1ON/+hA8PfRbTGcOfZDSKEEphScGMi+osekIzg1T5VwJWlrYHT4GHNYc6bByo
         w8VdQDlfVg1UfTD77Q0osiznxVeVg9JrNSEqEFNL/XY3YpUguj70vONpY6deuXBopdKp
         4QUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eiXnTypx8iGHIDHIpH1IqsjSnkTqPj/jp8psF8GKGy0=;
        b=WkMoc2USxEPHvV8VHPahFaqXbDiNG75Lx7Gb0vombk3AYwBVwfhfXRKqV5FBrLEOoM
         ISOys43JlDTASUH/iFiGOfs2L3z0BMu8zLNH9ZyE6L9/vaFOKpaYXPd/eXouL9hy3qgZ
         ajH6oZwBrNmGYDfklxa750ZQwqZRJUg9XPlPhsElrf9cN1mtG35nDJn3EtkOC/9vdeXr
         dNzGU7y6EMpGBnoBQo26z3R/me9yodkjM4q1fHyI6lPUObAheUegS9wErzYA/gNuP5XP
         nBs/DwzY9ZYx49Whgi3A/unyPdpRyvIzByuFEOF0nBT0MgKKrVszVffW7EdHVHhyoo9Z
         EwyA==
X-Gm-Message-State: AOAM5321WG9nBWjHix57mgDB3lWltgSyXSoEh37954hei2h1WGuxEEms
        KskdBiy+dgXvYJ58PnfQQaOWLg==
X-Google-Smtp-Source: ABdhPJxvxHIAFCQCx15Tya3R2k3ZaOTIlbHT9aQLElluohJNraqQReVL7NirnXVrug7oxXL/qdmBuQ==
X-Received: by 2002:a17:90b:1945:: with SMTP id nk5mr15258577pjb.30.1607326174019;
        Sun, 06 Dec 2020 23:29:34 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id k23sm12736969pfk.50.2020.12.06.23.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 23:29:33 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH] ALSA: hda/realtek - Enable headset mic of ASUS X430UN with ALC256
Date:   Mon,  7 Dec 2020 15:27:55 +0800
Message-Id: <20201207072755.16210-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS laptop X430UN with ALC256 can't detect the headset microphone
until ALC256_FIXUP_ASUS_MIC_NO_PRESENCE quirk applied.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f2398721ac1e..d5e4d0ba1008 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7827,6 +7827,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x10d0, "ASUS X540LA/X540LJ", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x115d, "Asus 1015E", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x11c0, "ASUS X556UR", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x1271, "ASUS X430UN", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1290, "ASUS X441SA", ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x12a0, "ASUS X441UV", ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_ASUS_MIC),
-- 
2.20.1

