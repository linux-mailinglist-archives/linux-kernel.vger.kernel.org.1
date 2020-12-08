Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E42D3369
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgLHUSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgLHUSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:18:18 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA74C0619D4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:17:33 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id q22so17244158qkq.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8EiQ216BCvq5E3ZOT1I0q0n5ZMKUzKstAb5dwxu2d2I=;
        b=H+O+LB9l6tD4mV0hOiWsrlvudGlRYkKHYX1vIuNGbQRlA0M41yWHaSqoynyQ/KSduU
         /nx93xjIgpA2ZqNBfy8sfx/uQM51WYb9zBcCY18tFIfB/vu7K6mJH5uw4wIjcs+Kdc5t
         svK2wCMfMXWVnKSyDaJ8PRAAiXZVu3B8bh4VQli/HnwcVjQI6q45BlM3xA4ja8nTw/KH
         G6Ss0wcAQUP+o7l0MhNP6cjG4V9ytYYXZ9vZlBtZQd7FNpRXJqbX9B9Bn+pmhbEmPOC3
         F1RZWOplj9UOEBemVv24FDfahSFE4FwsYdv0gZ0K9RopqDhBvKLg8RyZa0/iXZekC+A1
         apqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8EiQ216BCvq5E3ZOT1I0q0n5ZMKUzKstAb5dwxu2d2I=;
        b=Gw7pAW1hSlHrkYRA7dtEjPDCDHru9P9tbuvO4B07OKDzkldmUQ8Zqq8oHpHToSAgOr
         7AqqdOMwUS6Wy1NGEhNDSquD+wvU6Lay69l16V0TO2zieDy+7Rp3bEAl/8azbG7DfpyL
         uZAEJJt4nmqRMj6iH8lYKJRYiX4N1L933GneKM0J1UowZ4d4O/ULelszQSKMuZayZQxB
         SrBflSjiHgvhNmnqcP3P75krHaTXt7RdX/9Bwk3n4+tG87UMi7L2XXwJfuvOvtTFn3Ds
         ot+sCjRuiuYpuoFDiIpCpZWN9Od6n+r96yxhgXETP38sujjcSpBpWJ8Jg3PSX7DPQGGM
         mszw==
X-Gm-Message-State: AOAM533DGbS01Y7Ys8FG6r4/94ujhXPi/xpsmzOR/PmIMqjmc4C9udmq
        BiF/Vvvab4talVxAnAMwDxJ9Y86rvRU=
X-Google-Smtp-Source: ABdhPJy2QKOFcGdKPniH3biP/AcV9n4+MreVaxj+4qol5JZ4qA/vdo3UcHnohnWncAYFYRuDZ0TMZQ==
X-Received: by 2002:ae9:df47:: with SMTP id t68mr31594897qkf.438.1607457154512;
        Tue, 08 Dec 2020 11:52:34 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id x24sm14169458qkx.23.2020.12.08.11.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 11:52:34 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, stable@kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ALSA: hda/ca0132 - Unmute surround when speaker output is selected.
Date:   Tue,  8 Dec 2020 14:52:22 -0500
Message-Id: <20201208195223.424753-3-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208195223.424753-1-conmanx360@gmail.com>
References: <20201208195223.424753-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure GPIO pin for surround channel mute is set to 0 when speaker
output is selected.

Fixes: def3f0a5c7007 ("ALSA: hda/ca0132 - Add quirk output selection structures.")
Cc: <stable@kernel.org>
Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 793dc5d501a5..6d647d461eab 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1390,7 +1390,7 @@ static const struct ca0132_alt_out_set_quirk_data quirk_out_set_data[] = {
 		  .has_hda_gpio     = false,
 		  .mmio_gpio_count  = 3,
 		  .mmio_gpio_pin    = { 2, 3, 5 },
-		  .mmio_gpio_set    = { 1, 1, 0 },
+		  .mmio_gpio_set    = { 1, 0, 0 },
 		  .scp_cmds_count   = 0,
 		  .has_chipio_write = false,
 		},
-- 
2.25.1

