Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F9D2D33BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgLHUYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLHUYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:24:17 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29908C061794
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:23:37 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t6so2014799plq.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggClf1qYaX1ZYfaRMUNT7oZqY0pd3cd9hPip2Wzk4F4=;
        b=KLKJlgWgWbN67LPCenCHeeJkjwAUvUak89ba7ygQ2WI2d0DKFSd+sOpBSK0ltfZCE8
         aPs6ZvvEOxVB2SCOitevu7LEKNGkR6P7yvGSeqlhiF55Zy2XUclnSeH76/V7dw1BdjHd
         T/E7rarteJFj2n2b0aUhMSkMlHDNu8zb66QZw0bzQ40w4SXthUiQXvxsXmRd9qp3GuiT
         cOnXpkLKjF9LcspElKGDZ3wMrG5f8i2GC/QoBhHKquE+wt9VZ31tRvL+ibw1hKobGYTv
         jtfJECveexzrQpKRV2zAMdI5aXZljhIsFYQoexnSTs/dGzdYO3/tadaiwYFozfteBWUR
         e0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggClf1qYaX1ZYfaRMUNT7oZqY0pd3cd9hPip2Wzk4F4=;
        b=l7e7tlyR4MuOjrJpKn/1BCMeZ3JUGaqa5n/Nm343sdBjK/pfFDd98TTzs7DvRl+e8z
         jZ31W6DRwVMOcNgcA8WfBu6syqH0344B99q9F1SGMG6gFY2iTfHH/QBSuPJjFwfQ0Hsi
         mCyNYDarVUrbBB8NIaJfDQ4+N2ub7o6ymGrXni5a+Pfb8ybFWdeUqdUe233NYFO1yqZq
         Ljq+JV9XkkMj5WUE15rcIZYHVXQ1kNzLxULa8Q+1x/aKOj7ENAKovNCOxk/Xyt6COkw+
         JuMufNRjmzW+7gdVRdBJ9lGR0lf5FrjFQGJfh138pEVrDnQrnvO58jNuJEMFaYNh46sR
         JP9w==
X-Gm-Message-State: AOAM5304jwYKLiXon0pXpq/Y/DYfORjJ2D4GKtDHlDc4dFCSr1FLkKxK
        a+VXkAJBdF4VkJm+QjDyrSQoKcBK4Ng=
X-Google-Smtp-Source: ABdhPJwLRmltK/EpGlS75VZoegn0zu1cz6U5kI4SqVbpM4KQKxgxNlbJQcRwUyD+ahl8etD1DfXmwA==
X-Received: by 2002:a05:6214:12ab:: with SMTP id w11mr29040746qvu.42.1607457149690;
        Tue, 08 Dec 2020 11:52:29 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id x24sm14169458qkx.23.2020.12.08.11.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 11:52:29 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, stable@kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ALSA: hda/ca0132 - Fix AE-5 rear headphone pincfg.
Date:   Tue,  8 Dec 2020 14:52:20 -0500
Message-Id: <20201208195223.424753-1-conmanx360@gmail.com>
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
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v2 changes:
- Add fixes references to previous commits that these patches now fix.

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

