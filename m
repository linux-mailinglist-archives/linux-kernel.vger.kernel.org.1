Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9172B2D39FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 05:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgLIE6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 23:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgLIE6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 23:58:17 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F0CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 20:57:37 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id g18so452486pgk.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 20:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95+j/heHWe1WaIW2wuU06rCfMJ7fLe/PVC+mrAa/tbA=;
        b=dn95pMcdeUnm+YT4tp8+Y2wFkXWa4mb4yIE+j4JqPFZv0xSXN+VZAhyIqRBTLTtZq9
         yCGI3qb6HXfKNBvUVDEXdUPlK3lQUNaFkHOF30JBV6uFO+jbkkVOLP8KPW2I6wYiQPkR
         OKFsXlyNbL8s44Xcv4XkG4tf9KBirJfTEu1SQoPpVEGoLYLzzXF0emSyy1ONZPIyHbHj
         gaYNGXWoPzcKKBpo/RzWauBZAt2mj3X1q9UuVEc58nUTW/zOB96YJZ5+ScVNgb62GNRk
         RZpw5fZODkQqZio0GhVmqecZBUBDSpthofgKGrkao98rsdpsz/hAI0+JFBC93vveSwLA
         HPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95+j/heHWe1WaIW2wuU06rCfMJ7fLe/PVC+mrAa/tbA=;
        b=biy0v+/YlM4uI7uK6Hm2CxfkdlVqOCraqAxN8ve3o6dTiwvAWzOhqDNFpS2Q4sD6pt
         LGVfGFNOIsBrxG+v5ghjJkZzCG+BxWHycDC+ye8iWNqBcYU/XmX21aVIA/aBPlE4Z6xj
         ShNy64FLt/3JwlYxo5D/y4Aghlwh9RqTAjB4tnBImIk33my9R7eYdMB/RhvNYZJka18C
         QXnZNSC+iaynvbCwdSCq2i9wStmcWAmCAnRYXvCz9b/lWkk9P1kwE0q4IBPRSoTPm3EU
         nTjrf5gd2j5BlqK3Vo0i1AAoCtuUFJWLkAuSHQiBk/IAFEpPsYk55tnI/u5Jocg8fAUZ
         foNA==
X-Gm-Message-State: AOAM531u2Yxz9uW3QEBs+VJxW4X8RkEm/qbSglRs3itqSwfWqXIpO0ji
        9vN6Cg0oNHOt/jGS0atFwI6CoA==
X-Google-Smtp-Source: ABdhPJxg65ZgHF/vA6oW5WocO5sz3Kfy3kVIIlBzbILfcXSFpS1uQBomSZDQw7WhHPdbmUCWr1U8mw==
X-Received: by 2002:a62:5205:0:b029:19e:a0f:2c81 with SMTP id g5-20020a6252050000b029019e0a0f2c81mr678023pfb.50.1607489856851;
        Tue, 08 Dec 2020 20:57:36 -0800 (PST)
Received: from localhost.localdomain (2001-b011-3814-7903-632e-aa12-9563-de14.dynamic-ip6.hinet.net. [2001:b011:3814:7903:632e:aa12:9563:de14])
        by smtp.googlemail.com with ESMTPSA id v9sm551295pff.102.2020.12.08.20.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 20:57:36 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH] ALSA: hda/realtek - Enable headset mic of ASUS Q524UQK with ALC255
Date:   Wed,  9 Dec 2020 12:57:30 +0800
Message-Id: <20201209045730.9972-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS laptop Q524UQK with ALC255 codec can't detect the headset
microphone until ALC255_FIXUP_ASUS_MIC_NO_PRESENCE quirk applied.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8616c5624870..2d4bb9019cb8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7976,6 +7976,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x1043, 0x125e, "ASUS Q524UQK", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
-- 
2.20.1

