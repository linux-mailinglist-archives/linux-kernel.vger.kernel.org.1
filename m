Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D38C290DDA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391153AbgJPWtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:49:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60185 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbgJPWtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:49:20 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kTYXB-0001gz-A3; Fri, 16 Oct 2020 22:49:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Connor McAdams <conmanx360@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/ca0132: make some const arrays static, makes object smaller
Date:   Fri, 16 Oct 2020 23:49:13 +0100
Message-Id: <20201016224913.687724-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate const arrays on the stack but instead make them
static. Makes the object code smaller by 57 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
 173256	  38016	    192	 211464	  33a08	sound/pci/hda/patch_ca0132.o

After:
   text	   data	    bss	    dec	    hex	filename
 172879	  38336	    192	 211407	  339cf	sound/pci/hda/patch_ca0132.o

(gcc version 10.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/hda/patch_ca0132.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 2b38b2a716a1..e0c38f2735c6 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7910,8 +7910,12 @@ static void ae7_post_dsp_asi_stream_setup(struct hda_codec *codec)
 
 static void ae7_post_dsp_pll_setup(struct hda_codec *codec)
 {
-	const unsigned int addr[] = { 0x41, 0x45, 0x40, 0x43, 0x51 };
-	const unsigned int data[] = { 0xc8, 0xcc, 0xcb, 0xc7, 0x8d };
+	static const unsigned int addr[] = {
+		0x41, 0x45, 0x40, 0x43, 0x51
+	};
+	static const unsigned int data[] = {
+		0xc8, 0xcc, 0xcb, 0xc7, 0x8d
+	};
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(addr); i++) {
@@ -7925,10 +7929,12 @@ static void ae7_post_dsp_pll_setup(struct hda_codec *codec)
 static void ae7_post_dsp_asi_setup_ports(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
-	const unsigned int target[] = { 0x0b, 0x04, 0x06, 0x0a, 0x0c, 0x11,
-					0x12, 0x13, 0x14 };
-	const unsigned int data[]   = { 0x12, 0x00, 0x48, 0x05, 0x5f, 0xff,
-					0xff, 0xff, 0x7f };
+	static const unsigned int target[] = {
+		0x0b, 0x04, 0x06, 0x0a, 0x0c, 0x11, 0x12, 0x13, 0x14
+	};
+	static const unsigned int data[] = {
+		0x12, 0x00, 0x48, 0x05, 0x5f, 0xff, 0xff, 0xff, 0x7f
+	};
 	unsigned int i;
 
 	mutex_lock(&spec->chipio_mutex);
-- 
2.27.0

