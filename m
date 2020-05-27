Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55A91E4FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 23:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgE0VGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 17:06:38 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:32796 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0VGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:06:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49XNg00ccyz9vJcH
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 21:06:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ha-t7_aN0Jy0 for <linux-kernel@vger.kernel.org>;
        Wed, 27 May 2020 16:06:35 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49XNfz622lz9vJbS
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 16:06:35 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49XNfz622lz9vJbS
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49XNfz622lz9vJbS
Received: by mail-il1-f197.google.com with SMTP id q2so21558686ild.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZSlV3tEQ6XuheL2Xc2G2BwyWDLdcBMbchtoHVKeo45U=;
        b=pdobmyvOcgMFfTVziKKFwlbsc4W+5+f2QHsIHMFMtSGeGb971/hub2yEdPrdbZdMNu
         VZmEh8HK5u4DaJOCS0yFe/gUwxpCXVW/W4tyC6o+l88wEeFuBCX12c0E9OupOiZsVYnS
         w1ZsxES85zs5hSh8e8r7u2bt7JAmb/WNBJ5IXRxXR3QxKB3/O7r3HpqGomOPLC8i/R+D
         jJCTq1JObP7L+m6xkagcXbPm3wgW1F2P8OwkmEvq1MPPzy/AiDPrHGt17AmreDUZh2td
         Y1tb0yfvJvIUHtGh+R+qJgtkUEuRJOly4G2BdjTpZIAq9+hJ5OU4Yb5UdrAF77c6cTCt
         ugng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZSlV3tEQ6XuheL2Xc2G2BwyWDLdcBMbchtoHVKeo45U=;
        b=fbi3z2cp+DQR7KvQtLSrRLFHJ73XDeULa/+vxE7FZqTbkKN9Wikie5jD52H+YeZmX/
         EVMi7zhdGFdBkFjKr02eMcBhcvV5ZPfvX8jVGyRWUiVzP6hCSjWXtJfW3H4rUTkm+MlR
         x1vk0+EEn3cKuepGcRShFxKLR2YvdOzGucbomJ1pYtVpxVYddpg4DBdq2U1ZCS+jPHSj
         5z6DDGBLqkWB8/kj/b2DvfTnTZUKNp6qnEeupJ/34CA4Yi53MkdHkqha0ZliS4oqJrF8
         6h5h4iqjGpIG+Dus2vk3jsTvg2szpKo0xP44dzqMB5RcG66fA5RLANXI8fscEKWS26sG
         bQWQ==
X-Gm-Message-State: AOAM5338OUQqfP1kYnTJF/GVenFdiU/tdaAvVIAuZROF+I5/7EzlMoeq
        1F/UsQNTUv+8Y4pI7ve1ipjQ+sreWc5Yfg5qXirE8Nz+P8GZEQMTaHzsmsJDD1tqcaCmexJyoec
        YBOGSwwb/3j93TuZDek92/JaDJ4tt
X-Received: by 2002:a92:ba46:: with SMTP id o67mr220228ili.66.1590613595354;
        Wed, 27 May 2020 14:06:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0pmOT1Qb57G2i2D/b2H4L/d1ug6uNxyKQtfBL8egEssL9tZNr4G4bJNl2U6YgQ/CmMa7j9A==
X-Received: by 2002:a92:ba46:: with SMTP id o67mr220214ili.66.1590613595091;
        Wed, 27 May 2020 14:06:35 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id h5sm2063832ile.35.2020.05.27.14.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 14:06:34 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias@cnexlabs.com>,
        Jens Axboe <axboe@fb.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lightnvm: pblk: Fix reference count leak in pblk_sysfs_init.
Date:   Wed, 27 May 2020 16:06:28 -0500
Message-Id: <20200527210628.9477-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
Thus, when kobject_init_and_add() returns an error,
kobject_put() must be called to properly clean up the kobject.

Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/lightnvm/pblk-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 6387302b03f2..90f1433b19a2 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -711,6 +711,7 @@ int pblk_sysfs_init(struct gendisk *tdisk)
 					"%s", "pblk");
 	if (ret) {
 		pblk_err(pblk, "could not register\n");
+		kobject_put(&pblk->kobj);
 		return ret;
 	}
 
-- 
2.17.1

