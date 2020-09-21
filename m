Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E951D27208D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgIUKXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgIUKU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:20:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED603C0613D8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z9so12016625wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W9l+Ys/sZM3d6xhrHezcVkS5bzDQH0s3RIYh871x9x4=;
        b=iqAWoqv5mek5bGr8V+7R0brhUWGzYzXqVnoTLGANdKVfzIASu5Ltfsvs/4QvSr1bUj
         W13DByuHiY/QO33bU9WbKnRQIveOUq9DnzlbCwj/k9Wb0sXc6xN/r7a24sY5Mr5fmlW9
         fehkIyJ/btG4MOLjcvxxxBmQsEuU8/+Q77ItYkW1vYAZuYW8Hgcj1G7tbGddUM6yjBoc
         2f5+DJ7tggv8b7IlDjP2SRf7gJRqMLVtiFedDbDt3ktarlkUN64pGtcv0lmwGrAQQM74
         73MCe6ygzcqb+xnEfU1jGZgwFmrKtVHDR4cuOOXIN60VVQH6n14jNbvOSWLyWMYFWQxx
         m06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W9l+Ys/sZM3d6xhrHezcVkS5bzDQH0s3RIYh871x9x4=;
        b=JTPNtkkkTXXJDMeFtup9mz8hnQmhvyBzegn0LQMEtlv7rIiFS3YWxWv/8CBnnk5rFO
         khz0UQExaJ/uo3/IFP0k5wweqHRdMOFrfcvCkJ+NAHX2RAuhYj3rWnvhRHcCOSSt36Cw
         kRLUvhY60ui9roHGKi0cB96Xyp1qO+HpSLZp3YKGq+/SJJoQBuixhRyW2xzpdycGSBKW
         KAKU8pG50qy2tKp2GkNCaCLFZpOVAjtLt820lg7AfqY0S0TL5gUEU6Cc/MlywUOIFSY8
         h2qj3ts5OHHFJLCHQFiQXIvpc4lHv3SQEoiiX5k3+8BvY2AMPY8+FsyeJiYMIYgAS7nS
         5WPw==
X-Gm-Message-State: AOAM5321Fb+Jf4m3PZr+LU8ffi73z/fqgVHar5qcmDWjjmpHx+uYoTTw
        CuE8sodWAn6GMP99IsQQJsWq5g==
X-Google-Smtp-Source: ABdhPJx+Jio63BI97Ba3xgqm05G+Ycj9Xis82lW+zvFdcZtzfep2WU/z7PUICZIkSF0z6EKAwYAVtw==
X-Received: by 2002:a1c:6187:: with SMTP id v129mr29088035wmb.35.1600683653663;
        Mon, 21 Sep 2020 03:20:53 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l17sm18804629wme.11.2020.09.21.03.20.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:20:53 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC 22/49] staging: media: zoran: Change zoran_v4l_set_format parameter from zoran_fh to zoran
Date:   Mon, 21 Sep 2020 10:19:57 +0000
Message-Id: <1600683624-5863-23-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to get rid of zoran_fh, so let's change function arguments.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_driver.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index 9d39e98c9af1..078575334b5d 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -401,11 +401,9 @@ static void jpg_fbuffer_free(struct zoran_fh *fh)
 /*
  *   V4L Buffer grabbing
  */
-
-static int zoran_v4l_set_format(struct zoran_fh *fh, int width, int height,
+static int zoran_v4l_set_format(struct zoran *zr, int width, int height,
 				const struct zoran_format *format)
 {
-	struct zoran *zr = fh->zr;
 	int bpp;
 
 	/* Check size and format of the grab wanted */
@@ -1665,7 +1663,7 @@ static int zoran_s_fmt_vid_cap(struct file *file, void *__fh, struct v4l2_format
 
 	map_mode_raw(fh);
 
-	res = zoran_v4l_set_format(fh, fmt->fmt.pix.width, fmt->fmt.pix.height, &zoran_formats[i]);
+	res = zoran_v4l_set_format(zr, fmt->fmt.pix.width, fmt->fmt.pix.height, &zoran_formats[i]);
 	if (res)
 		return res;
 
-- 
2.26.2

