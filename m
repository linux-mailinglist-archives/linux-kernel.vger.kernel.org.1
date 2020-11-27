Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC862C6B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 19:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgK0SZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 13:25:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbgK0SZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606501539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Am+Wm5jC2GOijd2mNeO2v2NLrmRbuKRBi2OUboWUBjM=;
        b=L6ti1MEPUup1qnGSvuP5i77ih6WJKTyUCTrk70U1h/PC/cow/ewQX1VRMPXX4aEWHRvFkd
        x+4MJM5cojab2NBmAqFJ4zHCdqPA3MvKFaAUhgxo6K1MvWbEsrU2Ho3XtxfvJ2e4O0G9vc
        s0HXaG1C2oGfyKfissW8ZSljNyo4JHc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-G6SQlEcBNd6EhCbyae2W7A-1; Fri, 27 Nov 2020 13:25:37 -0500
X-MC-Unique: G6SQlEcBNd6EhCbyae2W7A-1
Received: by mail-qk1-f197.google.com with SMTP id b11so4177609qkk.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:25:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Am+Wm5jC2GOijd2mNeO2v2NLrmRbuKRBi2OUboWUBjM=;
        b=NfD+cfa42nNtijBX80QPM9P3bSKGy77wYpp3r9L/f4H5UXECkgIWdBHyYnGoeIxs61
         3558iSaGUkJXoWC5ABFz033GRPkjsAee2oGSOaEMwiR9MSiQgdgLbNaiI0cr9xcWM2B6
         F7hYWfKquCuMbRVysNviRa8yXT3RnEYoE2tFD2xilra/5wTJXYvPETPAflDVUB1DGbAG
         DK1raT6wVCEQBPoiMs01tQELgT2DJcKEFNXPqUHZmaUQ/e72dtaiEOz7yxluHD8FbDmP
         RZx6M3Rke4GGwsVUY4taw1fj22zsqu6Mi1S4+7aOzCvGV7z63XScOYC7cEPWzp1mc22x
         uYVw==
X-Gm-Message-State: AOAM530Bu2++Jhsf96vMb4/NDax2496qK3XzhDyaUpvctGdnPtWMT2PR
        Gmq2GKjFkUsLc9q2VYgxPaSX3TN8ohyBW2FtmuPCdy/iFFUBG2PP8ABnuJwuYqQSlrZ8flNWZor
        tn7FTPfcaAc1QR2lvXjZK7Q63
X-Received: by 2002:a05:622a:154:: with SMTP id v20mr9556421qtw.185.1606501536907;
        Fri, 27 Nov 2020 10:25:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxE4SP5QlhkUVrLJ0zS6npRf76mLh15D+rJ3MesG6bzjI/RkuSvu6k4i+vIGjASO6sn0vTkaA==
X-Received: by 2002:a05:622a:154:: with SMTP id v20mr9556406qtw.185.1606501536735;
        Fri, 27 Nov 2020 10:25:36 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v15sm6756334qti.92.2020.11.27.10.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 10:25:36 -0800 (PST)
From:   trix@redhat.com
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] scsi: aic7xxx: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 10:25:31 -0800
Message-Id: <20201127182531.2796882-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/scsi/aic7xxx/aic79xx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 98b02e7d38bb..ce8604d730d1 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -319,7 +319,7 @@ ahd_assert_modes(struct ahd_softc *ahd, ahd_mode srcmode,
 }
 
 #define AHD_ASSERT_MODES(ahd, source, dest) \
-	ahd_assert_modes(ahd, source, dest, __FILE__, __LINE__);
+	ahd_assert_modes(ahd, source, dest, __FILE__, __LINE__)
 
 ahd_mode_state
 ahd_save_modes(struct ahd_softc *ahd)
-- 
2.18.4

