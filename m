Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702BA2A6337
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgKDLZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgKDLXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:23:44 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E97CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 03:23:44 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id z3so1612292pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 03:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iqkBaJQMLLSn3M5HmvPZvenF0ZnDsvHIodeI0SDkoT8=;
        b=i4duuCrk/C/kCdN+uiu8Xnb+j6jKczFmUUIPRXjAfuVWaZB2Gml9H9Ha69fjVptjYw
         DMK9FNY7Bkrth+tuQRbQeLvalByoN6jGboe2A4zJ+q5veX3xpobZMbgXN47gapnbD16i
         lC44L8z9qMiRs+XpGwu3OTtItGJzwmRgzrXS+QuL3CXaEtUg9R5c3u1lmtPkYIESywlg
         HDTqbJD/ZBGIPRSxZtFrT+R6btkLgUF6eoSKlLSj61xDwy8VEfFCns6eHgxHm9h6A7Yz
         96jZFy1JXOn/iF5NHyuadGS0TmBnMPgimmYFuLE9VF90z55yR2uGUzAkVfGNdBZ+Onpu
         4YMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iqkBaJQMLLSn3M5HmvPZvenF0ZnDsvHIodeI0SDkoT8=;
        b=gPK51S429cKmPQ1hTrCuIn4sRJSnwhxFYGM5QDwkw7jet45dWl6M25iLHkWIVxwINf
         cOO7thMQI+kUPjUaqRH0xjU0cdk3DvVbLD0Q6lIB2cEwlVzy3aos33CuU8+dEvS58G27
         FYbhyivaewPsTMxQUdmyM35Vbqi7yacEQzkrsulFPSl9w5Keoqu6Dd8qiiIJuGLlKiEo
         mjuV7DwgbzzgwQ8yQODJ277RqnngtQ+luZxWeCuSZZKVcSUf90DzFdBO31Gs1Xtz0/bx
         8dmUlL4l6YUk6oVONWXOFtj8tm73y0BMWbvmP0Q7odyKOWSmUTEW21Jcjb5xzCiiMm9z
         RFvg==
X-Gm-Message-State: AOAM533tRSEGcgvoLf5vYJoMVKVdjHKJg4Z+IDd/UYHPD1Q6XyMYZrnj
        le6EI8fco+2UuQ0a59GFaGE=
X-Google-Smtp-Source: ABdhPJyKmZjy9APbGyGtvptrvKgWNDj/kqACD/0WC+F/YjahNzBVhU+zKwToLUf548ioNlkmRcPEHw==
X-Received: by 2002:a17:90a:8c89:: with SMTP id b9mr4097017pjo.34.1604489024128;
        Wed, 04 Nov 2020 03:23:44 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id n64sm2182055pfn.134.2020.11.04.03.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 03:23:43 -0800 (PST)
Date:   Wed, 4 Nov 2020 16:53:38 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com
Subject: [PATCH] drm/vgm: replace idr_init() by idr_init_base()
Message-ID: <20201104112338.GA29271@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_init() uses base 0 which is an invalid identifier. The new function
idr_init_base allows IDR to set the ID lookup from base 1. This avoids
all lookups that otherwise starts from 0 since 0 is always unused.

References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/vgem/vgem_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index 17f32f550dd9..2902dc6e64fa 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -233,7 +233,7 @@ int vgem_fence_signal_ioctl(struct drm_device *dev,
 int vgem_fence_open(struct vgem_file *vfile)
 {
 	mutex_init(&vfile->fence_mutex);
-	idr_init(&vfile->fence_idr);
+	idr_init_base(&vfile->fence_idr, 1);
 
 	return 0;
 }
-- 
2.25.1

