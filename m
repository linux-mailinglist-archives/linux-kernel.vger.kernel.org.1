Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33F2790BC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 20:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgIYSfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 14:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgIYSfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 14:35:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40D8C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:35:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so3998852pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1AqNA6Ddv0jhYAlzZ0w4re+NLjmh8IGHc11oAfYNMWM=;
        b=Nd2nlHnpPaoMda3Y5gXvpvu8UpRoRw/Xs9yncAf3Bjz1NAzElBiMD5WdSO0LZi4wvd
         nBQ/o/Hic1I9B5WOf6t2aN7KM3WLeoxJtTyQbJ6ZtO2+4MBexWDD/NGsnSW+Tv5rYxDJ
         1k0Z7uzvK8HPaAhELeI7WQnh5u1ueL/DFYQIdqK6s+HM936wh676M0UYa/YpIv4W57xU
         iXENAraKyy4zp3xZpu6fswwUynAMQ3fIn1CUf9SDkvVX14LYuP5+MbWH+6o5XjexwMGB
         YTgh4Kuc+9tT0JRti/Vb7tYLx/k1VeknNCSyrF4R54Vm2GdJKkN6dHTx5qw5nYS4OSAT
         sxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1AqNA6Ddv0jhYAlzZ0w4re+NLjmh8IGHc11oAfYNMWM=;
        b=OIMhDA6SNTQB7WHUCjvVgHNqG+sSGKeITekNHpv5MSNxZZzipKxmDnRnqDG9J35nJ3
         Q4TNmFzrUJYV2bN+dDJJtGti/BK0ZyAmVmJrb+vRjoERpyxBpOstc+JKbBnTJ92WGvFw
         +sPEJyR99pARAi7VVttrch1jj4AO9vkN01CBhkllUqRW4KMn+fqYTw+dZOY+snfk1217
         FAnR65tKx/rRXozEztzI+p88RQgLQfKKmcre+y61wJHCVbs4yYkVO85bhst+/Qooovfe
         yw6ln6xCPHJUMqvkd1nQoow0VBIaruVJrD4ee2OTpsukkp3DUop1jCaxQ4tENd55dsXE
         tkFQ==
X-Gm-Message-State: AOAM530c2cBcheW37Yboa0an7g0UK+ombVwoXqNsc+aupkwyFlc/cZCa
        BHZMToYE3XBQ4oO1Y9ckRR71IA==
X-Google-Smtp-Source: ABdhPJxebZnpULsBj+4SHyWr9pLV/nPjkPS83LZyTFDlJodhTbdBjsGLwz+lff17+TOhBl109/wi3Q==
X-Received: by 2002:a17:902:9041:b029:d0:cc02:8540 with SMTP id w1-20020a1709029041b02900d0cc028540mr644587plz.41.1601058919382;
        Fri, 25 Sep 2020 11:35:19 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r16sm2554546pjo.19.2020.09.25.11.35.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 11:35:18 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC v2 41/47] staging: media: zoran: add vidioc_g_parm
Date:   Fri, 25 Sep 2020 18:30:51 +0000
Message-Id: <1601058657-14042-42-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
References: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding vidioc_g_parm made v4l compliance happy.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index bcbe2c78ea16..5dacbeac790b 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -2137,6 +2137,14 @@ static int zoran_mmap(struct file *file, struct vm_area_struct *vma)
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
@@ -2144,6 +2152,7 @@ static int zoran_mmap(struct file *file, struct vm_area_struct *vma)
  */
 static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
 	.vidioc_querycap		    = zoran_querycap,
+	.vidioc_g_parm			    = zoran_g_parm,
 	.vidioc_s_selection		    = zoran_s_selection,
 	.vidioc_g_selection		    = zoran_g_selection,
 	.vidioc_enum_input		    = zoran_enum_input,
-- 
2.26.2

