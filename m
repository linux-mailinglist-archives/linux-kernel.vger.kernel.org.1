Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B703E290B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392847AbgJPSpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392839AbgJPSpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:45:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D91C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:45:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d23so1752601pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=48b7K5oRv9imiHisjcKC3hMDX6U186AneeFGVc/iAX4=;
        b=vJJ2q/RFEORYf6YbW62DkzE4oQAWr/Cve4IjCFTJ7dUk5MFLfRBwRQCZzeoo36eIO0
         h3JuvQsnN4M9s3KNDeOaljYUpnWqK6Gg8i9facshjAsQ9eLcMAMJ1CJSdugwS/yxdkZx
         X//TqkM1TwprB8CrvLMjDxRWFr3Pd1je/XkmuBnFwYoYNbt3nmfg7Xy6bZdP/U9LyPXp
         3rtASAXZu3w5enn8mnuHuudoiOAqlxCQioguuheZ9exjEUKeNOPH7vKeenZ2x4uo1Xu3
         MSe3Cs35LApofumbmDX69bBwMO6IuRXZ6WS64GznWfi4SelfREab+KoIsp98ld6ZUFlt
         r3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=48b7K5oRv9imiHisjcKC3hMDX6U186AneeFGVc/iAX4=;
        b=PVcFUBWCnMKoF1ahPXFcDt/U6NPx4vLsBny5UmfUx4Q4rfc/LB24/546lBW931nNXD
         zvMtrjCvxXjb9VI6ZHKBe/3uRhMVdXsrwizH+sprS+Na4709olCeMRdPXRpd8uHcZvew
         LrOslXvwxQkLQU81+FhBUkpPZHqUqVTd3SwSwxXr7unoX5SBAelVIWREhCyMcjYhWv4Z
         YDmjJr0k+YlL35Q72vw3eGWU90qVIJP30Jm3o6pp7+dYZpDCKMNUe1wAU/nEwuIHDy9X
         M6+GX3/jSX+5zSi3ZLMmnrx4VyU/gZmJopmbWG4t3d9C/dL23URL8P4jXTsV/97Xf1pT
         HbkQ==
X-Gm-Message-State: AOAM530mhc39V+qB1VeRjqXGq07DHNG6eG8TI06/ZDpB5t/3j72yEpHI
        FtqaBHW2iEUTgw/Y+03Iedrn
X-Google-Smtp-Source: ABdhPJwjDbi4J0YdupflY5TLRB208TlYBPwXHOpsrqjKL7rf2kxiTsMIZkQz8EWeyU2Rm72RVTiq/g==
X-Received: by 2002:a17:902:9f96:b029:d4:c459:a181 with SMTP id g22-20020a1709029f96b02900d4c459a181mr5326040plq.28.1602873943404;
        Fri, 16 Oct 2020 11:45:43 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id g4sm3487088pgh.65.2020.10.16.11.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:45:42 -0700 (PDT)
Date:   Sat, 17 Oct 2020 00:14:59 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, alexandru.ardelean@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com
Subject: [PATCH] iio: light: vcnl4035 add i2c_device_id
Message-ID: <20201016184422.GA15952@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch aims to add i2c_device_id for the
vcnl4035 driver, while going through the initial driver
submission patches, noticed that the i2c_device_id was removed
on suggestion (https://lore.kernel.org/patchwork/patch/970970/),
will it be possible to consider this patch add the i2c_device_id,
so that the device can be instantiated using i2c_new_client_device
or say from the userspace?.This will be really helpful in cases
where the device tree based description is not possible now(Eg. 
a device on a gbphy i2c adapter created by greybus).

The particular usecase here is described over this RFC Patch
for the mikroBUS driver:
https://lore.kernel.org/patchwork/patch/1290148/

Thanks and Regards,

Vaishnav M A

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 drivers/iio/light/vcnl4035.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 765c44adac57..73a28e30dddc 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -652,6 +652,12 @@ static const struct dev_pm_ops vcnl4035_pm_ops = {
 			   vcnl4035_runtime_resume, NULL)
 };
 
+static const struct i2c_device_id vcnl4035_id[] = {
+	{ "vcnl4035", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, vcnl4035_id);
+
 static const struct of_device_id vcnl4035_of_match[] = {
 	{ .compatible = "vishay,vcnl4035", },
 	{ }
@@ -666,6 +672,7 @@ static struct i2c_driver vcnl4035_driver = {
 	},
 	.probe  = vcnl4035_probe,
 	.remove	= vcnl4035_remove,
+	.id_table = vcnl4035_id,
 };
 
 module_i2c_driver(vcnl4035_driver);
-- 
2.25.1

