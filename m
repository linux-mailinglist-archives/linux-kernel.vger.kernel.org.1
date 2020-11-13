Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138E82B173F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKMIeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMIet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:34:49 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5199FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 00:34:49 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id g7so7050647pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 00:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SzeltF3pB0L2oDarb7juHowafWuk8dBQTtHm6qNPO1c=;
        b=XGASf1DeiaBhuHCJh/QE368UkCD9XwtAJ94WNKWvJNzbmjNK9+RIWFZd/JmHaap8Qe
         4KA117iEIMk+U9UDqTNWNSvJC1qGY2f6i4in1mImwQ+IW94OKwaVkbVh0YRjaIK3xh72
         2TdJqLm6LAf762ivVjcBWULQNVuZXQW+h1ckcZjhtjtyHJhRdTP0xh6hkSirhhncQsBR
         bnEYUvdaYs8QU8PQLwVpli7xitOKvAWZu0Z+Pebv/dhoGCf86Dx8uSs+FbCWDjRHop9+
         MLTr/oevFyLN6S4qcxQv1HHPQPv7RluuoU2S5NE7ch0c7Rrg+wet0gN9uTjlo2C5c07m
         NYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SzeltF3pB0L2oDarb7juHowafWuk8dBQTtHm6qNPO1c=;
        b=hmSxu/ssSh8vs69bD1Hvm3aZYXnIPt34WLIrNpnpVhlnv261pByQyqGGa0gUqtjrY7
         IlN3PDNLBM05zV4OpLkDffkFy2AAfiJ4XernYbD0MZgnfHPinCpNy1G16y+3f82Vv2b1
         ZqrVz/Qo/cXojPt8zd93zv4RPnPAXB2RzZD5kcXIQup6mKkn/s3Ir1l3sRCtco0QNQhg
         RbrQphHwT6oU880b/WKtwuTCR42/uRV8vSkp+G51F02Ja+N0MQHSN6xf3renZk2Dabvu
         h7XhUgwYhwDbzf+xX91SI4fBBSxuLDA7jrqpjbDi0wSdfApJKCRZyeUImzkDmtEfXiFm
         RTcw==
X-Gm-Message-State: AOAM530SI4ok1bXZGdkSTj/MMkEBEr0x4AOsGVqyRW95Oj7xTVN2deyK
        elfDQnEkFGWVj8zTHjjtEQ==
X-Google-Smtp-Source: ABdhPJwlnef7uukqXu7Zj3+F2yeGGHk4rZOf8UoU0IdAdueQaurCy/bjJ/+hvDFzrjm/lIafkhtpdw==
X-Received: by 2002:a63:500c:: with SMTP id e12mr1237304pgb.346.1605256488815;
        Fri, 13 Nov 2020 00:34:48 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id u10sm9192312pfn.101.2020.11.13.00.34.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 00:34:46 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     kishon@ti.com, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] phy: mapphone-mdm6600: remove the unused variable error value assignment
Date:   Fri, 13 Nov 2020 16:34:42 +0800
Message-Id: <1605256482-5101-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The value of variable error is overwritten by the following call
devm_request_threaded_irq() in phy_mdm6600_device_power_on(), so here the
value assignment is useless. Remove it.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 5172971..24ab848 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -421,7 +421,6 @@ static int phy_mdm6600_device_power_on(struct phy_mdm6600 *ddata)
 			dev_info(ddata->dev, "Powered up OK\n");
 	} else {
 		ddata->enabled = false;
-		error = -ETIMEDOUT;
 		dev_err(ddata->dev, "Timed out powering up\n");
 	}
 
-- 
1.8.3.1

