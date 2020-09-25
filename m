Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD07B27907F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 20:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgIYScg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 14:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729904AbgIYScf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 14:32:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5BEC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:32:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n14so4000651pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ni9H5s6lxVysOmGHLIY+1loUeP0ntGh2bLjI55hkPSU=;
        b=p0/0MtqLxzqxOW14ixw7GaBTJjATN+e+GLL1347olTxePReRnfh1tj6bsa0ZhF+XgO
         G9PYqPZYFJj6KRpD2bEvZ4eu9CJq/rNeJQco5f1bJ1OirK2ZMYqOJMK11Wpx76/m0neU
         NdQOmaeRTuJj1gLLgi1P0lfrHImPZxOptzVpIy35dgtA6We12gdKGXEodCyTctYQnhYn
         kVTLpXF7mHPqIiW9g3fnHCTICUUmiJ/A/xyY1V9cOEFy8VA+88Yy57UA7IogGu4+lxzn
         1aYG6Px3+cSPAF4VaI4hXHIvztRtl4vliyEa84cj15a7zwE2h4cP8vvS9YE8ONVjlqlS
         fiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ni9H5s6lxVysOmGHLIY+1loUeP0ntGh2bLjI55hkPSU=;
        b=VkV7rFFZi5I3uKKa6zu1TRqPYgZ/5AbKorpYCBdyGE9gJBakDAjmIzThyWtgLMVfXn
         5Ers/+zRQBWZnCwzUb6nfeMuHuUTj3lL+JXZrG8bXrh6dXfdNbc74Qp9/6DWJFQqFn2M
         lHf8OLDaqltaeJJyayEwt2PMiN/aUnGg6VWwB5yIxnoIqNUcXQaOf00GEmBKN/HBKlTt
         D43Xr+OpM4vg75ceGGkZn96QU+t7yBskaFieSUHmCpi/lUZjoblFfw+rh8nAWk4i5Miu
         2Nt5RRwNnQQfl8t6J+RrWpg7o0mXQnajhjJMxKWZhm5V4FeD6v5K3oR8OxPLN1wTcecf
         7epA==
X-Gm-Message-State: AOAM530baOy3QwmW4p3TXJcMRzAgzqTzoBU7imzW31G5Z2AIOPrNJ/7N
        plMpVy+DuZniIctTHtf9KiMYeYdu9ns1aA==
X-Google-Smtp-Source: ABdhPJwHuivyD+GJ9o1HaKo+iLk9tCzpRj85MBSaa9JVJGl0b1r0krrJw+eVCwpsa9BsOGPTCgEWCA==
X-Received: by 2002:a63:fe03:: with SMTP id p3mr249218pgh.100.1601058754979;
        Fri, 25 Sep 2020 11:32:34 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r16sm2554546pjo.19.2020.09.25.11.32.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 11:32:34 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC v2 13/47] staging: media: zoran: use VFL_TYPE_VIDEO
Date:   Fri, 25 Sep 2020 18:30:23 +0000
Message-Id: <1601058657-14042-14-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
References: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VFL_TYPE_GRABBER type was removed, so let's use the new type.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index 93a0817a3936..55315f67b3b9 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -962,7 +962,7 @@ static int zr36057_init(struct zoran *zr)
 	 * another day.
 	 */
 	zr->video_dev->vfl_dir = VFL_DIR_M2M;
-	err = video_register_device(zr->video_dev, VFL_TYPE_GRABBER, video_nr[zr->id]);
+	err = video_register_device(zr->video_dev, VFL_TYPE_VIDEO, video_nr[zr->id]);
 	if (err < 0)
 		goto exit_free;
 	video_set_drvdata(zr->video_dev, zr);
-- 
2.26.2

