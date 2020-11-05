Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A5D2A8673
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbgKESu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732004AbgKESuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:50:22 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F06CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:50:22 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id ie6so526861pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3EzvkzpYwrLmNMPvXPc/QI49X9jTb6rRy2470fIh6L0=;
        b=px4MXYdb+PxYPOu6R6lJ55qGhTb3W2vrn4OX0bC8UaPmEk2m0swVzbEI92X33uCDs3
         ikSsVUu2WHexB7FLTekQEtRSHEsGAW8gPpc0aCEftKCFzY3Pjzm6kSvssYzbZHt6UBEr
         2dPRehIpM0hFZNkSeixXIPNKoeIlSoEzWYINzCtBpyXD9VO1vPKN2oQWjDT659Zd+4g6
         614LGEka6FIfuFTScqA3rdzoqEPgR7xP5KOakZ7XcFMFD9wjImsMeeaZLlIWv9vhpyNP
         o2Bnp7BkX0G9T5XQ2ogM/FosRww15fPHSz5+261LaAxEt1M+tLBDxDqXGc39f896t3UB
         ukRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3EzvkzpYwrLmNMPvXPc/QI49X9jTb6rRy2470fIh6L0=;
        b=Ndn0IdRunbxMOub2/yny/vWKljWvlJ+i6UNh2Q3Ed8hOAp3nCVQp5DDwXO2Ubj4Ffw
         az40489e8HlOnfPbhZJXsyBVr6dY6IOvHeJDOtyQ1w7u+Y+lt8krnQGLBy8PNiHU4BuF
         DyuVy7oH/I6C2r9d4Z91GAqNN1tl4ES9MSkiP4H9MBHv4WTgxpNro8B/ZM1xiWNyMCJS
         /UVAG8yCSmuLY4p215434elcUzqy+O02uxmv222ilBq3q7vr+rw4OObLd1yuW69gzXW1
         z2FakxO1X8S6KATpbyYES3ofbMKtUvu8234j8CAEX+VA9lkzgaToq1l1KhvME+8CZfXn
         jSzQ==
X-Gm-Message-State: AOAM530YkcPwMzCI9wDjdi8uux4cZq1WOpqqpfAHKMzZ9CUUIfp+oo02
        vLR45p6W+1tDk3YnBFF30Sk=
X-Google-Smtp-Source: ABdhPJwwvyRuSz/E7DAjDgbpBdsUcgYjDXTOIfRrRB8ZJ6lAWfdKVRsyPz4fAUeDGF1TPKzwfMIuJQ==
X-Received: by 2002:a17:90a:d584:: with SMTP id v4mr3909143pju.194.1604602222134;
        Thu, 05 Nov 2020 10:50:22 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id e24sm1862787pfl.149.2020.11.05.10.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:50:21 -0800 (PST)
Date:   Fri, 6 Nov 2020 00:20:16 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com
Subject: [PATCH] drm/qxl: replace idr_init() by idr_init_base()
Message-ID: <20201105185016.GA71797@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_init() uses base 0 which is an invalid identifier for this driver.
The idr_alloc for this driver uses 1 as start value for ID range. The
new function idr_init_base allows IDR to set the ID lookup from base 1.
This avoids all lookups that otherwise starts from 0 since 0 is always
unused / available.

References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_kms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index dc5b3850a4d4..228e2b9198f1 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -231,11 +231,11 @@ int qxl_device_init(struct qxl_device *qdev,
 		goto cursor_ring_free;
 	}
 
-	idr_init(&qdev->release_idr);
+	idr_init_base(&qdev->release_idr, 1);
 	spin_lock_init(&qdev->release_idr_lock);
 	spin_lock_init(&qdev->release_lock);
 
-	idr_init(&qdev->surf_id_idr);
+	idr_init_base(&qdev->surf_id_idr, 1);
 	spin_lock_init(&qdev->surf_id_idr_lock);
 
 	mutex_init(&qdev->async_io_mutex);
-- 
2.25.1

