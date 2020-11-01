Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F852A1F5F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 17:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgKAQAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 11:00:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726730AbgKAQAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 11:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604246445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=vgk9YLGxl+ilKw1iu6HtFxOj8hP02Lb3fum/BlBAQ6s=;
        b=c4UIAg70abNyBgDK4LUIBEM/VuN1i+2c2Ah2jyj8CIERLNsC8BWw6Q/kvlcOcjQhKQz0GQ
        KMCRyHtxNjtiBQIL5b8x1M4krnrc3SHOipshnO98Dbkw42UMCpn09l5wH5PUbl1TW/eC+c
        bECtwJfSRwacGC3G1XQQg4NMDaoWWmU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-AkcQ_NCIMv2jHdgRMlm35Q-1; Sun, 01 Nov 2020 11:00:44 -0500
X-MC-Unique: AkcQ_NCIMv2jHdgRMlm35Q-1
Received: by mail-ot1-f71.google.com with SMTP id n13so340306otk.22
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 08:00:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vgk9YLGxl+ilKw1iu6HtFxOj8hP02Lb3fum/BlBAQ6s=;
        b=XSvDzcJ6V+ioFQXtbRScW7l2YgvuyunqMnJv5AkEv890BJjC+LvQzqjQD2GtjzQU5B
         0ZFel9ECOzSQqQfspTujtHhky3bQCYZyYgYIN/XWgYJrukTbbA27LYxxiLEzAehGy9WJ
         s+6IDFXysTJD+GX2L2ybiJwk5W6VWfniLn6dehDmUTl0MsCtDR0M3WrbmqVZPlaRzYgR
         Opt01ivJZQRaEWZ5OuHpLl5DN3c9kvzndlSlEj987wBYNLOC+vNRVzwRPXjG26rmW8aV
         r13e2zYZ5ftUolgvZHwhwM00wx4RjLG2mZ52+4qGTOHr8nobi768XajjcMXm7qXvj3Dp
         ZnqQ==
X-Gm-Message-State: AOAM532gRJuYfMv5H9K8nckcDE//oi0iUiMuk//P1Ndmc0/d4M8h0Swv
        x6ELpGZTxmy0W1QxAz8ClkhYk6SieaY1UF7Q6kivqt/1QsnFgAC5fcVpCYcizlfbX+bFySom3KO
        Mup+Q86ylpd310aogVDOoNM3/
X-Received: by 2002:a4a:9806:: with SMTP id y6mr9128866ooi.45.1604246443387;
        Sun, 01 Nov 2020 08:00:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVyT7JnEH2SuCBhZK8HzwoPK0Mcb7KeVaGChmVC3EtVOOG9EZ3UBdgb3/gT//qUNh8YjQFnQ==
X-Received: by 2002:a4a:9806:: with SMTP id y6mr9128857ooi.45.1604246443225;
        Sun, 01 Nov 2020 08:00:43 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m11sm2806572oop.6.2020.11.01.08.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 08:00:42 -0800 (PST)
From:   trix@redhat.com
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        ranjani.sridharan@linux.intel.com, sw0312.kim@samsung.com,
        kuninori.morimoto.gx@renesas.com
Cc:     bcm-kernel-feedback-list@broadcom.com, alsa-devel@alsa-project.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: bcm2835-i2s: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 08:00:37 -0800
Message-Id: <20201101160037.2295512-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/bcm/bcm2835-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index dc34fe1559c6..c2f7631e8705 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -797,7 +797,7 @@ static bool bcm2835_i2s_volatile_reg(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static bool bcm2835_i2s_precious_reg(struct device *dev, unsigned int reg)
@@ -807,7 +807,7 @@ static bool bcm2835_i2s_precious_reg(struct device *dev, unsigned int reg)
 		return true;
 	default:
 		return false;
-	};
+	}
 }
 
 static const struct regmap_config bcm2835_regmap_config = {
-- 
2.18.1

