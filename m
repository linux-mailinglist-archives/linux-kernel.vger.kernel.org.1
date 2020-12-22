Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14582E0C60
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgLVPFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgLVPFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:05:46 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D72EC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 07:05:06 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id c22so8500539pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 07:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mDMj1VhS1g9ZAydEXjYxo+LFu7baJkisWPTmeHryq4=;
        b=HkRAe48kmhhdtqn526nFfNaVz5YDjvAHem15pAA1tH2xPajKeNawB4hMOddDcGBvRs
         n9Ahdraj8di2Bw+ju2Qhj+uFiFf02l853SnlzIqJSIrXe7hrNcubbWXOvY62xmgyp4/a
         aVB4C/sPqQC9Iy3WiI/60pUJFq3PI96QMes5e3euokL0gJ90o9OkzhEqt/+XCpwvBm+G
         Axji+O5gqnBF7RRy6ZNlM0mAUKN/avuS/ijjROTjesFj8xoKdTjVWtUPqh2VhHOcPQqk
         nvFRLv+USeuK9J7XeYi8JAzGwGmj6TvN/Bg4uwvLZXAVSlQlRR5cKxEVeLw6Bt6sxi2e
         2cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mDMj1VhS1g9ZAydEXjYxo+LFu7baJkisWPTmeHryq4=;
        b=f11cQx1hgcruHxmCEtiIUCiF9M3/kAFWPPhQW/o8Ls3VrhuFBY6Y8NfWyZkYinUPTg
         xN/Yl5uuMjl2wX6NBPwSNbaQCYIo2t9kdIXvoOAaPbiBLUHnNwjKLkxB5irrX2cvxz2d
         Vu/BUV3dADQOWPeclY2YmL8yY3/zeKE3TKt4fvQP0T+jq5dclxZnj5KBmyhX5qOzFZyE
         GWyiByEyaUu2QAA/HOK8gL+my/elqf1Q9Z6PNhFj4FI4R8wEcPQp6P+g2RrvOu2wWCef
         LsDvNa2teWsrU0YWnlDL2bqyN/w5albh4E0nX7R9SX1V1tSOneoqB21wE7Wm6OiZMnRZ
         439A==
X-Gm-Message-State: AOAM532Ndzf5r0ZLPpIZYnXIP0G+3SyGhFpwsLf1DWRmjEsQSRgBGgx3
        rudVNTe1+3QhZrYHn7zknYtScW+DVfkK9w==
X-Google-Smtp-Source: ABdhPJxFVIxjenBWQ4dL+giI/9f1UeSo9v0t064Em0SPBDUGBx4YI6ZLA3x6/jbmTJB3ErbMoty2mQ==
X-Received: by 2002:a63:470b:: with SMTP id u11mr20100411pga.436.1608649506157;
        Tue, 22 Dec 2020 07:05:06 -0800 (PST)
Received: from localhost.localdomain (2001-b011-3814-dae9-4a2f-9772-47bc-5b94.dynamic-ip6.hinet.net. [2001:b011:3814:dae9:4a2f:9772:47bc:5b94])
        by smtp.googlemail.com with ESMTPSA id u14sm19000202pfk.111.2020.12.22.07.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 07:05:05 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH 1/2] ALSA: hda/realtek: Apply jack fixup for Quanta NL3
Date:   Tue, 22 Dec 2020 23:04:58 +0800
Message-Id: <20201222150459.9545-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Quanta NL3 laptop has both a headphone output jack and a headset
jack, on the right edge of the chassis.

The pin information suggests that both of these are at the Front.
The PulseAudio is confused to differentiate them so one of the jack
can neither get the jack sense working nor the audio output.

The ALC269_FIXUP_LIFEBOOK chained with ALC269_FIXUP_QUANTA_MUTE can
help to differentiate 2 jacks and get the 'Auto-Mute Mode' working
correctly.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8616c5624870..bb1010d78717 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8013,6 +8013,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x152d, 0x1082, "Quanta NL3", ALC269_FIXUP_LIFEBOOK),
 	SND_PCI_QUIRK(0x1558, 0x1323, "Clevo N130ZU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x1325, "System76 Darter Pro (darp5)", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x1401, "Clevo L140[CZ]U", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-- 
2.20.1

