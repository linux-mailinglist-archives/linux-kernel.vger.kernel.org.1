Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17B11C3A8D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 14:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgEDM5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 08:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728486AbgEDM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:57:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF50C061A0E;
        Mon,  4 May 2020 05:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mBogiaGNd7hpK9ySfHk4hpJAoc3m1AY7I5tkiLAKSeA=; b=dV311TUEjeB2ewB34emO5tYUQa
        4o7n7A1WMZW/i4f+r/lAe46nIYKYjfpm3/VKyw6HkX49Fj5uxwIJuOFVtSionfTgY1TohaPg3qIag
        QhdGWukRAdRDbdF03syoXcyN+zT5m/2AWPJ1hw4PhnVgHCBaRbhfoBNXHZw6d7o/4+mjwFO8ontr1
        QfFfKXseE1ljqpVi3UEOrAvlhqaEhjASSrCuO4ZVPsl/6VIq73cAGwYunC4OuBgVYt9UGUMZFNqwa
        zV6GTZGT60jgw6FChHNUnhPPo/co0FpZTh8J2jrdt8SQQypmOnF5egYZtf4cakbnu8+VirRdZx4yd
        6FbGSSdw==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVaeY-0007Ys-LZ; Mon, 04 May 2020 12:56:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] driver core: remove device_create_vargs
Date:   Mon,  4 May 2020 14:47:57 +0200
Message-Id: <20200504124801.2832087-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504124801.2832087-1-hch@lst.de>
References: <20200504124801.2832087-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All external users of device_create_vargs are gone, so remove it and
open code it in the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/base/core.c    | 37 ++-----------------------------------
 include/linux/device.h |  4 ----
 2 files changed, 2 insertions(+), 39 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 139cdf7e73271..fb8ae248e5aa8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3188,40 +3188,6 @@ device_create_groups_vargs(struct class *class, struct device *parent,
 	return ERR_PTR(retval);
 }
 
-/**
- * device_create_vargs - creates a device and registers it with sysfs
- * @class: pointer to the struct class that this device should be registered to
- * @parent: pointer to the parent struct device of this new device, if any
- * @devt: the dev_t for the char device to be added
- * @drvdata: the data to be added to the device for callbacks
- * @fmt: string for the device's name
- * @args: va_list for the device's name
- *
- * This function can be used by char device classes.  A struct device
- * will be created in sysfs, registered to the specified class.
- *
- * A "dev" file will be created, showing the dev_t for the device, if
- * the dev_t is not 0,0.
- * If a pointer to a parent struct device is passed in, the newly created
- * struct device will be a child of that device in sysfs.
- * The pointer to the struct device will be returned from the call.
- * Any further sysfs files that might be required can be created using this
- * pointer.
- *
- * Returns &struct device pointer on success, or ERR_PTR() on error.
- *
- * Note: the struct class passed to this function must have previously
- * been created with a call to class_create().
- */
-struct device *device_create_vargs(struct class *class, struct device *parent,
-				   dev_t devt, void *drvdata, const char *fmt,
-				   va_list args)
-{
-	return device_create_groups_vargs(class, parent, devt, drvdata, NULL,
-					  fmt, args);
-}
-EXPORT_SYMBOL_GPL(device_create_vargs);
-
 /**
  * device_create - creates a device and registers it with sysfs
  * @class: pointer to the struct class that this device should be registered to
@@ -3253,7 +3219,8 @@ struct device *device_create(struct class *class, struct device *parent,
 	struct device *dev;
 
 	va_start(vargs, fmt);
-	dev = device_create_vargs(class, parent, devt, drvdata, fmt, vargs);
+	dev = device_create_groups_vargs(class, parent, devt, drvdata, NULL,
+					  fmt, vargs);
 	va_end(vargs);
 	return dev;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index ac8e37cd716a3..15460a5ac024a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -884,10 +884,6 @@ extern bool device_is_bound(struct device *dev);
 /*
  * Easy functions for dynamically creating devices on the fly
  */
-extern __printf(5, 0)
-struct device *device_create_vargs(struct class *cls, struct device *parent,
-				   dev_t devt, void *drvdata,
-				   const char *fmt, va_list vargs);
 extern __printf(5, 6)
 struct device *device_create(struct class *cls, struct device *parent,
 			     dev_t devt, void *drvdata,
-- 
2.26.2

