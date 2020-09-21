Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA751272089
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgIUKWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgIUKU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:20:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92867C0613E0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l15so11152919wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6FJQXqYTGnFs6xSsNBr+hoN1yvRXs/bBrFwOES8jAPM=;
        b=vBugCVnWSbwdACUQOFN1afCvzNLAXk3a/HYAl9BSIGDqalr4HiI9zq9sL1JffA/cXj
         I+aMWvpMTWmSbWktvHGsFmqVeVDH0FOkqfAUtv+95mDhX0mrurF7aMZLjxoVjzY9nNlq
         Trjcq4QJGV/Ot/YRkBmxzdFXcpVV9lFC85qSkjbn+ur77n8A+ZjQCPCCU+l71S6GgTj8
         fAINR+cQ109GY2vq6DpAowfEdEyLC0pOxMoljjMwyVxXp2cJEiLQX82deZwEnRS3JJVJ
         cDz3OMypYhxfAXmQoP15C7j6ztzvAdfu66/u2BgcxFbKdKe45TBJf5IlQP6cnqsMAPMi
         Sejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6FJQXqYTGnFs6xSsNBr+hoN1yvRXs/bBrFwOES8jAPM=;
        b=Vr0qpaK9+aT+ZDanDrg9zPOFWTwBxW8Uq/P+BzWKRjofYt0eax1cBE2z0J5PEL9/Fd
         R2bXz1FJrZLxYdAbZp9vDUjwkGQ/9MZvYEcaATWOBBbMW9NwYBFrh0K60arpSpUUGJ7v
         g6qPyBhe+ySIHgENXVeB9NxyZ0+wbjEp5+3uiR3t2MPcU7Tv4eQQy1Los8rvL5Nx8DiI
         LSojP0+yMaEKOXHpS57ZLD8pYRYLPdcJ3jUFaxHycHU3CHYaHc85v++HKEm0T5XX4J3Q
         BR5L8vjyBqdWOh7Szb50QHuIKSwKhLLgkgCXJX7lobEMai7NSZQSjd1jOu/CWdCVtg/J
         9c9A==
X-Gm-Message-State: AOAM5327Af8giMpQ4wCCZEnytnTRXN9VPjsr1i3ZEnye+L+VeYIenOKg
        Nzth/2HcXCB75GyVAkGmnvFyzA==
X-Google-Smtp-Source: ABdhPJy3JBJ82nITRQW7FeoI40pOMOYIUsRJiPlCUX5btahKih+LxvcRkcN8s7fkMOe/G2lzsTOaBw==
X-Received: by 2002:a7b:c8cc:: with SMTP id f12mr28551976wml.169.1600683657343;
        Mon, 21 Sep 2020 03:20:57 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l17sm18804629wme.11.2020.09.21.03.20.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:20:56 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC 26/49] staging: media: zoran: zoran does not support STD_ALL
Date:   Mon, 21 Sep 2020 10:20:01 +0000
Message-Id: <1600683624-5863-27-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fact, zoran does not support V4L2_STD_ALL, so let's enumerate what we
support.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index b1351455690f..6e95fbf5c7ea 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -1749,7 +1749,7 @@ static int zoran_enum_input(struct file *file, void *__fh, struct v4l2_input *in
 
 	strscpy(inp->name, zr->card.input[inp->index].name, sizeof(inp->name));
 	inp->type = V4L2_INPUT_TYPE_CAMERA;
-	inp->std = V4L2_STD_ALL;
+	inp->std = V4L2_STD_NTSC | V4L2_STD_PAL | V4L2_STD_SECAM;
 
 	/* Get status of video decoder */
 	decoder_call(zr, video, g_input_status, &inp->status);
-- 
2.26.2

