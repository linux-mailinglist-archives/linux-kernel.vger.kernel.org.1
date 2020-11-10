Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57772ACF86
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgKJGSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgKJGSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:18:05 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635DFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 22:18:05 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r10so9253731pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 22:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccUarTYp6bUjAfShVkr+xLVHhptW5cuMEyNTixMpJuY=;
        b=SbXU6V+16z1iwH4UtdwUHiRG/7uWh5yyAbymm3bCo7PQ2IdiomfpnwueWB1+QwT1li
         ZbDFISb/BiPX+J/2JpSJ78KtlhwdyOapfpUOpjAdJ5m1eTyKZKU+Kpm3me3KJr51RAp+
         JIMm9fJE+oCIcD2uoCvcdT+S7F0Cc2I+xxkKr8YGpIDIHbrQ7141rJZEYO4CZgTSBbhK
         NA823OjWgwKQSgU3xnU3jc7vd89AxYPBQTwdzzlY0NS9xAgPe8wBKVs8SCxsFaz/Nk/w
         ihHiwRbtHb/UiUIH5LYVd0VmYLSG57GfvAyWTttq6g2crkjL6wT+l+g4tZwSsBFGs31F
         20hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccUarTYp6bUjAfShVkr+xLVHhptW5cuMEyNTixMpJuY=;
        b=dlsWxyZ4P443h+EZXVQwvEbqG7XrUtbegAkVLUr4EASjqMI8g93h/cZtqFoT/GENmu
         gAb5frUr+Qf7nAp0eLIjE8pkVrrZ3j0WnWR1oAhaxN2AI/tuw8FHEvwrnNvmS+OkMK6F
         8jW94KoyWOtNQVYodWAemKVkpNdqHlz0/rW7hPkB8BVQgKfD2Gf/UVNsdemhjvytlrDG
         oNbez0bZVELVbmScuAR/XcUXTcclFyEs2fkRQcTr5HzUSvUlB+V0/FaU5ZDqV6w7ODGy
         BX3d0AOX1C0c5ZnhCQCWJLcmN8H8ZqJyapxSN28qvkcs82q8JJrOpOj81kxJNCvwRyl7
         mxlA==
X-Gm-Message-State: AOAM531YnxeVWxrZoZAqLX+kXzGCPRf4YzM2Oq9aI+ZbxLC8b8TBDaql
        RjGsOhAFDkyki7G0MCcQHro=
X-Google-Smtp-Source: ABdhPJyEGK0PaB/3/W8nZHe1MfN+X3vhEkH+DUfJMHVEGBW7QiQZHtb8W5P9wSS7U6r+f+sdjFNrYQ==
X-Received: by 2002:a17:90a:ec04:: with SMTP id l4mr3352700pjy.131.1604989084764;
        Mon, 09 Nov 2020 22:18:04 -0800 (PST)
Received: from dmans-PC.localdomain (122-151-241-1.sta.wbroadband.net.au. [122.151.241.1])
        by smtp.googlemail.com with ESMTPSA id w63sm13273224pfc.120.2020.11.09.22.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 22:18:04 -0800 (PST)
From:   Daniel <dmanlfc@gmail.com>
Cc:     dmanlfc@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hector Martin <marcan@marcan.st>,
        Alexander Tsoy <alexander@tsoy.me>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?q?Franti=C5=A1ek=20Ku=C4=8Dera?= <franta-linux@frantovo.cz>,
        Dmitry Panchenko <dmitry@d-systems.ee>,
        Gregor Pintar <grpintar@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio : Add support for the Pioneer DJ DDJ-RR controller.
Date:   Tue, 10 Nov 2020 16:17:40 +1000
Message-Id: <20201110061742.78033-1-dmanlfc@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 sound/usb/quirks-table.h | 56 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 3c1697f6b60c..a39233cb4d72 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3530,7 +3530,61 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 		}
 	}
 },
-
+{
+	/*
+	 * PIONEER DJ DDJ-RR
+     * PCM is 6 channels out & 4 channels in @ 44.1 fixed
+	 */
+	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x000d),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 6, //Master, Headphones & Booth
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x01,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+						   USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_44100,
+					.rate_min = 44100,
+					.rate_max = 44100,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 44100 }
+				}
+			},
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 4, //2x RCA inputs (CH1 & CH2)
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x82,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+						 USB_ENDPOINT_SYNC_ASYNC|
+						 USB_ENDPOINT_USAGE_IMPLICIT_FB,
+					.rates = SNDRV_PCM_RATE_44100,
+					.rate_min = 44100,
+					.rate_max = 44100,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 44100 }
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 {
 	/*
 	 * Pioneer DJ DJM-900NXS2
-- 
2.29.2

