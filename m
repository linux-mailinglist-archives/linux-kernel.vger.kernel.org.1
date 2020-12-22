Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D942E0C61
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgLVPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgLVPFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:05:49 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BBAC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 07:05:09 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id x1so2938928pgh.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 07:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Hrgc2vErdduBB9qM7RbOF/nuu0syt0R9KKjGGJCpoc=;
        b=EqRZ/gRPWI+a3OaYV+YvH80ky5fZtAnCqzWOHvrGTYHYUqe9/QKO7dz0T5yrWbIWLS
         Z0hn/fe/f8Hi1isP0zvWIzHjfFOP/96EaZ1REeAfypGnHGFcqUA1Gx5Opw2chy/BTlBg
         ALJpyv7ya0FAvYQD1a+szxZ/vaiuOVN0a/VxXYU1mWIwk3lsmFyXVNmQXdQXgCpOteJh
         mRWzHRI94UgUom2tHJRsqxcBSlpbhGjmqmRmrHo/96lOKtI5873x+DZw66kgdlU3c64A
         cMhno0qLS06NpfkneAyGWwXGNCyCltXrCl7CB+c6uKw8+u8ExVlTwOBNZF2nvzDw8z2i
         bzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Hrgc2vErdduBB9qM7RbOF/nuu0syt0R9KKjGGJCpoc=;
        b=KhBIwucM1kwiQTchnKwVjwha+qW4tJUbhb3T92H528qPL1VZG5DTGfWeBtnkvd2xY8
         pyy/W4NYp3cxJjf7K1F2vftQrmu8/C4XrnxPOmdoVCqreCVM0zcXSF06Ev3Bv1MLp6C3
         nA0zpNRCcMgfBwe4+Gp0m+vlD+4lL65KXXdDTj+/KOsXkGv5I060K1Jbw6gwq4R004xl
         KNQqKnBeqaypUp6bmV12VVX8XAEzn/KxzeNOYwhfiwoKvU1/CMFNxV7ZFQKmisau/bg1
         EbXmx3qEhbrPdTYIJjJyFEBUuRL2MThPhbZ+LEhDr+lUL/hiNzsC3XlgdLnzDg4bE39v
         YBUw==
X-Gm-Message-State: AOAM531BLGD9Xz4/E20H0pm6Tm1Sks4Ujj8rpm6Qx1ubFLEP6h9Jb2FU
        dktn9gAC98aiKKXbaCfsJcoi9Q==
X-Google-Smtp-Source: ABdhPJx//2nSKhHTG8gyFHAn9MT2fZxkt0i1lk3RChMj03CHREE0oJTSOQ7Wbcrh7D+i0dOzhq6CqQ==
X-Received: by 2002:a63:4f64:: with SMTP id p36mr12935334pgl.374.1608649508742;
        Tue, 22 Dec 2020 07:05:08 -0800 (PST)
Received: from localhost.localdomain (2001-b011-3814-dae9-4a2f-9772-47bc-5b94.dynamic-ip6.hinet.net. [2001:b011:3814:dae9:4a2f:9772:47bc:5b94])
        by smtp.googlemail.com with ESMTPSA id u14sm19000202pfk.111.2020.12.22.07.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 07:05:08 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH 2/2] ALSA/hda: apply jack fixup for the Acer Veriton N4640G/N6640G/N2510G
Date:   Tue, 22 Dec 2020 23:04:59 +0800
Message-Id: <20201222150459.9545-2-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201222150459.9545-1-chiu@endlessos.org>
References: <20201222150459.9545-1-chiu@endlessos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Acer Veriton N4640G/N6640G/N2510G desktops have 2 headphone
jacks(front and rear), and a separate Mic In jack.

The rear headphone jack is actually a line out jack but always silent
while playing audio. The front 'Mic In' also fails the jack sensing.
Apply the ALC269_FIXUP_LIFEBOOK to have all audio jacks to work as
expected.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bb1010d78717..9eb43d827bda 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7803,11 +7803,14 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0762, "Acer Aspire E1-472", ALC271_FIXUP_HP_GATE_MIC_JACK_E1_572),
 	SND_PCI_QUIRK(0x1025, 0x0775, "Acer Aspire E1-572", ALC271_FIXUP_HP_GATE_MIC_JACK_E1_572),
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
+	SND_PCI_QUIRK(0x1025, 0x101c, "Acer Veriton N2510G", ALC269_FIXUP_LIFEBOOK),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1065, "Acer Aspire C20-820", ALC269VC_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x1025, 0x1099, "Acer Aspire E5-523G", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x110e, "Acer Aspire ES1-432", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x1166, "Acer Veriton N4640G", ALC269_FIXUP_LIFEBOOK),
+	SND_PCI_QUIRK(0x1025, 0x1167, "Acer Veriton N6640G", ALC269_FIXUP_LIFEBOOK),
 	SND_PCI_QUIRK(0x1025, 0x1246, "Acer Predator Helios 500", ALC299_FIXUP_PREDATOR_SPK),
 	SND_PCI_QUIRK(0x1025, 0x1247, "Acer vCopperbox", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1025, 0x1248, "Acer Veriton N4660G", ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE),
-- 
2.20.1

