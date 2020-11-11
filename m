Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C1E2AEADE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgKKINW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKINW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:13:22 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4A8C0613D1;
        Wed, 11 Nov 2020 00:13:22 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id h6so976031pgk.4;
        Wed, 11 Nov 2020 00:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iitQh+q0FehiLOu43hjjhxpuoRgl98YfNKBT516DQYM=;
        b=Czhh1dXG+fwgj+ZQkXc2uNm118mSTuHDaEhV6Ist2DRhb8kajD2WQvL9QqO0+ypROq
         PXtHcg36gqod6Hbs2Pbl4SUAuAo8M3pjniYVHAHRTmZC+jcGDlUSXx0VWmiWI2q4cXvZ
         FoZ/mII6eZGxyMvf+gB9UT8kowp6AMTVJY5KOKQPoAVJb1VymUC4aAZ7KZFPIUd8qRXw
         vTyt+nRS9tYPpZmBvu5xrxQklGwILQ7BlWBMzMA5BMcRz9ZORKDT/OUxNg9q7O44gxye
         oy//KCwnJAEgiH3Uxspa8hgDodYJIXAs4wVl9FGxuvcTG5Py27m+rZU3ls9Y0SzgpVRI
         VBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iitQh+q0FehiLOu43hjjhxpuoRgl98YfNKBT516DQYM=;
        b=Ai3+/L9Ng39KZxfaXVNFUeHBCyYeJK90oepF56arO1IbGH/zg4jAuipsBSAm0X3bb6
         JeEMeTaKgkGabGkC+r9qX0S7oGH+lrGLoLi2vNKc/AhSRucYkoRDIh/DBXKi2TlACbx2
         6HiCCFaboCUNAW+SUrL3yEI4aAXcB03OeYqM2e1vhtjgDzeOkGZ1zNxOK8kJCJtgExlN
         W8PHnye2jGbfsEcPt/fyDHUPadh4j1Rmf51tOBv5M30JHBFu6AOal42p+X8Cl/bNkqEv
         M/Zg85fvJ08/ujiQrzpmv7VeRMPiLgZJjMMosfYR54QSj+bEbBJmA0MVRGtn1W97y4H+
         dnsQ==
X-Gm-Message-State: AOAM532CuweChxePrpOl9POUyJTrsJcQgc8OwqjFt8JybaZMN3ynATKN
        lGDVkvel7SvBYy/WuyBOrHfLzDUvFv00
X-Google-Smtp-Source: ABdhPJxYPan4v7/DonqVyf1X76RnRlHbsJeLLo0Pzx/dOCMb/4dqVii1RB0aISxsCH5Ml9v6rTRNKw==
X-Received: by 2002:a63:5864:: with SMTP id i36mr10876045pgm.68.1605082401603;
        Wed, 11 Nov 2020 00:13:21 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id w127sm1562138pfc.172.2020.11.11.00.13.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2020 00:13:20 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] hwmon: Fix unsigned 'reg' compared with zero in amc6821_update_device
Date:   Wed, 11 Nov 2020 16:13:16 +0800
Message-Id: <1605082396-26560-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The unsigned variable reg is assigned a return value from the call
to i2c_smbus_read_byte_data(), which may return negative error code.

Fixes coccicheck warning:

./drivers/hwmon/amc6821.c:215:6-9: WARNING: Unsigned expression compared with zero: reg > 0
./drivers/hwmon/amc6821.c:228:6-9: WARNING: Unsigned expression compared with zero: reg > 0

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/hwmon/amc6821.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 6b1ce2242c61..ce7c9f412538 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -166,7 +166,7 @@ static struct amc6821_data *amc6821_update_device(struct device *dev)
 	struct amc6821_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	int timeout = HZ;
-	u8 reg;
+	s8 reg;
 	int i;
 
 	mutex_lock(&data->update_lock);
-- 
2.20.0

