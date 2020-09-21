Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC82720BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgIUKYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgIUKUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:20:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B4DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so12116475wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yT+7g7cZmwgOzhVIcE+1qXxZwSKLTSSFChevbMCeH+o=;
        b=EwZ63cO+tlKq2AG2nWrD4d2XhWegdUe1jNXNvFBAHdNz9ilGkOuIxnjK/BXVeAztet
         sMdaHyNIncAkyoVjVduxgUryKkGRtPpK8qeDio3OCo3s6f2+N2h9ZrPSqPURG0CHPbPF
         xTaCDKucrtN/tEy9toRvNYHhRsriAYOexDMdaidTJMK4cIis90vX6y0DYFhFJT4xeRBq
         t97KIVx6XPo79l8Crf+CMlOCgYbbaMoha0RzONlzpAmLmupgrfhJoBiKH9+C+879JCS+
         SBWX+qDB81ND2VSRf20KfJZyWzjp/ebLz0TSzJSK8LPNkq3a4gGl4EpfolRezWGKTY4J
         j/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yT+7g7cZmwgOzhVIcE+1qXxZwSKLTSSFChevbMCeH+o=;
        b=eUVYmgXTexOSWC/9xZP9jBWzXfmB5nIoIAbe48fgH03Roti8YORXKv2toa2t0WExB2
         OuESX2x+RM76uX4TbHIYjaOi1xLnlM6CnYq/u+Z/j/Mq02x+28RIJ1WYU5P7/tJvwBfx
         uJUKnOE+2n0Z0NnQAwcaGSKx9rBPyGJNhJss8X/Xq+g7E3XLeQ8aciPwNA+S2Qeqcz9B
         SvlLzmfusQUPI1s9kcgebJwRNN58pJiXnaqB9/p+3+L/HE4opDDAGw79tVQ3dXrNp3B8
         SilWfCiiltG+D07Ex6XgxLOyvta7pzPEN4C/tST7UjEOWjTCT2y7DoCN0zEkVol3yX9M
         mTKQ==
X-Gm-Message-State: AOAM5310QbZqHgURZI8fXkB0eYCRm5ARowaok72yE/LBr6Z+EPm0NPS7
        5jlBxpfPK3rVt7j9R4adBhiFjw==
X-Google-Smtp-Source: ABdhPJxdpQHqO5++kMBiuLNEhD+xHOgH30GP/PD9/JEzGy2S+yIbg+UTXWS7yONq0phNqnWGNX5pFw==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr50608020wrv.303.1600683639289;
        Mon, 21 Sep 2020 03:20:39 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l17sm18804629wme.11.2020.09.21.03.20.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:20:38 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC 07/49] staging: media: zoran: do not forward declare zr36057_init_vfe
Date:   Mon, 21 Sep 2020 10:19:42 +0000
Message-Id: <1600683624-5863-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move function for avoiding forward declaration

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_device.c | 44 +++++++++++-----------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_device.c b/drivers/staging/media/zoran/zoran_device.c
index 783d7bce6c80..0985b16d5a55 100644
--- a/drivers/staging/media/zoran/zoran_device.c
+++ b/drivers/staging/media/zoran/zoran_device.c
@@ -55,7 +55,27 @@ static bool lml33dpath;		/* default = 0
 module_param(lml33dpath, bool, 0644);
 MODULE_PARM_DESC(lml33dpath, "Use digital path capture mode (on LML33 cards)");
 
-static void zr36057_init_vfe(struct zoran *zr);
+/*
+ * initialize video front end
+ */
+static void zr36057_init_vfe(struct zoran *zr)
+{
+	u32 reg;
+
+	reg = btread(ZR36057_VFESPFR);
+	reg |= ZR36057_VFESPFR_LittleEndian;
+	reg &= ~ZR36057_VFESPFR_VCLKPol;
+	reg |= ZR36057_VFESPFR_ExtFl;
+	reg |= ZR36057_VFESPFR_TopField;
+	btwrite(reg, ZR36057_VFESPFR);
+	reg = btread(ZR36057_VDCR);
+	if (pci_pci_problems & PCIPCI_TRITON)
+		// || zr->revision < 1) // Revision 1 has also Triton support
+		reg &= ~ZR36057_VDCR_Triton;
+	else
+		reg |= ZR36057_VDCR_Triton;
+	btwrite(reg, ZR36057_VDCR);
+}
 
 /*
  * General Purpose I/O and Guest bus access
@@ -1474,25 +1494,3 @@ void zr36057_restart(struct zoran *zr)
 	btwrite((0x81 << 24) | 0x8888, ZR36057_GPPGCR1);
 }
 
-/*
- * initialize video front end
- */
-
-static void zr36057_init_vfe(struct zoran *zr)
-{
-	u32 reg;
-
-	reg = btread(ZR36057_VFESPFR);
-	reg |= ZR36057_VFESPFR_LittleEndian;
-	reg &= ~ZR36057_VFESPFR_VCLKPol;
-	reg |= ZR36057_VFESPFR_ExtFl;
-	reg |= ZR36057_VFESPFR_TopField;
-	btwrite(reg, ZR36057_VFESPFR);
-	reg = btread(ZR36057_VDCR);
-	if (pci_pci_problems & PCIPCI_TRITON)
-		// || zr->revision < 1) // Revision 1 has also Triton support
-		reg &= ~ZR36057_VDCR_Triton;
-	else
-		reg |= ZR36057_VDCR_Triton;
-	btwrite(reg, ZR36057_VDCR);
-}
-- 
2.26.2

