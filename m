Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A64A24E015
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgHUSzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 14:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgHUSyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:54:25 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A282DC061796
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:15 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t6so1090392qvw.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nh1SeH655blb1lMsGRsZcuvpTaQWPjWEn/zrRW9ahdk=;
        b=mE+a7e+L2zMvC3oBW95DSznj8stF0K+CCHUS7uvPsHY2jNp+L2nhKvp1nNnfpk3bIe
         jOxyztVEfgvd7sf8pbyzkprs0aNnNrElB8py6oBxLjx6+1u6rRUWFmlcdH4PWmNDVMIG
         zshJDg8WrAiyHQea1lJB9G2YN3hCVt69g2ZmK2ZijznzbY9HGfTXerRQAApQXwx5oB5k
         0O1u0C3ba6Pwh5fZVNML/PErCmcyf+ZwEalBXFM3Oz5TzCKuaoq+WG1l+WpyQwchg0Ls
         2oQFChZEF+Hb3P326cFah7Qi4l4PEay+Z6lA5I9mVOdFABo80L8nAl/WDScRbMDUtcyT
         GsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nh1SeH655blb1lMsGRsZcuvpTaQWPjWEn/zrRW9ahdk=;
        b=tfMmr1m80919WDDJDd5g8dOLyjDShp1VqV2UNm9aYhMxeDvgUDF21vFb/B73JHlNl+
         Ge+iLA/3WYOFrxtLghHjVhk7+QsbveFPvnvH7xDHWDnBmTksImDBwlweMo7ZAI8VXboC
         3E8PBtGMvEdkWBMdAbro8NJ4ZFvGqkBxKqjjR17UiyY/KcMfQyGG6AnijTiDB6PcWJHk
         xG94TGPO5gIuzu0Gh/3oHRGQ1CaZfQpfnhIcUEMK9GpJlSIdlpPjmzVrUdcEiTVcxDZd
         CQ6AS6HH6t8TbZk/VJPCa7n1KpSvhrYouYc1wD93y3nkGhhCHEck7Lm9/drQ1qkfo6D6
         ba0g==
X-Gm-Message-State: AOAM531MjREc7TTgtbF6nYBR84EVXF7RMxfDyCvJEKMNEQsDgUZRik8V
        dsyJNqaCGmlpoDU98gKwTSc=
X-Google-Smtp-Source: ABdhPJwE4nMumlYjaLS4lWaAmu6jEEVGiRXoA1KUQpzmOPGLoyj3FUleVHp+0RO/r0PTDtY2AX2QIA==
X-Received: by 2002:ad4:510b:: with SMTP id g11mr3567035qvp.20.1598036054969;
        Fri, 21 Aug 2020 11:54:14 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:54:14 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/20] ALSA: hda/ca0132 - Add AE-7 microphone selection commands.
Date:   Fri, 21 Aug 2020 14:52:35 -0400
Message-Id: <20200821185239.26133-19-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200821185239.26133-1-conmanx360@gmail.com>
References: <20200821185239.26133-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AE-7 quirk data for setting of microphone. The AE-7 has no front
panel connector, so only rear-mic/line-in have new commands.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index ad594c2d47ec..933f3b0be63e 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4997,6 +4997,15 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x00);
 			tmp = FLOAT_THREE;
 			break;
+		case QUIRK_AE7:
+			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x00);
+			tmp = FLOAT_THREE;
+			chipio_set_conn_rate(codec, MEM_CONNID_MICIN2,
+					SR_96_000);
+			chipio_set_conn_rate(codec, MEM_CONNID_MICOUT2,
+					SR_96_000);
+			dspio_set_uint_param(codec, 0x80, 0x01, FLOAT_ZERO);
+			break;
 		default:
 			tmp = FLOAT_ONE;
 			break;
@@ -5042,6 +5051,14 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		case QUIRK_AE5:
 			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x00);
 			break;
+		case QUIRK_AE7:
+			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x3f);
+			chipio_set_conn_rate(codec, MEM_CONNID_MICIN2,
+					SR_96_000);
+			chipio_set_conn_rate(codec, MEM_CONNID_MICOUT2,
+					SR_96_000);
+			dspio_set_uint_param(codec, 0x80, 0x01, FLOAT_ZERO);
+			break;
 		default:
 			break;
 		}
@@ -5051,7 +5068,10 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		if (ca0132_quirk(spec) == QUIRK_R3DI)
 			chipio_set_conn_rate(codec, 0x0F, SR_96_000);
 
-		tmp = FLOAT_ZERO;
+		if (ca0132_quirk(spec) == QUIRK_AE7)
+			tmp = FLOAT_THREE;
+		else
+			tmp = FLOAT_ZERO;
 		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
 
 		switch (ca0132_quirk(spec)) {
-- 
2.20.1

