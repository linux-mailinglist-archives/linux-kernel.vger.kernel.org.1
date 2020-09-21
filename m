Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B631272071
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgIUKVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgIUKVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:21:14 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ED3C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:21:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l9so12025126wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Go04h4cBZb8oManNnBUCEv0xT9mbFOVFD/8tb3hzAWA=;
        b=B0KJNIujqWSJKiTDeZnTlqwipUX6r3YfWEvq0cg/FTY1nbvCf44+V12zE/P+TK8yc4
         IYJMTjR653cKibE9xcUEnJXi/bcA6biRg626F6nkeixexu3kBXmM+EaMFJ7ex+L6QatM
         IMdqzflT53PYZViuhqE9bVztQ959JmLH6cbkK6lnMv5ayh0JId6a+5gowWauFiivSiPq
         LQsMn/hJtPZ8+hjrO8OVN6MYO+bZNdCWBU43/2biQSM9VxjIutjMrg2pwXkyWM8nP2e0
         lm0zNJTdizABDmwyy6uVAeNjkv6/+HHrAYJi1/rQMyEkxI713J6IcqvUykAl/OR2KR8c
         /BVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Go04h4cBZb8oManNnBUCEv0xT9mbFOVFD/8tb3hzAWA=;
        b=rIl7yFLZ1OwwsyUNhGyeh32ZSRKGmfIgWEo/ICzMhzfGTO0os2r2r449PYkoKJ29Hr
         VR75BWv63gWsZeGkGmMFBlx/NDnExevATTH8q81e44kMkErrqF/aHqeuJ4hAw6ojQF9r
         8V+zt6sgcQMbNcePUJQdHZpT8jyrET5zvCs/yM2ut2KM0jY4qfsEaJhwJ5uSRmgelvy6
         MoDiTXaPhdv7Y1Unxa38KIZ6BlQXT3feuEcmVXA4GWZ9UWocWVpUVHfGHwjBvxnB62nk
         HPkBz6A2O/bGRBJJZcTPixzF0DSYHaqu+OmEbYXaK/yH7xkbWP+Lzy+My0HxUVVS07te
         vLjQ==
X-Gm-Message-State: AOAM531XFioF+TxGAIrh/T1pJZSdKdmI+7UXtxUMYplkvmCR2uRBpzAt
        VP+qSbS5YTo+QZCZSTDUTbPwqA==
X-Google-Smtp-Source: ABdhPJznbbQ885WNgPecxK2K2Os4ZRphFdWauz9bE1BZIsLl7gLHwuQXxk1MFKHFhYL5ZQZwL9U6/w==
X-Received: by 2002:a7b:c0ca:: with SMTP id s10mr29337577wmh.103.1600683672894;
        Mon, 21 Sep 2020 03:21:12 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l17sm18804629wme.11.2020.09.21.03.21.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:21:12 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC 43/49] staging: media: zoran: add vidioc_g_parm
Date:   Mon, 21 Sep 2020 10:20:18 +0000
Message-Id: <1600683624-5863-44-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding vidioc_g_parm made v4l compliance happy.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index 0b4bfc184b57..46bf8b32d57a 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -2120,6 +2120,14 @@ static int zoran_mmap(struct file *file, struct vm_area_struct *vma)
 	return res;
 }
 
+static int zoran_g_parm(struct file *file, void *priv, struct v4l2_streamparm *parm)
+{
+	if (parm->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * Output is disabled temporarily
  * Zoran is picky about jpeg data it accepts. At least it seems to unsupport COM and APPn.
@@ -2127,6 +2135,7 @@ static int zoran_mmap(struct file *file, struct vm_area_struct *vma)
  */
 static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
 	.vidioc_querycap		    = zoran_querycap,
+	.vidioc_g_parm			    = zoran_g_parm,
 	.vidioc_s_selection		    = zoran_s_selection,
 	.vidioc_g_selection		    = zoran_g_selection,
 	.vidioc_enum_input		    = zoran_enum_input,
-- 
2.26.2

