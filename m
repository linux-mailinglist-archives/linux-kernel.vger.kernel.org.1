Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A67C1F8589
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 23:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgFMV7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 17:59:33 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:51854 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFMV7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 17:59:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49ks2B5JCzz9vZws
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 21:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vN1gMTzxLsj6 for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 16:59:30 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49ks2B3Wq0z9vZw4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 16:59:30 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49ks2B3Wq0z9vZw4
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49ks2B3Wq0z9vZw4
Received: by mail-il1-f197.google.com with SMTP id e5so9180412ill.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=41c7FVjnuZxspya187rlx7OBSjVWB+zOwPrRB+ZgQSg=;
        b=ZClCkewZT10IFwgu68fiRQ0a2lUNssxCW8Qpwbz1BlQQD9oo8RsEMk+B6NXFRWyjAR
         G78hU9OGxRfC4up3QAteuRz5aiuxkQ8Ll64R9AxKIwttWPAnrnmXomK4nRuaAGD2Ka6T
         eE0OIsZ0pHhG5bVrjTLwEbgdxG+V9gNKj3gwO4U0oNq3mxaYZb9n+lb1thduT55wQock
         xRgRORglF9rM6zbJa60dU9T7cQ/tCIqV+E8kYCq0YV/S4ZcPMBhCqUGuzBYWT8oxCivW
         ypVEGDWcM9GBGIjHClhYdXGsdYp5QWCWIP5rRfA661NNizK7nUMU3aqnMOCufYCeIEcA
         zaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=41c7FVjnuZxspya187rlx7OBSjVWB+zOwPrRB+ZgQSg=;
        b=QgwXcV/qNerElNFbQtVQH+RrerHQjUvgrHWDHu1FAxewyIoFFNlEjYK3qFy1n/Hnsc
         04xZVXXWe1jp2pr7jz64E5mLhOBnJNwjowjeOoyRfsHYAVrGCiWyRjO7r4RafaVmBrCC
         xIk+iPt8yB3mYc5mjsb4ZFtXGyevxkclvjvj2WldlJ19XWGhzMmBc/SlJvt5LvjWmmhh
         D1UutIetms1MqxU53BPRtbIN2CX82yNbbkU4sWDCEh60ewSkOg+L8JskIrQpRofHDMzE
         peVqe2CCPxdnrlmpM3RYTSt4YcBJ+H/9oiKrv2HvQS/eNLuy6QphjqV0E6gp3IxVHDcM
         3TdQ==
X-Gm-Message-State: AOAM530TEzxdNrEKDopEN5JC7bQBXTVxWqEa5s/Bt/U1gryrHLdYxS4S
        BmsiWZLDgYW/B3rhgTRAXXsoLxfudY7I0XnhuUrUYgqIflZEfJC8KPGBQRrYSwkFIuaV/Xbl9lI
        bc68ni0fYoKEMbI3P6ErL1zPg7cE+
X-Received: by 2002:a5d:87c4:: with SMTP id q4mr20721687ios.169.1592085569970;
        Sat, 13 Jun 2020 14:59:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzipdRZykMqI9KaxMvFY/GNQReGYjPRPDqXiZP3a3gDErwMDUCI4tYTOc9XVtuyQfZVY4AYBg==
X-Received: by 2002:a5d:87c4:: with SMTP id q4mr20721663ios.169.1592085569733;
        Sat, 13 Jun 2020 14:59:29 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id t12sm5321589ilj.75.2020.06.13.14.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 14:59:29 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: xiic: Fix reference count leaks.
Date:   Sat, 13 Jun 2020 16:59:23 -0500
Message-Id: <20200613215923.2611-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus call pm_runtime_put_noidle()
if pm_runtime_get_sync() fails.

Fixes: 36ecbcab84d0 ("i2c: xiic: Implement power management")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/i2c/busses/i2c-xiic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 90c1c362394d..ffec41e6be72 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -696,8 +696,10 @@ static int xiic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		xiic_getreg8(i2c, XIIC_SR_REG_OFFSET));
 
 	err = pm_runtime_get_sync(i2c->dev);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put_noidle(i2c->dev);
 		return err;
+	}
 
 	err = xiic_busy(i2c);
 	if (err)
@@ -860,8 +862,10 @@ static int xiic_i2c_remove(struct platform_device *pdev)
 	i2c_del_adapter(&i2c->adap);
 
 	ret = pm_runtime_get_sync(i2c->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(i2c->dev);
 		return ret;
+	}
 
 	xiic_deinit(i2c);
 	pm_runtime_put_sync(i2c->dev);
-- 
2.17.1

