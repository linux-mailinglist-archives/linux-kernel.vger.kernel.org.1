Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132232B3F91
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgKPJLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgKPJLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:11:37 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92531C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 01:11:37 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id p68so2190634pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 01:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WDZ0CXg1yGGGY1e+ZEpaxJ8BP4ehKDc93ZgVx1cWbq4=;
        b=Fa03gclw6DQdj/8PiYVlZF2lcgcpa6b7ZQ50CFbBTiKC5dPzp+8N0tKBuHXqEv94pc
         t5NvA46nADIWQv41ep14lcoZVlCjxH5WdvtTwYg24yi8i4Ts5e9UZfGsFL4UwqpBZ4Za
         zYEA+bBqVlI7WZpcqTg0FopFVLi25I/mTqRtkNB706sCFzw6pW/Fm+Hf2wdv2F7jbIQI
         Gs/ji/iNqoJQMyOXrz7v4L4pStyraWi2Rg4VFY8sj86Y9wzrXlFBVgGTwhdppv8wfIM1
         QAIf0grkD5mAdQ2c/juJ9XF2VdhpGY+f1Azn8Qy2NHbjJ9/c5kgdvrZ4dal+/f6LxONR
         XNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WDZ0CXg1yGGGY1e+ZEpaxJ8BP4ehKDc93ZgVx1cWbq4=;
        b=K7KdxPWv5w58izUJjHQUUSXuyHt7XaGvGyLdqPsf3DY2nCAwgzAOeoI9ypMFXjgDro
         Zle81HrNOAGMeoTTTsQ4elQiojelwYjBEJeyKLDdWb6rFnHzHaXz0cNM9wDDa9j3l1qD
         zkGh2UJkw1kSbm9zxtHLfpk0jVzXrzTw4/ICWqPi/XzIRpZ2/kzUpkGqQux4PCCoyCtq
         s3Ff7n9a7UYoShWL3Bclmg+fS0P++9icVyKLKK8HPc+WW3YRGXr1Mz0iOOzsQAu2PgZA
         GKv6sErrU9DOjGvmvl84saUEFjg+V1/Wfu19SWQ+xOXjdtsbSdIv0fr6r2JMHVGcZDgx
         +Rxg==
X-Gm-Message-State: AOAM530enKKSBBwmlrbBvIUk3Etm7+I2Zb0M/l8khZo2enBYguw0qXhI
        oXBbFGHAOGRM0jFEkuqKpuMx/DMVKUVx
X-Google-Smtp-Source: ABdhPJwpvZSo3BRdSWyTA54DfocBXkT8Uj4S8ZsdV/7zXYjPjjGVtKsRGtnK8m+N9BY71WUfIjta9w==
X-Received: by 2002:a63:1d12:: with SMTP id d18mr12559140pgd.314.1605517896964;
        Mon, 16 Nov 2020 01:11:36 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id s18sm15332635pgh.60.2020.11.16.01.11.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 01:11:36 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     kishon@ti.com, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2] phy: mapphone-mdm6600: return error when timed out powering up
Date:   Mon, 16 Nov 2020 17:11:31 +0800
Message-Id: <1605517891-20357-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The value of variable error is overwritten by the following call
devm_request_threaded_irq() in phy_mdm6600_device_power_on(), actually
we should return error when timed out powering up.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
v2:
 -directly return error when timed out powering.

 drivers/phy/motorola/phy-mapphone-mdm6600.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 5172971f4c36..2f461c0d7276 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -423,6 +423,7 @@ static int phy_mdm6600_device_power_on(struct phy_mdm6600 *ddata)
 		ddata->enabled = false;
 		error = -ETIMEDOUT;
 		dev_err(ddata->dev, "Timed out powering up\n");
+		return error;
 	}
 
 	/* Reconfigure mode1 GPIO as input for OOB wake */
-- 
2.20.0

