Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA7627909B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 20:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgIYSdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 14:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729757AbgIYSdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 14:33:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1212FC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:33:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u3so2152073pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=67XUEXRCBbTegcwWQw/QiZzWAGtuLdAQbmq+caL+6RE=;
        b=s+AHGb3nlYV0VlfG+KkOscxHEcQODnOMWW5adUl29T9itRp8SkHDLG/4otOB3NuhIn
         NrKXRBSm2/JT33lpq3F0yXZWWGGQ1A8vQVk+YQexJt+PYI3cSzZNVO7mJ2H2Uf4u4ibV
         m0gg1KQ0wjlPWN4GqxvHyeb1xziSMbuI2bFW7CcbWL8/bNIBCvyVdqeBXXfaBuJi+OF9
         5vSS5/+AwUZhNJ+v59H/g+DTt5QdF7czUEc44UZpG8v/tzpjaIiV9BzoFTrQqaS1Lv5R
         AXKnc3gmTHHeExMv6EhvYxKeRUWvUoyDsuu+MHu8bFtegvpwEXrgCVv29I5T15uEzeB2
         Zrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=67XUEXRCBbTegcwWQw/QiZzWAGtuLdAQbmq+caL+6RE=;
        b=eFvzBWKhlrDRdso/y3FFpFCx3LOlY6s6EC4sactYRGIe5tcSHNO8FyyGwygRJWm90V
         YId+fmCPS65D+v3nbctPKvhgbd3s7SW1anu7JqZ9LFRhMRlZWVv5zJPVej3rWpK0OX/G
         KCNQj2xkHNMaShPjH0tc20VOBhldhKjD745+0U1xIS+hrTc/kfezSwAG7DhMA1CcVoJy
         7HZ5wBWU6FMMWN41xudGjFpYfudL8lFymFdZLVlPnlG3BsV5vhBW4+GP+OQTRJ4HkZbz
         t9aRVvS81Vh2GER6+FDbUGjFN/1StdIhByGHawK96z3pdQsF6+9+Lr97d5kV87f01B5o
         EUrQ==
X-Gm-Message-State: AOAM530NO6fX2T4JUX09XYeagNtscE3NQbpV5fcHVcHy/xoSDQvl/2Aj
        VzyHbs9S0JTilY0Nc4aeczUyx2IjDGZG0g==
X-Google-Smtp-Source: ABdhPJz0ablFEIyth3H5fFmPU2YUstaBRnmVvNI+rscF448UcL4nefAnQqyzTBUSXEqpKOLbFthz1w==
X-Received: by 2002:a17:90a:474c:: with SMTP id y12mr774202pjg.150.1601058819583;
        Fri, 25 Sep 2020 11:33:39 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r16sm2554546pjo.19.2020.09.25.11.33.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 11:33:39 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC v2 24/47] staging: media: zoran: use ZR_NORM
Date:   Fri, 25 Sep 2020 18:30:34 +0000
Message-Id: <1601058657-14042-25-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
References: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using hardcoded numbers, let's use some define for ZR NORM.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran.h        | 4 ++++
 drivers/staging/media/zoran/zoran_card.c   | 8 ++++----
 drivers/staging/media/zoran/zoran_driver.c | 6 +++---
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran.h b/drivers/staging/media/zoran/zoran.h
index 8f3faa4eb60f..87ca324f6ec2 100644
--- a/drivers/staging/media/zoran/zoran.h
+++ b/drivers/staging/media/zoran/zoran.h
@@ -22,6 +22,10 @@
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-fh.h>
 
+#define ZR_NORM_PAL 0
+#define ZR_NORM_NTSC 1
+#define ZR_NORM_SECAM 2
+
 struct zoran_sync {
 	unsigned long frame;	/* number of buffer that has been free'd */
 	unsigned long length;	/* number of code bytes in buffer (capture only) */
diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index 9fe2bc2b036a..8be7f8f0a020 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -911,18 +911,18 @@ static int zr36057_init(struct zoran *zr)
 		default_norm = 0;
 	if (default_norm == 0) {
 		zr->norm = V4L2_STD_PAL;
-		zr->timing = zr->card.tvn[0];
+		zr->timing = zr->card.tvn[ZR_NORM_PAL];
 	} else if (default_norm == 1) {
 		zr->norm = V4L2_STD_NTSC;
-		zr->timing = zr->card.tvn[1];
+		zr->timing = zr->card.tvn[ZR_NORM_NTSC];
 	} else {
 		zr->norm = V4L2_STD_SECAM;
-		zr->timing = zr->card.tvn[2];
+		zr->timing = zr->card.tvn[ZR_NORM_SECAM];
 	}
 	if (!zr->timing) {
 		pci_warn(zr->pci_dev, "%s - default TV standard not supported by hardware. PAL will be used.\n", __func__);
 		zr->norm = V4L2_STD_PAL;
-		zr->timing = zr->card.tvn[0];
+		zr->timing = zr->card.tvn[ZR_NORM_PAL];
 	}
 
 	if (default_input > zr->card.inputs - 1) {
diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index b910ad136b84..858e0910884c 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -1033,11 +1033,11 @@ static int zoran_set_norm(struct zoran *zr, v4l2_std_id norm)
 	}
 
 	if (norm & V4L2_STD_SECAM)
-		zr->timing = zr->card.tvn[2];
+		zr->timing = zr->card.tvn[ZR_NORM_SECAM];
 	else if (norm & V4L2_STD_NTSC)
-		zr->timing = zr->card.tvn[1];
+		zr->timing = zr->card.tvn[ZR_NORM_NTSC];
 	else
-		zr->timing = zr->card.tvn[0];
+		zr->timing = zr->card.tvn[ZR_NORM_PAL];
 
 	decoder_call(zr, video, s_std, norm);
 	encoder_call(zr, video, s_std_output, norm);
-- 
2.26.2

