Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7AC2772E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgIXNpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgIXNpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:45:04 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B61CC0613CE;
        Thu, 24 Sep 2020 06:45:04 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o25so1955489pgm.0;
        Thu, 24 Sep 2020 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXp4SMdhtGATfhHsl/+G06GlWj8IVOPfotDaVzkM7uw=;
        b=OtlvbpXF/ECfXRYBaiRcIpx2pOm3Z1RMgW1qGBA/sQ1DL0+a0Bcli09oIxL3wSwJXu
         oSwn2lwketEYcopnYRPPuESf9U4i+NbtjyozQIBtW06rGmd0TJj2rexyS6SAXoz33UmT
         M90QkLUoDK+GT2kzIQSQnQ6UG25KQ6ssQL6D3rdTVY1ltRb4YRsAW8hp0hJa8f6diefB
         MG3hFfcLuCzwBAU32ALcd0WPYXetuLK9FbXq27Fxj1p+WOJxwSMLNYT2gV5/QJL47JAT
         9D46CSzYubZW8Ho5DfCqEbZ1M24UF7xVaP6RW9dOA1c79qjSEKboPvHj64Rg+Gcc1j3G
         E/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXp4SMdhtGATfhHsl/+G06GlWj8IVOPfotDaVzkM7uw=;
        b=b2GXk7Obf/jsqzbyFRuTAy1HwIbud8NaMUDM13ayYIXVogCXfDnbzMsiUCeCicMtUU
         yQHcF9W1mOWIIkdrWMyiUxViQ4ef/oeLsCIE72V9wGOrU7r5grw/ZubC/uRurkpnidYE
         LNBJOtcQntL8LaEpDs1gcDh4kt5iP1gu4IeTTHbqH3S/ebYL55r2Tpc8djYrsJZANB/i
         CY739bR1imm0MPOoc0Rz8fhaa9Qff7clyIULZIk2dP5LU4ZiRW4Xa9x1DZMvSpW96usR
         vdZCn4jzU7CtVoWmk3EQ+uewP7KQgVYBI7zCGFQAWDt19h6hPxyNVlStMBa3KHOdV/8l
         KdlQ==
X-Gm-Message-State: AOAM532qlqNexeToHi9ZjBxJb3czDGqZPFUwcqeyHkC7uLzL4jafkrEQ
        gkl2wjT2GMnJtZfjJCMKvg==
X-Google-Smtp-Source: ABdhPJzXYqCs3PJDgKW5fdZ3Dh5AiaT47Pde38vaglC/Rl/0Pmj57uGXtxvq7ubpnQ73YLUxLhiy0A==
X-Received: by 2002:a63:a26:: with SMTP id 38mr1299965pgk.118.1600955104158;
        Thu, 24 Sep 2020 06:45:04 -0700 (PDT)
Received: from localhost.localdomain (n11212042027.netvigator.com. [112.120.42.27])
        by smtp.gmail.com with ESMTPSA id o5sm2534926pjs.13.2020.09.24.06.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 06:45:03 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] fbcon: Fix global-out-of-bounds read in fbcon_get_font()
Date:   Thu, 24 Sep 2020 09:43:48 -0400
Message-Id: <b34544687a1a09d6de630659eb7a773f4953238b.1600953813.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ef18af00c35fb3cc826048a5f70924ed6ddce95b.1600953813.git.yepeilin.cs@gmail.com>
References: <cover.1600953813.git.yepeilin.cs@gmail.com> <7fb8bc9b0abc676ada6b7ac0e0bd443499357267.1600953813.git.yepeilin.cs@gmail.com> <ef18af00c35fb3cc826048a5f70924ed6ddce95b.1600953813.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fbcon_get_font() is reading out-of-bounds. A malicious user may resize
`vc->vc_font.height` to a large value, causing fbcon_get_font() to
read out of `fontdata`.

fbcon_get_font() handles both built-in and user-provided fonts.
Fortunately, recently we have added FONT_EXTRA_WORDS support for built-in
fonts, so fix it by adding range checks using FNTSIZE(). 

This patch depends on patch "fbdev, newport_con: Move FONT_EXTRA_WORDS
macros into linux/font.h", and patch "Fonts: Support FONT_EXTRA_WORDS
macros for built-in fonts".

Cc: stable@vger.kernel.org
Reported-and-tested-by: syzbot+29d4ed7f3bdedf2aa2fd@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=08b8be45afea11888776f897895aef9ad1c3ecfd
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 66167830fefd..bda24c64e646 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2492,6 +2492,9 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font)
 
 	if (font->width <= 8) {
 		j = vc->vc_font.height;
+		if (font->charcount * j > FNTSIZE(fontdata))
+			return -EINVAL;
+
 		for (i = 0; i < font->charcount; i++) {
 			memcpy(data, fontdata, j);
 			memset(data + j, 0, 32 - j);
@@ -2500,6 +2503,9 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font)
 		}
 	} else if (font->width <= 16) {
 		j = vc->vc_font.height * 2;
+		if (font->charcount * j > FNTSIZE(fontdata))
+			return -EINVAL;
+
 		for (i = 0; i < font->charcount; i++) {
 			memcpy(data, fontdata, j);
 			memset(data + j, 0, 64 - j);
@@ -2507,6 +2513,9 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font)
 			fontdata += j;
 		}
 	} else if (font->width <= 24) {
+		if (font->charcount * (vc->vc_font.height * sizeof(u32)) > FNTSIZE(fontdata))
+			return -EINVAL;
+
 		for (i = 0; i < font->charcount; i++) {
 			for (j = 0; j < vc->vc_font.height; j++) {
 				*data++ = fontdata[0];
@@ -2519,6 +2528,9 @@ static int fbcon_get_font(struct vc_data *vc, struct console_font *font)
 		}
 	} else {
 		j = vc->vc_font.height * 4;
+		if (font->charcount * j > FNTSIZE(fontdata))
+			return -EINVAL;
+
 		for (i = 0; i < font->charcount; i++) {
 			memcpy(data, fontdata, j);
 			memset(data + j, 0, 128 - j);
-- 
2.25.1

