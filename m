Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEFD29156B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 05:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgJRDgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 23:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgJRDgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 23:36:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE1EC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 20:36:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h6so3913073pgk.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 20:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZXNvqfzawbySuzMVGw4gXlzTl+S+mGxYefHv7OoHq9M=;
        b=j167RdL2gso8Kh+gHBcAilDri7Mz+oh/ZG3HZXWWFAxPV7hbRuvKh22ZpompCkUJOJ
         8L3++4MpVoA4byFhHalreX0DS9lRGfBguKgI+IBiMW/P86tc6NNvK0+11xj9Pmnj0lg0
         lmf18jdKIBNOBXuywBsjV0SKbrZ3HQxPEkZ+uI44uT8uDt03Y44E753f3NHSSlSKSUls
         Evq0Saa3bNzKGPqym1CHOXJ71pckKZxoEscUuduyeS1RBXlLpqD884Q3PfgUAxlu06Xq
         fFonpKS8CIyZ2Su1E1jyTG7c2intanqY/Bx89L86vED7XldH5gDF58nTxOEPFKVOmLtt
         LvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZXNvqfzawbySuzMVGw4gXlzTl+S+mGxYefHv7OoHq9M=;
        b=knMDBe0Zk947DBklX7E2GnHMwOynsRs9K75tpcS2/hBeuhCipZOg+XO8hC8/eX/JAp
         AxX8rAEWkJaMEgPOnlQwO9wA4t/25Isv1LmHSEdOnByL/SkW/SkkHC0wnn5ij6QkKBoD
         O3ex8+C+vuJQxMRM1dv1dNnP9YQxg94mhQlg3Z6zt6UZXkRTnfzw7hMitG4YtFO0I6VN
         4IKX+nEv/BupuY5ztU+JI4kPfVRV2wujln0ya4XgkRZ7DJ1JINZONcp9mGOojh6oR6os
         1bmVaplxfKWjZXY+jLn/FS0pbJwyOXJLJMq/Uf2jEx9PS+9u2r6i1LNUTo62gC3F2Gak
         +Inw==
X-Gm-Message-State: AOAM533CqYs3iEDzKEUcpXK2tS5SwdhcgUA4P6pf8uX7LeWiB0BtkG9K
        sRAIfCH/N6NdoVtBAf15y+wC
X-Google-Smtp-Source: ABdhPJwVWhV7xcyHGSnhtsgkxhkLngMuuDAXhlKcU5bikVc7ggxEJjXVhc+YEvI73ezrWJelM/V1kw==
X-Received: by 2002:aa7:8e9c:0:b029:152:8a25:548d with SMTP id a28-20020aa78e9c0000b02901528a25548dmr11242614pfr.73.1602992168439;
        Sat, 17 Oct 2020 20:36:08 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id j11sm7328736pfh.143.2020.10.17.20.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 20:36:07 -0700 (PDT)
Date:   Sun, 18 Oct 2020 09:06:02 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, alexandru.ardelean@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        vaishnav@beagleboard.org
Subject: [PATCH v2] iio: light: vcnl4035 add i2c_device_id
Message-ID: <20201018033602.GA27912@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add i2c_device_id for the vcnl4035 driver so that
the device can be instantiated using i2c_new_client_device
or from userspace, useful in cases where device tree based
description is not possible now(Eg. a device on a gbphy i2c
adapter created by greybus)

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 v2:
	- fix commit message
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

