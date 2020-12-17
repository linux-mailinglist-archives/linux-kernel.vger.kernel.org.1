Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3D2DDC25
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 00:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbgLQXqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 18:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732192AbgLQXqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 18:46:33 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B72C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 15:45:52 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id g3so423055plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 15:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3RRTT7yNXDH2vqGzUOSfFsa20THnjHR3wCjzZigjJg=;
        b=k3RC/895s3C+nXmkdzWMvvxjauP7XUKEgdQ9Ae0BcDG4xPBC8hvzZoYurw2xIWhHP3
         ZfJ/QjphW+RtwQRxUK5YELqIBgAW6Up/T04VX+sZrpiEaZBHSQotn9UIdPaOSccGcmZI
         LB+IiC8tpZ6ij1UgYn3pG6Tf+R9P2KtxxtBMKUhu+5BEzXbc7kDeou5Hp5i/VTrj7AeU
         vREbM5ZOEc6hibgnN8sGA6PLE5/dw+RTLSHXLrTRHtelpDblCKUTgsN7YbTWJpLin1Um
         0AqLvyXdpGUSqw0jiBcXG86WNd4MahW0hBZYa5hzq7Adg9GDp3Y4Ldufi7ukB5XrTFwU
         r6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3RRTT7yNXDH2vqGzUOSfFsa20THnjHR3wCjzZigjJg=;
        b=cbGX7+Sd5Ze+luwRy9ZQ/lf4GoyLKJhvd4w523Kv8/Kh8xbOJLl4dioG+5Wt+QYR6K
         Y+QJ8sXBKoSXeQTAZ7zVtirsze+EqoZdBU67ZRQIds6o7vjo0kY8peq+uE1gXVewmHa3
         eFWOz+fGEEfW+SkZ2+1FGAovAN4GYrMjX0Yb/kQfHDhckKlR90eXLpaR+z0TJT2espqp
         c1UfjoFWR5uPnSB1V7xnVfPj27W+tXHINc3Pp5AR1Uyi+kmazximMrgxh2Kc1krT6hhi
         MbRCo4QeLrt+PzwcRRSDRL9OKgNGrV++SHsB71ezE/Fq4TTuSVFU5zLLry77M3jmxSSn
         DA7g==
X-Gm-Message-State: AOAM532LZ2zlh6/Ja/yw+UHeNff9hMi2MdfgKf8xElxprb21fRQhva6j
        kISyo+yHPc5cY1I/6iiJn7E=
X-Google-Smtp-Source: ABdhPJwZTMSyP5GW6egO5piE86RNO6/POneclQsd7v2mo1RWSf20PgSfV0+k3U4vYgYMnnPl6urrzg==
X-Received: by 2002:a17:902:988c:b029:da:60e0:10ec with SMTP id s12-20020a170902988cb02900da60e010ecmr1272639plp.83.1608248751989;
        Thu, 17 Dec 2020 15:45:51 -0800 (PST)
Received: from localhost.localdomain (c-24-16-167-223.hsd1.wa.comcast.net. [24.16.167.223])
        by smtp.gmail.com with ESMTPSA id z5sm6935088pgv.53.2020.12.17.15.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:45:51 -0800 (PST)
From:   Daniel West <daniel.west.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hverkuil-cisco@xs4all.nl, mchehab+huawei@kernel.org,
        christian.gromm@microchip.com, masahiroy@kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        daniel.west.dev@gmail.com
Subject: [PATCH] staging: most: video: fixed a parentheses coding style issue.
Date:   Thu, 17 Dec 2020 15:45:01 -0800
Message-Id: <20201217234501.351725-1-daniel.west.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Daniel West <daniel.west.dev@gmail.com>
---
 drivers/staging/most/video/video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 829df899b993..c58192ab0c2a 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -365,8 +365,8 @@ static const struct video_device comp_videodev_template = {
 
 /**************************************************************************/
 
-static struct most_video_dev *get_comp_dev(
-	struct most_interface *iface, int channel_idx)
+static struct most_video_dev *get_comp_dev
+	(struct most_interface *iface, int channel_idx)
 {
 	struct most_video_dev *mdev;
 	unsigned long flags;
-- 
2.25.1

