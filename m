Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A48920EFC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 09:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgF3Ho1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 03:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbgF3HoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:44:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D943BC03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:44:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q90so8334673pjh.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xo4kx1NAZFSrQlqrR4fKrSHkld4dOPpLGIHAf+LkV2I=;
        b=RV+DgcBqr6NVg6INhpMugvXHSNa/F0TzYbxypTH+e/Wc6xDl/PwgNhNdLoR0O/qZS7
         BgK6r63y8zZUT5G74TK0Hhk6uRyY2ADRGEJaScbGc/86mescYkB/c3eko8t7ijVDEiJT
         yn948PWA9bJZVWaBQtQ6ouY9W6qg+BR4CryAx19ck0fHqQ6mby9XijoYnTjbOMCAOkTR
         ZuEa8eO5YMaG9hlJNnLFC3tgbHzjFwoI0iU5GWfU5dhE/x5UdZENNNdfXavL2EnZOcqK
         AXiEq18Nx0pBfW2gHEgKzAiK48tq7NBoCNYwCC/Kl2AkWROpksejdG2LOoXGGUq4CpqX
         0bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xo4kx1NAZFSrQlqrR4fKrSHkld4dOPpLGIHAf+LkV2I=;
        b=Xf3Ms13gaJfN/xGSaN8pJGfpf6nqua74S5IHeSrVLUgcZQRuUG7e4du/qNszdeiWEt
         9bSVZcItAHlTvWGxmdyXgGoq9kjaCDKAMroIhZ+aBV0JfZp62k4W4szC6V1oO9dVL3hL
         rgpcVjkU5TkmUwECQytoIETwurIcf+yPnafxf0H003vCfH1utXG3GCf00u+2lI1n/F6+
         3G7ayOgvqOCH7jXpUHDvTewBhgXvqqF6d8L6cSryE7prx4oF8nmB1r7pJbLcKCFZA2y0
         pbobkQXOkCnrsOgi0kpjfectMjl7+KETjRoCPPIwqmYmWWugiQNWxjeStPWCwii1wEO/
         872g==
X-Gm-Message-State: AOAM533r7GxDEbTRrEwfxO4iZDSDVLRderXnZFUVIezkYJuOCTlcH0e+
        ftQVq4kH0af8lq+WkBHQL9o=
X-Google-Smtp-Source: ABdhPJw7HZSUnx6MKXT5rvXvK+lEevsPWg351OVhFaa39QaOaPj5dW1s/EldxvCQwMpAAGrAF2sD/w==
X-Received: by 2002:a17:90b:1004:: with SMTP id gm4mr21509603pjb.92.1593503065427;
        Tue, 30 Jun 2020 00:44:25 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.182.225.143])
        by smtp.gmail.com with ESMTPSA id w1sm1754276pfq.53.2020.06.30.00.44.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 00:44:24 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jane.pnx9@gmail.com, ldufour@linux.ibm.com,
        gregkh@linuxfoundation.org, harshjain32@gmail.com, pakki001@umn.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2 2/4] staging: kpc2000: kpc_dma: Convert set_page_dirty() -->  set_page_dirty_lock()
Date:   Tue, 30 Jun 2020 13:22:17 +0530
Message-Id: <1593503539-18649-3-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1593503539-18649-1-git-send-email-jrdr.linux@gmail.com>
References: <1593503539-18649-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, convert set_page_dirty() to set_page_dirty_lock()

Second, there is an interval in there after set_page_dirty() and
before put_page(), in which the device could be running and setting
pages dirty. Moving set_page_dirty_lock() after dma_unmap_sg().

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Bharath Vedartham <linux.bhar@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index becdb41..08d90a6 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -215,13 +215,13 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
 	BUG_ON(!acd->ldev);
 	BUG_ON(!acd->ldev->pldev);
 
+	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
+
 	for (i = 0 ; i < acd->page_count ; i++) {
 		if (!PageReserved(acd->user_pages[i]))
-			set_page_dirty(acd->user_pages[i]);
+			set_page_dirty_lock(acd->user_pages[i]);
 	}
 
-	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
-
 	for (i = 0 ; i < acd->page_count ; i++)
 		put_page(acd->user_pages[i]);
 
-- 
1.9.1

