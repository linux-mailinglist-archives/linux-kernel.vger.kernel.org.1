Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A552D8276
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 23:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407072AbgLKW4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 17:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407063AbgLKW4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:56:00 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312E7C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 14:55:20 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 1so10140050qka.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 14:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91dC1JVTlycX9DwyWLDLt83zlsH68mf4lgen207BrgI=;
        b=AqqtCb4WjaYw2Ac8A65qbodZn5poIM0B6PsVJIFeXpreANb9qzaLOz+waqPB8KjOSZ
         Th3T0aFrAHW+duJIr0BCw6QzA1rTF+34wELRflkAvCngFjNM8nRoorwrHEL8bmctLQHV
         R1O856qVaN1IC6VUuhzIPH/3j4tqykuflXZECUAr3Q813KoM1LM22wEF2BcECN2A3BhF
         sy5kXMifjhFulcCKdpsr71ppeMHLKDshrXqEyzI3IAWi2lF+lpjaKODaogKVL6dD7JbT
         IN1caiGOx+wJBGv9RYgFkWb5vJ+LKiM8hXY9EI2i528jdih6OlvEhcHFDGBSipFaWe4y
         vg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91dC1JVTlycX9DwyWLDLt83zlsH68mf4lgen207BrgI=;
        b=qvpeCq/fq4aHahM8fz5SO6zzZ2zl48at7685LUTcrrUi6D3ESEKtdJT4PM7WLHUBHQ
         27jqbTEpXCD3IgM5FUGNwmF769IJSZKBI8sJWc2ZVOWlsq+9/lF2vFfC76jnJglPRBwM
         QhQtTTfSk60JgCXBfK6xjTRvYf/TegXIxdbdxF+2wAPyw5xHihwrTvvoAehj0864GrV5
         dZ6yCDqyISD+zwbx4VCuh3MSOP3LD00j8n3MoHBzLgYIsM7mCn6XFrPI7jQtD6RXPFUW
         6qYim846UrDWs/MOjGGlVghWg6YPnjXCgPppFilHKrjDGGbn3lbY9P3i24ljHiYmE1iU
         lQBA==
X-Gm-Message-State: AOAM532RTGrBjJTz8uLwEnmFmMsqtxfv681ul07NCRZUz8sTAfdRmvru
        8IJ+zs+bjY1XL8cR3eYookU=
X-Google-Smtp-Source: ABdhPJyiFdSxAUB9dEi6Qy9MMSVXa3+du6Eo6hrKhLi6zRvgDTfGZwi4SINrjvOUh97ryrGV6EAjUw==
X-Received: by 2002:a37:4fc4:: with SMTP id d187mr175606qkb.200.1607727319502;
        Fri, 11 Dec 2020 14:55:19 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id i4sm7409594qti.78.2020.12.11.14.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 14:55:19 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ALSA: hda/ca0132 - Add ZxR surround DAC setup.
Date:   Fri, 11 Dec 2020 17:55:03 -0500
Message-Id: <20201211225504.4508-2-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201211225504.4508-1-conmanx360@gmail.com>
References: <20201211225504.4508-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pre-dsp download initialization for the DAC's used in the surround
sound configuration. Fixes issues of no audio on surround channels.

Fixes: 2e492b8ee5da8 ("ALSA: hda/ca0132 - Add ZxR init commands")
Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9b6b7601a881..7e62aed172a9 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -9186,6 +9186,44 @@ static void r3di_pre_dsp_setup(struct hda_codec *codec)
 			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x04);
 }
 
+/*
+ * The ZxR seems to use alternative DAC's for the surround channels, which
+ * require PLL PMU setup for the clock rate, I'm guessing. Without setting
+ * this up, we get no audio out of the surround jacks.
+ */
+static void zxr_pre_dsp_setup(struct hda_codec *codec)
+{
+	static const unsigned int addr[] = { 0x43, 0x40, 0x41, 0x42, 0x45 };
+	static const unsigned int data[] = { 0x08, 0x0c, 0x0b, 0x07, 0x0d };
+	unsigned int i;
+
+	chipio_write(codec, 0x189000, 0x0001f100);
+	msleep(50);
+	chipio_write(codec, 0x18900c, 0x0001f100);
+	msleep(50);
+
+	/*
+	 * This writes a RET instruction at the entry point of the function at
+	 * 0xfa92 in exram. This function seems to have something to do with
+	 * ASI. Might be some way to prevent the card from reconfiguring the
+	 * ASI stuff itself.
+	 */
+	chipio_8051_write_exram(codec, 0xfa92, 0x22);
+
+	chipio_8051_write_pll_pmu(codec, 0x51, 0x98);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, 0x725, 0x82);
+	chipio_set_control_param(codec, CONTROL_PARAM_ASI, 3);
+
+	chipio_write(codec, 0x18902c, 0x00000000);
+	msleep(50);
+	chipio_write(codec, 0x18902c, 0x00000003);
+	msleep(50);
+
+	for (i = 0; i < ARRAY_SIZE(addr); i++)
+		chipio_8051_write_pll_pmu(codec, addr[i], data[i]);
+}
+
 /*
  * These are sent before the DSP is downloaded. Not sure
  * what they do, or if they're necessary. Could possibly
@@ -9447,8 +9485,10 @@ static void ca0132_alt_init(struct hda_codec *codec)
 		ca0113_mmio_command_set(codec, 0x30, 0x32, 0x3f);
 		break;
 	case QUIRK_ZXR:
+		chipio_8051_write_pll_pmu(codec, 0x49, 0x88);
 		snd_hda_sequence_write(codec, spec->chip_init_verbs);
 		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
+		zxr_pre_dsp_setup(codec);
 		break;
 	default:
 		break;
-- 
2.25.1

