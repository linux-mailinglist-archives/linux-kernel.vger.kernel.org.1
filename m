Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846FA1D15CF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 15:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbgEMNjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 09:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388310AbgEMNi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:38:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D551BC05BD09
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:38:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l17so7381448wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e1sTXqRGguAy+llg7dGLJYj6/VWdX40SKxOhmoNPZP0=;
        b=TL34dow3AFECXbJ22HTyK9KKsX1QdBLwrxktF/YGJpH66oiAUsx7m2rSbf4mCCs9hF
         EKiFq6v7JUV8pbTRNRzyQnks+IUVQHjODPEWyzMhtxz9+TuVguf5lZmFyjKiwEHZOiSm
         tfII4L7jNTinj5cOB6qyKXFZwCAUv86HZgmazcxq5qiBwQTOy8O4AA7A5rZ53w/H3fuT
         QxFD4l2FAMJHWSUU5Z3C/ujQjAux3oO8X/oM02mUh7nUSTEjdm8xq9bCMZ8g1iXs9cjd
         2mQPyA6X7tC7DWS7nDgyEh6Rw/gwO8+aHyjeKa/mWri0IRS2H5XbWhghK874x1RGkCcI
         1Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e1sTXqRGguAy+llg7dGLJYj6/VWdX40SKxOhmoNPZP0=;
        b=mz1KcA4n4Oq48b/cE4MSRhngeiKeeh3dquO/UTC+hWR+TY0e03rLDP74aZOnBSEmk6
         q1ItFd7KZV2m5Iz3fNnln//JAUr3i0usjUtmuLm7wC/akB+3kQrc2o+M9k9iLGHLuqin
         y2bWC1njXGV0tIG54cHY/fJc0FEiURKTJIkvK/02KSDzYLsAAb3bZji0PgKCwBMgTUr7
         jtI10W1IY1AtxMk4pt5xkLenx50DRygZUnRru/u5/MMBQi2RBy8mIy3qhpGk9IXglM9A
         vtNfqID5VxBg5BcyNFP7McEsHLE/LDJ4EYKa/irdpdJvM0FfyDCz/YJN5QDrPcF6o4sr
         CT4g==
X-Gm-Message-State: AGi0PuaZYORZbeCxVAR2/QV4dMl/ljOJFjM+oIgPRqRFy/wnauSPLYVj
        edp9QIo7m/MeQrPOE9FQS/ixFg==
X-Google-Smtp-Source: APiQypJ07uWSubrJZfMnOBzOk7xCePBiIOR3e99yUMkYg7UnoXJyFS7B/1RkG5bqQAmhF6CRbEeeKA==
X-Received: by 2002:adf:e951:: with SMTP id m17mr25514589wrn.352.1589377134532;
        Wed, 13 May 2020 06:38:54 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:38:53 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v5 04/11] loop: Switch to set_capacity_revalidate_and_notify()
Date:   Wed, 13 May 2020 15:38:38 +0200
Message-Id: <20200513133845.244903-5-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513133845.244903-1-maco@android.com>
References: <20200513133845.244903-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was recently added to block/genhd.c, and takes care of both
updating the capacity and notifying userspace of the new size.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e69ff3c19eff..d9a756f8abd5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -240,10 +240,9 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 {
 	struct block_device *bdev = lo->lo_device;
 
-	set_capacity(lo->lo_disk, size);
 	bd_set_size(bdev, size << SECTOR_SHIFT);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+
+	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);
 }
 
 static void
-- 
2.26.2.645.ge9eca65c58-goog

