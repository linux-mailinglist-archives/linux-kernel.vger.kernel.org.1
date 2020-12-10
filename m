Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0A52D63B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392874AbgLJRhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392866AbgLJRgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:36:45 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4595C06179C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:36:05 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id a6so4258462qtw.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E1hwgGPc5XzvWzLpZ/u2ztIUVy06ybOCmMW5LrKZ6/4=;
        b=JwNxEvwYgTpW4/CVoIAfLYCXJKGxAMzE9Kw8FvCi9uPMfMtiE3XSKQ1X9auxbIHhaj
         NFl+L2CDKyeEm4X8g/Fv8yLP6vhDIKh0hy1ghLTDfrWJEMVb39dwRXFRj2oW9CVfBmUt
         VBtvo3jAfKCQocAbdCaMofE9fkudhq2Zuaa6VyYdLCe9IAJaF5ybltMMFTvycfkM5KZV
         mW7BCYHBSBsyay5cR/a1LLX0s6hvMB9qPepOuqilh1E/IDN0sliZJ75HmjwGmjbH2Zj1
         v0Tl34OGD2HbajA9T0xjT+di/IhjspLN/H3ThHfyflxS9HRBcD/RYlbKU/xFnB6f7j4S
         2brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E1hwgGPc5XzvWzLpZ/u2ztIUVy06ybOCmMW5LrKZ6/4=;
        b=P25dA5FamPKWXbReJ8+X5W8ga6Pjv5K7YIK/AHqw3l/enNBIy676I2YASUZ7DCbsOY
         hT/ZJ/JgGEAnfuiuL6l9VgkoP1laRy50Hzil3/g1jZq/xfjPFVlMUyrU1/Vx8QpSqGU7
         CZHJFNGsvh5DL2XNwuk1co0H8Vt7Wt0r9nVmzaSoGbkhlqbZWneGbEedPLu/8nFkmPfO
         rohcb7TypE8Cx4vsovuGg8+HVchX7U3b1T5KeheGh3gv9X8iR9uLL6eTAzAu1+vdQjEO
         fqfWgIl1botpAENEaiVEmX5Y5zNDEnhipRQrQ/xvFyB/SIP3Ba+ipzIdrDEP2fNwsl7a
         T8ng==
X-Gm-Message-State: AOAM532byP56ZOfAMGZqqXu8GacrXnjolbsoADPBDl3d2aNEfQEmDhL3
        J6mSP6z0/IFsJR4jL+2ELFo=
X-Google-Smtp-Source: ABdhPJzesXmTEhgHW0KZeIMclsMQ/HLw4HTjUu1GUabI9bCijhC9qiqhsg2Sy37yA6AfgphG8NyvOg==
X-Received: by 2002:ac8:5802:: with SMTP id g2mr10176977qtg.383.1607621765004;
        Thu, 10 Dec 2020 09:36:05 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id y22sm3886786qkj.129.2020.12.10.09.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:36:04 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, stable@kernel.org,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] ALSA: hda/ca0132 - Fix AE-5 rear headphone pincfg.
Date:   Thu, 10 Dec 2020 12:35:48 -0500
Message-Id: <20201210173550.2968-1-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Windows driver sets the pincfg for the AE-5's rear-headphone to
report as a microphone. This causes issues with Pulseaudio mistakenly
believing there is no headphone plugged in. In Linux, we should instead
set it to be a headphone.

Fixes: a6b0961b39896 ("ALSA: hda/ca0132 - fix AE-5 pincfg")
Cc: <stable@kernel.org>
Signed-off-by: Connor McAdams <conmanx360@gmail.com>
Link: https://lore.kernel.org/r/20201208195223.424753-1-conmanx360@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4fbec4258f58..e96db73c32f5 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1223,7 +1223,7 @@ static const struct hda_pintbl ae5_pincfgs[] = {
 	{ 0x0e, 0x01c510f0 }, /* SPDIF In */
 	{ 0x0f, 0x01017114 }, /* Port A -- Rear L/R. */
 	{ 0x10, 0x01017012 }, /* Port D -- Center/LFE or FP Hp */
-	{ 0x11, 0x01a170ff }, /* Port B -- LineMicIn2 / Rear Headphone */
+	{ 0x11, 0x012170ff }, /* Port B -- LineMicIn2 / Rear Headphone */
 	{ 0x12, 0x01a170f0 }, /* Port C -- LineIn1 */
 	{ 0x13, 0x908700f0 }, /* What U Hear In*/
 	{ 0x18, 0x50d000f0 }, /* N/A */
-- 
2.25.1

