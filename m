Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14C61CFFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 22:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgELUxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 16:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELUxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:53:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2262DC061A0C;
        Tue, 12 May 2020 13:53:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g185so15161165qke.7;
        Tue, 12 May 2020 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oplmARCG9wf41YuyXYjcW5ILjydS54+070hhehLyIek=;
        b=Ay/yQBI1yrdv38SVM16gxQTwMzOQX3nlCpkNmvPWIhg2tyurwydIEpxEEb4CdGrPRT
         p+mDoRR5YbNpl9Op/82Ls/S5/SVbykYuIFfAdf7JmwZnnSvUWoDsw3yxA4UNaYac81qp
         ee2itBNCx3MbX0cyovTenZuB0Hv35cOiiKF/sQq9EPUYQkWGTC/nrkTKP08b99PhSDes
         8abIz2l/TlOabEcW0kDmHRql79spbeTbrNzJYSyjBNeqKG0TK2mJUFcOOT6xAIVL0Bbp
         iiiVkNYWpdy4mKc5CnCcfIhGBBboMIJChXRk5fMA6EOhij+MmiwNUxuRDI66fXnli0Pt
         Fskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oplmARCG9wf41YuyXYjcW5ILjydS54+070hhehLyIek=;
        b=HctNExQQ6/z2glBjaAtg2BoN3hIGxjPOeB8zHJ4Dtf/Ann2yOWUPOKNul28nZHpm0v
         qPx40U17nAq2z8oxquCdHXbpssvg9keixE07YOK8eyemSJtsMJWuPtFk+mqTqtmWEDcK
         wnQmsdYrzQCfuB1nGYgx2uJxHv/mzo7LiYODo4xvFabiHDGAj2HpJelxH8ODwu6NFoYw
         Vuc63q+4L9/VBVJpkhPqT4huMfFe9XK1iYDWD9iBwpN+1rkZWIVSX8qM21ZbrBBw1GCl
         8HUGSLbDV3WzATaoq+1Nx3ZVeP5AKKbzliynU0jDPL7eXTSKuPxJzGsF3kdVsTWyWSc1
         YPmw==
X-Gm-Message-State: AGi0PuZtywoTp7jwjaU1KJ0ZgR3GOBmqr2TSCTRLG/jvZ4Vsy2FOjF2U
        Y/CqPcGV7qopI8+1cEWtOEwG9gFhaX7rUQ==
X-Google-Smtp-Source: APiQypKTkapszzFqBaWJAmaiIYZQe+S7kVU0oZgpbsKJg27XcAMTCxOR9Capz4PUMlGG7oxHBE3nRA==
X-Received: by 2002:a37:8d85:: with SMTP id p127mr23039011qkd.44.1589316785938;
        Tue, 12 May 2020 13:53:05 -0700 (PDT)
Received: from sca.dev ([201.17.110.164])
        by smtp.gmail.com with ESMTPSA id h6sm9503374qkf.61.2020.05.12.13.53.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 13:53:05 -0700 (PDT)
From:   Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>
To:     linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, maxime.ripard@free-electrons.com,
        alencar.fmce@imbel.gov.br,
        Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: [PATCH 1/3] video: fbdev: ssd1307fb: Added support to Column offset
Date:   Tue, 12 May 2020 17:52:47 -0300
Message-Id: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br>
X-Mailer: git-send-email 1.9.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides support for displays like VGM128064B0W10,
which requires a column offset of 2, i.e., its segments starts
in SEG2 and ends in SEG129.

Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
---
 Documentation/devicetree/bindings/display/ssd1307fb.txt | 1 +
 drivers/video/fbdev/ssd1307fb.c                         | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
index 27333b9551b3..74a7b228bcef 100644
--- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
+++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
@@ -23,6 +23,7 @@ Optional properties:
   - solomon,com-lrremap: Display uses left-right COM pin remap
   - solomon,com-invdir: Display uses inverted COM pin scan direction
   - solomon,com-offset: Number of the COM pin wired to the first display line
+  - solomon,col-offset: Offset of columns (SEG) that the screen is mapped to.
   - solomon,prechargep1: Length of deselect period (phase 1) in clock cycles.
   - solomon,prechargep2: Length of precharge period (phase 2) in clock cycles.
                          This needs to be the higher, the higher the capacitance
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 12fa1050f3eb..ac88bbe174b6 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -77,6 +77,7 @@ struct ssd1307fb_par {
 	struct fb_info *info;
 	u8 lookup_table[4];
 	u32 page_offset;
+	u32 col_offset;
 	u32 prechargep1;
 	u32 prechargep2;
 	struct pwm_device *pwm;
@@ -468,11 +469,11 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
 
-	ret = ssd1307fb_write_cmd(par->client, 0x0);
+	ret = ssd1307fb_write_cmd(par->client, par->col_offset);
 	if (ret < 0)
 		return ret;
 
-	ret = ssd1307fb_write_cmd(par->client, par->width - 1);
+	ret = ssd1307fb_write_cmd(par->client, par->col_offset + par->width - 1);
 	if (ret < 0)
 		return ret;
 
@@ -644,6 +645,9 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	if (of_property_read_u32(node, "solomon,page-offset", &par->page_offset))
 		par->page_offset = 1;
 
+	if (of_property_read_u32(node, "solomon,col-offset", &par->col_offset))
+		par->col_offset = 0;
+
 	if (of_property_read_u32(node, "solomon,com-offset", &par->com_offset))
 		par->com_offset = 0;
 
-- 
2.23.0.rc1

