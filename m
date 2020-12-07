Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901AB2D0BF3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 09:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgLGIrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 03:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgLGIrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 03:47:04 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBD3C0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 00:46:24 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id b144so11786965qkc.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 00:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75+i+NBjMQ6GtQpKGQNJdPXnFNLfGkuAW15cSzTPqVQ=;
        b=qtEErtAS+Fb92gBJJjJECw0zeq/TSSiOw+SAGqvz05PQyWQg+Vm5xV1PMYBZRTQSeL
         rEYnaz/4PoSsnlGGivHNdiKKBwgNQkSGTKNEZc0iy/KmHB1Qqav1wnBWC4iDdj64ZJku
         /JyQS3OsosSBW0QdRSqpayQ0qsaRarXb9lYfhgpbtNlKLuTVGjbVbqZPS9XUVJeqMypR
         t0+8iZSKPwOWSBrIE/+4Sw4qBcw+I1IIB+/unnS7abycAYg9DHxJqvOAI+YDeGIuqLdB
         kTCklslvNbRo/JU6Vp9Ur/03iGqPHlYnKgg6IgT4365O8hZsnDZ8xDOIkzcmxaJV5sym
         SR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75+i+NBjMQ6GtQpKGQNJdPXnFNLfGkuAW15cSzTPqVQ=;
        b=eWqIgiQJcZZaZHlQc2ZgpM5n/04Tub7KOPYAHLBDmI6tRROqtf6MLf9dfqmwbUnvFC
         3wBQu1z1eKqMFtcbmJDUUizmDefuI60402NUwjtDV9E0Q1eUW5tHA60I/RzlwGJjow+7
         Qg2hwxKoTz8ZMTQFxlXjnYFtzQf8oY5Xl47wlQ93jwAiFu612cOKHjs14TtAhTmkR+W/
         r8r6knknpZDH7F1KzSXjfG8vQF1wjxstbZLYH8adoFqXfrSIjcL/X3lne0pvJzb5v6vP
         A+Ozo44FrQuFgeGpvkQ5A5EmV96ZvxyKecehQaXBLtcjgQLsB7SWXT71qkn31RbC+3cv
         udrg==
X-Gm-Message-State: AOAM532HaqSGMUZzIyhzE9ARiNJ+TcVZe9iCxrvJIDdc6XVXHhAu6geJ
        UJhGZcQXwWMSxk5M09BKL/0=
X-Google-Smtp-Source: ABdhPJxAQ2lH+fXjAcGTh8FCHNA5Xmj8q7aXjdHsR8Ac7wnaqenQn56nJi45e0DcoO9LXDp2Q5xMWQ==
X-Received: by 2002:a37:9c4a:: with SMTP id f71mr5396954qke.495.1607330783087;
        Mon, 07 Dec 2020 00:46:23 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id a9sm3424681qkk.39.2020.12.07.00.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 00:46:22 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ALSA: hda/ca0132 - Fix AE-5 rear headphone pincfg.
Date:   Mon,  7 Dec 2020 03:46:13 -0500
Message-Id: <20201207084616.411531-1-conmanx360@gmail.com>
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

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
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

