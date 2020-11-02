Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86AB2A2674
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgKBIzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgKBIzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:55:25 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC7FC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 00:55:24 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id k9so8515482pgt.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 00:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R1wYyE+ffvxs4bCnVGwncv5nVBCP9InFyCF3KL3GlEA=;
        b=A5by00u83SRdB6pDDoHALM1n+9KiiJRO9b0qD0R/BD+YQV/uWmWeULDRoUDlOL+Vz/
         Tn08HR5JKMXiDgT3Eq7kExHNGa66VUp+A1lxhvt4KENJREsX+k/ZR7XOmGjEStd4baqA
         6C6Ycx0tJ6Clyvt7Vn1gHoxAptGYDe5qjIV+zGQxhAy9XAkmSdgPWMcF0NAYPYL6CmB/
         QMPb6r6tub67uScPs90AjMLUmqg9uSI3bugvT4McGPK8XZAa8GxUiGvvrkgq0I5Umo4Z
         dl+sa1bldXPzqCFNE2E62lvb0W41/EXl56nbMHHz4Yi2KZFVu3FmYXlckDae+9X+mM9M
         /oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R1wYyE+ffvxs4bCnVGwncv5nVBCP9InFyCF3KL3GlEA=;
        b=U38pdsvih1mM/1f1kndXcp0V80SMQdgO20LqAARl986VFW0LZR7fA0PFNqz1i5ZQNF
         NltmiMS0pZuWxZNhX6maXAhDrJXBv4Lh5qe9fobCdREW/FcnhYinQUeaUIHa+rNokP8T
         ePEddoRfqEguv4FxR/hPKAkebc7PXm0WMHf4v+MWtPa5JOkrsi376Tw/jQ3rTx7THlTX
         +2Nbe8x+zgd7Os+mewknhoWYfHpsFkgHDlr5g0onsyGpmF4FxD5ZoyGUg2cBj8g9HCkd
         UWj8RqHNaVK54a1Haj0DTvUx8kEzw4eVSbOxs+u73iQaVNm1R6fta/039UZ54O3wf69D
         8RpQ==
X-Gm-Message-State: AOAM5302gRTq5OmCgOmYmQqvcHBqSydD8J0nM9glO/+JOUyoTOvr/MiX
        mlMtM8d29GbjF7d5r51QC6U=
X-Google-Smtp-Source: ABdhPJwtdELFm9o893MMOfd4FwigdXvNnD3CKVXhgTuQZt6CHZVDtGgDf+djQjYNspocYbQhJLD+rw==
X-Received: by 2002:a17:90a:8007:: with SMTP id b7mr16598843pjn.84.1604307324619;
        Mon, 02 Nov 2020 00:55:24 -0800 (PST)
Received: from localhost.localdomain ([8.210.202.142])
        by smtp.gmail.com with ESMTPSA id mg6sm11625762pjb.40.2020.11.02.00.55.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 00:55:24 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffwll.ch,
        p.zabel@pengutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        yejune.deng@gmail.com
Subject: [PATCH] drm/panfrost: Add support for non-existent reset node
Date:   Mon,  2 Nov 2020 16:54:49 +0800
Message-Id: <1604307289-32110-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some dts hasn't no reset node, is should ok.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index ea8d318..a982878 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -18,7 +18,12 @@
 
 static int panfrost_reset_init(struct panfrost_device *pfdev)
 {
-	pfdev->rstc = devm_reset_control_array_get(pfdev->dev, false, true);
+	pfdev->rstc = devm_reset_control_array_get_optional_exclusive(pfdev->dev);
+	if (!pfdev->rstc) {
+		dev_info(pfdev->dev, "reset does not exist\n");
+		return 0;
+	}
+
 	if (IS_ERR(pfdev->rstc)) {
 		dev_err(pfdev->dev, "get reset failed %ld\n", PTR_ERR(pfdev->rstc));
 		return PTR_ERR(pfdev->rstc);
@@ -29,7 +34,8 @@ static int panfrost_reset_init(struct panfrost_device *pfdev)
 
 static void panfrost_reset_fini(struct panfrost_device *pfdev)
 {
-	reset_control_assert(pfdev->rstc);
+	if (pfdev->rstc)
+		reset_control_assert(pfdev->rstc);
 }
 
 static int panfrost_clk_init(struct panfrost_device *pfdev)
-- 
1.9.1

