Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727422CA1A7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgLALks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgLALkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:40:47 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17137C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 03:40:07 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id pg6so3452330ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 03:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=r43o4osB5EUqTM8RlVefBlMVFHSoKs66UHm4/Sm0KMA=;
        b=hicbPgHOhxonhgnQZRwFoGuScFOVYRni4VFEile9K74kHe7ki+BWGpmhDucNLD0VWZ
         Av0cYy0PeO2myw6Pc5pbaXUCBacLADD+VrRi7BQlqI59rlkFvkgXtJzSsVQoQGhqLzll
         crCU63sPUl0lwNeMHc70kEGTmhZProCZAE8bgUaDkl/FKYO98v4hMIhdwQmwl/hPj/+Z
         FAP83QuG6wMxOrl8ZMrhkhVwQpJYEuQrWAnN0ezQ+C+Ai+6OSjZ8+jtWCbiMhwMDKy9E
         77KpAUe8PTxlJFvEqGRAIgsPznl0UI07+X913FDIUowytQiq93sBe2WbhYRVA/KmN+MC
         7VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=r43o4osB5EUqTM8RlVefBlMVFHSoKs66UHm4/Sm0KMA=;
        b=UsVxssMG7w4RRp6Lq+McCr1PRrqa8g/tln6htpHURZlBW4Qk5j7Aj7R+NLjHGFjraN
         AmI3VRyBU05josJn55TPhaXqWkJhbKYAmnZoUIwgdWitVa9h/2km4CKOy1XdcTs91Pt+
         po3zegwTU3DKRlfy0NqP1a2BmFLfK3a1hr8jZrub4gCGktEmDzzy1Zkj32EjF0BYG6x4
         w6haimvHM4mDb+S1G80QWptfCWi6LYsomcWK6SfYJ0Lb4RvXjjqmztX2Q6ci8vJA4nw8
         qZ/FkzBAi4Xs2jMOIEBF4/HiopK9bW+mxAWSkG+pvSFAYaPPFlCP4hIJhe5uJGhfySp4
         PQ5Q==
X-Gm-Message-State: AOAM531XzRbksp657TqGksYcuKWkjdoEJT6J/PiG4si66q2gJVQESAf+
        IaAqO+rqh3uHn4JpULY20QpBJKzzRtkqbw==
X-Google-Smtp-Source: ABdhPJyPpOs4mgHlw9U+JNvdi8iAf/D3gu9ozEVHyEmtIFqNf+Tg/9AqBTy9bNmR82iT+toatlbQQw==
X-Received: by 2002:a17:906:4944:: with SMTP id f4mr2497466ejt.231.1606822805170;
        Tue, 01 Dec 2020 03:40:05 -0800 (PST)
Received: from ?IPv6:2003:ea:8f23:2800:c8da:c2a2:5860:ab22? (p200300ea8f232800c8dac2a25860ab22.dip0.t-ipconnect.de. [2003:ea:8f23:2800:c8da:c2a2:5860:ab22])
        by smtp.googlemail.com with ESMTPSA id x15sm685240edj.91.2020.12.01.03.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 03:40:04 -0800 (PST)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] x86/reboot/quirks: Add Zotac ZBOX CI327 nano PCI reboot quirk
Message-ID: <1524eafd-f89c-cfa4-ed70-0bde9e45eec9@gmail.com>
Date:   Tue, 1 Dec 2020 12:39:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this system the M.2 PCIe WiFi card isn't detected after reboot,
only after cold boot. reboot=pci fixes this behavior.
In [0] the same issue is described, although on another system and
with another Intel WiFi card. In case it's relevant, both systems
have Celeron CPU's.
The dicussion in [0] involved the PCI maintainer, and proposal was
to go with the PCI reboot quirk on affected systems until a more
generic fix is available.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=202399

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/x86/kernel/reboot.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index db115943e..9991c5920 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -477,6 +477,15 @@ static const struct dmi_system_id reboot_dmi_table[] __initconst = {
 		},
 	},
 
+	{	/* PCIe Wifi card isn't detected after reboot otherwise */
+		.callback = set_pci_reboot,
+		.ident = "Zotac ZBOX CI327 nano",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "NA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZBOX-CI327NANO-GS-01"),
+		},
+	},
+
 	/* Sony */
 	{	/* Handle problems with rebooting on Sony VGN-Z540N */
 		.callback = set_bios_reboot,
-- 
2.29.2

