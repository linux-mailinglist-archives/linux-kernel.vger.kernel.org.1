Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284EC267DC2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 06:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgIMEmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 00:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgIMEme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 00:42:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E029BC061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 21:42:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s65so7966158pgb.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 21:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RFk2Uj83nGtWjMkKgmzPhiJ3//uQgBPJxEzuhEnY0oU=;
        b=WTnriavgFadVJr+fJxu0Ej3C3ev0mM0qCcbZUpwtFhSNZAIE19roBsb1RufOgC9+KF
         uG3kPk7agMVtebBn2uPAA12XF3qGnCQWMPwkiuYaNeOKsToOT9KDdk6S306uZ9twNMBQ
         e22PBPE3jYDynDIKgRpOPzhpz2iyBwu9RsardgQT69gugICxDODb6Fl78Ow4xFQx2WKr
         w5iYTB95BvCS+MkIBt+Gl8fqlKNUMTW8pzpIaqvmm1PJUobhtbO9njebbJeQuLQmQgQP
         6pvDJLjv2Q+Jw6p6DbogbovTosnCHq04ePCsYAEoEUpoMGDwGYPNzscQnrMlOn3xVJTO
         E63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RFk2Uj83nGtWjMkKgmzPhiJ3//uQgBPJxEzuhEnY0oU=;
        b=FokAqwPfbza6hdtzBOxPly/dSn5CLPYCWuFtBaWwNGPWpmmPo6xNvaLm1gUz0eMOY8
         4/cbcHEfJIAAAZZWVF8U9bGLTQaek+fOn2xPGbhz/nVynNOmql4RGJ4Z/iXl3rGa689e
         wvz0SucpuGGheEjPBoXh47iQS/kABiQiNFYQRHcHaY7hRw6lbtFqZaEYJIvDqaz9HapV
         vp1AmugyQBBSmy5KsnCdkjl2bfLPMH1iJeV0Dw3unnEGjRB1nNHDPd7v/rj6zMz+5Bvf
         pwm0ISfkSOXAIkSFaTWwYSvO7lCm+gqpsVAvT/0cVDCOcrOFDraJVBxsCLtXznTaGHOz
         pJlw==
X-Gm-Message-State: AOAM532Kq5Vxp7q7rxab39Em+H7nPIhlk+7mCxRMT2r0sDMOvGQzMMfM
        IQJEnsQbya1UragTZBbWTnk5L3RfzWA+AA==
X-Google-Smtp-Source: ABdhPJzNw3v4jcqavUQDVRYlPteukZ8on+y+cRA71o7ljkshWg6BrepLpfOHDH0Fbg8RZ3TYhiDSOQ==
X-Received: by 2002:a63:b47:: with SMTP id a7mr6865626pgl.57.1599972152147;
        Sat, 12 Sep 2020 21:42:32 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.45.202])
        by smtp.gmail.com with ESMTPSA id y4sm6417177pfq.215.2020.09.12.21.42.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2020 21:42:31 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jens.wiklander@linaro.org
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] tee/tee_shm.c: Fix error handling path
Date:   Sun, 13 Sep 2020 10:12:11 +0530
Message-Id: <1599972131-31770-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When shm->num_pages <= 0, we should avoid calling
release_registered_pages() in error handling path.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 drivers/tee/tee_shm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 00472f5..e517d9f 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -260,8 +260,7 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 		rc = get_kernel_pages(kiov, num_pages, 0, shm->pages);
 		kfree(kiov);
 	}
-	if (rc > 0)
-		shm->num_pages = rc;
+	shm->num_pages = rc;
 	if (rc != num_pages) {
 		if (rc >= 0)
 			rc = -ENOMEM;
@@ -309,7 +308,9 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 			idr_remove(&teedev->idr, shm->id);
 			mutex_unlock(&teedev->mutex);
 		}
-		release_registered_pages(shm);
+		if (shm->pages && (shm->num_pages > 0))
+			release_registered_pages(shm);
+
 	}
 	kfree(shm);
 	teedev_ctx_put(ctx);
-- 
1.9.1

