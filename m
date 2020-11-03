Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C392A3A07
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 02:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgKCBsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 20:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgKCBsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 20:48:18 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0369C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 17:48:18 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z3so6434956pfz.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 17:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5EIMo7DxVzETY+pG6N2VOmD4ZlvliKSM4a22Hu2QQ48=;
        b=fXj6yVnrjATl4yzOmF8SeuWcDHokvLyDOA9gNus+5EJPaBM8nh9k6ICwimPjI3qgXf
         cKCVLcRL7aDjj6AV6zbqKGfxOUX33Uo7b9zGDhwuUwqmAppIqJG4HWKkB2At85rDQwHQ
         5hp77OXQlG2fOT5aVL+jVh865J8qiS5qIntdhjf+M9XNZWa4xwHIjtgBfLCfv6g+OHd0
         kN0EGusmYo7atm7zJLSRyW/kmVv4lk1d8ng3Cml92uRjipBzrEVhys30xFjScWrOcJod
         Ry2446Mdrpb+hb0eslvlWIwMrimH+vcfzyel7kE9XVrM7tT2qPFvu14Kj4a+l9I9a7U6
         SUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5EIMo7DxVzETY+pG6N2VOmD4ZlvliKSM4a22Hu2QQ48=;
        b=kDLcBW354go5UEK4dMacXfKSqmdzrS+NMGmye/RDMI07eCAsSExYDaA/X/+KiFpKSR
         20PLXrA/x/zePyHOFgtu+5OAA1ghK/kCIqti0nGgImdvIa8kAaGaRg++oNcbJjOZzIQ+
         3MvnuPJRKe+3ljnbtDQUsq2qhQwGns+lnV9/7ZzQDJbIJ7+SaYGdDTwSgYf2/9B/zF5J
         ckDu8xIOhxewL+GiHPEBGrktHXE76a2pMnzRvZdf1lIQDp4rGqjk5zghrtvHAdPv3/wG
         SMGV8apR1bLPpUsmcHoa6tXcXURy+KDrDIYVxXQzEmW3KALv657WBHG4bUlWzA8lDQ+i
         ycOw==
X-Gm-Message-State: AOAM532Opc+kBmMF+si+WBnVxvpSoTdIyVN19zN3qYZV1TVlk+BC7HQa
        kQffF3JUUk5bd1/sAPcZCpY=
X-Google-Smtp-Source: ABdhPJymKxSyrKlw1UwO8ZciKzlDDzf+/NC9/Q0LwxMITtm/wiRcdZ591EWsFW/nphuY8npCUMQLkg==
X-Received: by 2002:a62:ce08:0:b029:156:4427:4b29 with SMTP id y8-20020a62ce080000b029015644274b29mr24039920pfg.70.1604368098289;
        Mon, 02 Nov 2020 17:48:18 -0800 (PST)
Received: from localhost.localdomain ([8.210.202.142])
        by smtp.gmail.com with ESMTPSA id 22sm780144pjw.34.2020.11.02.17.48.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 17:48:17 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffwll.ch,
        p.zabel@pengutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        yejune.deng@gmail.com
Subject: [PATCH] drm/panfrost: Replace devm_reset_control_array_get()
Date:   Tue,  3 Nov 2020 09:48:02 +0800
Message-Id: <1604368082-6032-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_reset_control_array_get_optional_exclusive() looks more readable

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index ea8d318..1daf932 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -18,7 +18,7 @@
 
 static int panfrost_reset_init(struct panfrost_device *pfdev)
 {
-	pfdev->rstc = devm_reset_control_array_get(pfdev->dev, false, true);
+	pfdev->rstc = devm_reset_control_array_get_optional_exclusive(pfdev->dev);
 	if (IS_ERR(pfdev->rstc)) {
 		dev_err(pfdev->dev, "get reset failed %ld\n", PTR_ERR(pfdev->rstc));
 		return PTR_ERR(pfdev->rstc);
-- 
1.9.1

