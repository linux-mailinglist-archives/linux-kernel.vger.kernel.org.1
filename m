Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64542FFC5B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 06:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbhAVFtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 00:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbhAVFtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 00:49:19 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA5AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:48:39 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n10so2951583pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpUv7BpGe97VvIuJXCpyMafCEF/2ASdyYXmAmRoiigA=;
        b=odYmuytYpz1voPKzJ/dPbeeWfurHPYBTibVwl0y74lY8C7g1V4cuzxdAS8eh3Xmlxn
         wGktiwm9XJe7fJw8vzAiZqm7q3MW2eJfwdE1q3iFs9bPX8PgDEmeVDCtYyR3Lkb8Rh1X
         Qo8w0h+aklZCca+WP1zdB70lUtmf9ZZbC7Sa94RupgyuP2OSJO7BXTJuaD6tz+s6cZpD
         Nbe6jlS6ToQcdSjjilobeHkUiSHm/b6xevaikJuLAzwFM331EfhuBTrDcpgNf5BPv7Tk
         8xB6rYsuQsP+yyM5o+3+iX8K6kxj90hm6bgyyfLH8xkRChlg9n5aqXnZmhW4RfMIoNrK
         B16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpUv7BpGe97VvIuJXCpyMafCEF/2ASdyYXmAmRoiigA=;
        b=i9I0U88SRmg0pM3lEc53Dp8pPtvNFcIv26SZ2ecWUjhfuQrbCNp8HXM7ssMCSrrKIw
         zYdZLdq3CfgND3w4JN99ZT1rh4iu3NTE3ZILB8hLkED/GKfN8uaHoaqqGi2tdhdb9xOv
         6UnW8QGxKF8mdd6Z1rN6cem+fIRRtgFi0c6iZBLqPsozwT0+8eqQP3d8GTLWtfAn7fEa
         4uYqIoC4jLE7wV17tYDrR7c9Re4kCo3iC+onqvGtQfuwoNgbkwHyNvaK14D3CS5QWf9H
         NQheTCKzG0h7qA4aJgOo6Nzkxs5/usMk1lIvrh0mLWbTQrX2VbgfRITYLZNtAh/Sx8cy
         aJig==
X-Gm-Message-State: AOAM530ZXfROjHXDHRE7y4v2O15tWnCDNvZFtv8LbTbrdYG5d5XB7SXl
        cOBCXFMOsyiTUmtlSzRVPY51155uPUc4FOKh
X-Google-Smtp-Source: ABdhPJxIGamgud5deMH7oQJJpOQfILtqLFBzrLaNURQdl/K3azp/yl9sgf3KwO0wZiRqfEjPwEGZNw==
X-Received: by 2002:a63:520d:: with SMTP id g13mr3061728pgb.289.1611294518754;
        Thu, 21 Jan 2021 21:48:38 -0800 (PST)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id gg6sm12252779pjb.2.2021.01.21.21.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 21:48:38 -0800 (PST)
From:   Jian-Hong Pan <jhp@endlessos.org>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH] ALSA: hda/realtek: Enable headset of ASUS B1400CEPE with ALC256
Date:   Fri, 22 Jan 2021 13:47:06 +0800
Message-Id: <20210122054705.48804-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS B1400CEPE laptop's headset audio is not enabled until
ALC256_FIXUP_ASUS_HPE quirk is applied.

Here is the original pin node values:

0x12 0x40000000
0x13 0x411111f0
0x14 0x90170110
0x18 0x411111f0
0x19 0x411111f0
0x1a 0x411111f0
0x1b 0x411111f0
0x1d 0x40461b45
0x1e 0x411111f0
0x21 0x04211020

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ed5b6b894dc1..290645516313 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8006,6 +8006,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x18f1, "Asus FX505DT", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x194e, "ASUS UX563FD", ALC294_FIXUP_ASUS_HPE),
+	SND_PCI_QUIRK(0x1043, 0x1982, "ASUS B1400CEPE", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-- 
2.30.0

