Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8033E30457A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392595AbhAZRiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbhAZHuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:50:50 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1F5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 23:50:02 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t8so11077425ljk.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 23:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QzNr7Y36ceZ98RJN+WjlQV3oeSFVn4zACIduR95Oy6w=;
        b=YMB8K50GIVNRpC0zCf5QxVa16FCljbVWL2+bEBT+BXpkJvwwah/jjSyt3rAn2FV3eq
         3Ht3q/hPN187G3xvyqaETyQkgy1AhyJ544lujYGu3JqBnYz9/OqJo71R7FMTJxE1BATB
         UFSxUViJ1rOyidSmEJFKCCKjmouKQzyz9/fGmkxyuMNSEy82BnzYKml+mkcpjwvA58/N
         dTWmFLIFs9pjMwj8mmqDSEsQpXl+nPIS3xxkMHNgt7EtSqdfEfU/dwN8YROOO0AU5BW5
         rUN186YmBRr5gjXTjURMPYYDcvNR42MzcuGEbyNQqMLdICSW+KdLgda1KbED9ThhH03q
         LOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QzNr7Y36ceZ98RJN+WjlQV3oeSFVn4zACIduR95Oy6w=;
        b=miG1Zw2QX7HcLdmeVDMCoqAGOxbsRqiEqAdUGFvQku6MeFD3bdw3u5Rr9Q9rWZNfXA
         WNKzI5IiL1bzNZ4ml/HOaGlCLYi5/xRG9P7HelTJ/x9tcqEHRpZNcTQYK9Mnvx+xo6fN
         z8ly7Btc36vJ3GYDMblNQjHxLNwVudUwgi23hI+/sLGcr5o1ivP475vc5h0Bl9SCt+X9
         jhkzrgWzPo1X+ZIkDlbX00/o5CYRSpWfzf3HEXtb6hxOARy1bKcRURkLuBcbI+v9RKx0
         XtHzY7aiU8DUAJcaKkjk6bE+cvR0hjeLpGtZN2ZZVxs726slYjOrEed5XJD9cKrTD+b5
         iSHQ==
X-Gm-Message-State: AOAM530pfaP0AAmzr2MmiB+dA3nsgMHHGR0lx1BNLu1CfzUkWoI8B1sJ
        WR18hTsaurcWs7QSvJZtii/d5w==
X-Google-Smtp-Source: ABdhPJzGj0hsn5+J9qBrOrmv41eiastPsTnom0tHpYcTffF0mdgOwieJ0RsqviboExS19wjT1ye9CQ==
X-Received: by 2002:a2e:94d0:: with SMTP id r16mr2232979ljh.332.1611647400805;
        Mon, 25 Jan 2021 23:50:00 -0800 (PST)
Received: from localhost.localdomain ([85.249.43.69])
        by smtp.googlemail.com with ESMTPSA id j2sm2401068lfe.134.2021.01.25.23.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 23:50:00 -0800 (PST)
From:   Andrey Konovalov <andrey.konovalov@linaro.org>
To:     mchehab@kernel.org, dave.stevenson@raspberrypi.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        sakari.ailus@linux.intel.com, peter.griffin@linaro.org,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Subject: [PATCH] media: i2c: imx219: Implement V4L2_CID_LINK_FREQ control
Date:   Tue, 26 Jan 2021 10:49:34 +0300
Message-Id: <20210126074934.26980-1-andrey.konovalov@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This control is needed for imx219 driver, as the link frequency
is independent from the pixel rate in this case, and can't be
calculated from the pixel rate.

Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---
 drivers/media/i2c/imx219.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 92a8d52776b8..6e3382b85a90 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -390,6 +390,10 @@ static const struct imx219_reg raw10_framefmt_regs[] = {
 	{0x0309, 0x0a},
 };
 
+static const s64 imx219_link_freq_menu[] = {
+	IMX219_DEFAULT_LINK_FREQ,
+};
+
 static const char * const imx219_test_pattern_menu[] = {
 	"Disabled",
 	"Color Bars",
@@ -547,6 +551,7 @@ struct imx219 {
 	struct v4l2_ctrl_handler ctrl_handler;
 	/* V4L2 Controls */
 	struct v4l2_ctrl *pixel_rate;
+	struct v4l2_ctrl *link_freq;
 	struct v4l2_ctrl *exposure;
 	struct v4l2_ctrl *vflip;
 	struct v4l2_ctrl *hflip;
@@ -1269,7 +1274,7 @@ static int imx219_init_controls(struct imx219 *imx219)
 	int i, ret;
 
 	ctrl_hdlr = &imx219->ctrl_handler;
-	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 11);
+	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 12);
 	if (ret)
 		return ret;
 
@@ -1283,6 +1288,14 @@ static int imx219_init_controls(struct imx219 *imx219)
 					       IMX219_PIXEL_RATE, 1,
 					       IMX219_PIXEL_RATE);
 
+	imx219->link_freq =
+		v4l2_ctrl_new_int_menu(ctrl_hdlr, &imx219_ctrl_ops,
+				       V4L2_CID_LINK_FREQ,
+				       ARRAY_SIZE(imx219_link_freq_menu) - 1, 0,
+				       imx219_link_freq_menu);
+	if (imx219->link_freq)
+		imx219->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+
 	/* Initial vblank/hblank/exposure parameters based on current mode */
 	imx219->vblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					   V4L2_CID_VBLANK, IMX219_VBLANK_MIN,
-- 
2.17.1

