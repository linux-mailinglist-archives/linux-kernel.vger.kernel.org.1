Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1772E431A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 16:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392827AbgL1PaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 10:30:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405237AbgL1Nz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:55:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0381B20795;
        Mon, 28 Dec 2020 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609163688;
        bh=0h2Mz0WfQ3ctESAkDy2m9F3GHI58JPWdjTZlV869Imw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZrpHHOz/SWVwNPX7oHMgiKBXfU61w0soDCZQmu+N5owPfucl+ecYtpeokm26jMVJ
         KEacBUO2iQSt079ryLCXRFxSjSeYQtKK/y1iuqem66r4+NcATzPjvNB7EwMC8sAXwn
         1zhzukxtGRoWGynR5KKuhrpiwK9y6nDQOvZ1n1iA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 342/453] ALSA: hda/realtek: Add quirk for MSI-GP73
Date:   Mon, 28 Dec 2020 13:49:38 +0100
Message-Id: <20201228124953.677420280@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228124937.240114599@linuxfoundation.org>
References: <20201228124937.240114599@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 09926202e939fd699650ac0fc0baa5757e069390 upstream.

MSI-GP73 (with SSID 1462:1229) requires yet again
ALC1220_FIXUP_CLEVO_P950 quirk like other MSI models.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=210793
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20201220080943.24839-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2506,6 +2506,7 @@ static const struct snd_pci_quirk alc882
 	SND_PCI_QUIRK(0x1458, 0xa0ce, "Gigabyte X570 Aorus Xtreme", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x11f7, "MSI-GE63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1462, 0x1229, "MSI-GP73", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1275, "MSI-GL63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1293, "MSI-GP65", ALC1220_FIXUP_CLEVO_P950),


