Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF8D2D0B26
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgLGHen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgLGHem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:34:42 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F6C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 23:34:02 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id p4so3068048pfg.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 23:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TIkKIzRH51h1L8SP1gRvc6+13g2+kyu7Qn+qiqmKw1w=;
        b=TWoY1ZMoAFOY9e0dzQ3N4Y01kI8BEw2I1EREyo9t7d0T60Yba/xevAfuO4HULhipHB
         KH+7o3JoXiWZMaTyathl9EQXx3kCq/gTL09EUzBS0Te8K6hAabQMlOvOHMzmpUji13LT
         FYV4bdcpbLyh7Clr8ITjoTRpMr7chFlDTY7mfImUNWsiA3I7uo6W1aAjgMWyvS7TrTCU
         enaeitbp/1GUm0jj0oFY+SQ8YfSCxLaI1fjj/AcesJOnffNmSOKRe4BL4BMOsTqZ5VzJ
         laPDsqxNKT8ygIZo8Vo4PtSztk9qLO8tR4WXK+CJsMHHtQygM6jGYFwuPGZoehavRq8U
         M9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TIkKIzRH51h1L8SP1gRvc6+13g2+kyu7Qn+qiqmKw1w=;
        b=XoL1sJHh5IvlW1VO29DAjYsNDjwC8mmrBBSwUtMgXqmxEWA23u/o9nGykWjUphAGUX
         zxgK6OAVGHe+dzdBcPMnK9hILcWg1+TiO2XUvS8HhGhgx/AjcKegw8ZcvmtmrB5xcSNQ
         20TxqeUtcdDU2Vu98KqI47ar0F3OX+u2m/b+ZNbGomnKFX7SG9Nl1Jol0q0wXLCjoOF9
         wcrmUkRTWNNki1R77BRA6t1gQwdaKYfyF0FBA+UALyfjz0y92mXwA4YcZyh2iPQ0kaSS
         mYFxA0dCm/Km0GGuvAQMG88uWWDK8G/FqQlgYl3GOc91ScgJfTzn5XKfzi1W6TXctHtQ
         a6nw==
X-Gm-Message-State: AOAM5315OPCzFR3kGTFInsUfP42qgurI99v/+FjwYuH/w3EUyuYyek1i
        bIj2mBNKCwGqpQ0wn0m2wK/7bg==
X-Google-Smtp-Source: ABdhPJyKvzuc7bl+SCli8jULWN87Ooi9a2yfuPQV02o2IviA6SkdwLFoD/KrkkD2zfO3B/wTCepo5g==
X-Received: by 2002:a05:6a00:1389:b029:18b:2d21:2f1a with SMTP id t9-20020a056a001389b029018b2d212f1amr14893752pfg.1.1607326442216;
        Sun, 06 Dec 2020 23:34:02 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id t22sm22526279pja.1.2020.12.06.23.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 23:34:01 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH] ALSA: hda/realtek - Add support for Memeza EDL03 headset mic
Date:   Mon,  7 Dec 2020 15:33:46 +0800
Message-Id: <20201207073346.16571-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Memeza laptop EDL03 with codec ALC256 can't detect the headset
microphone. The headphone jack sensing works after we add a pin
definition for it by ALC256_FIXUP_ASUS_MIC_NO_PRESENCE.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d5e4d0ba1008..8b9b94cfc67e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7871,6 +7871,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x1629, "Lifebook U7x7", ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
+	SND_PCI_QUIRK(0x10ec, 0x115a, "Memeza EDL03", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x10ec, 0x1230, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_HEADSET_MODE),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
-- 
2.20.1

