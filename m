Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0C127B206
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgI1QgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgI1Qfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:34 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAFCC0613D5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k13so1537970pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LbFpq0wd5+hxz3XH6XRLouzUqxCeQhgca4mXu1de8J8=;
        b=w2aEywjxp9dMgipUoJ9iL8g/12berH/b8sx9NjaH5ufVmIakaWTqAR7la8pcEAG/BZ
         CNtY3YTMyLhvZGoeaREXAi9j9EmxQMPZyYfpsq5GyZMZ7T2k1F8J4qK2dQiWMarPPb/r
         SF3Apbu35eZ5srGjlVDKE1C+aZfayp8FE3AVwdkH3uo5apOsO5EMZ9UBHAKDmx812GF6
         8Mw69mvUuu9iqPWg0NZHha54Mu8vtOjaANYclXJdjK0tlnWe5deeXTbGHMekNSvKqtRN
         RPV7ssadgFHgNP1d8omQtHD4ao6+imEOcu/wxsUiUAVnb4+UMsLJxS88/s/YAho72c5w
         skIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LbFpq0wd5+hxz3XH6XRLouzUqxCeQhgca4mXu1de8J8=;
        b=fYpJOWBjEmUgDZOMfKcMDO/dt0J/JpGS5PI7oZmJYb+AWChqAWmohCvwvW4w7PGcFY
         oUpbxaN5AGLy+526bIrVJ3qxxonTdtEbcJV/omJvls1ah/VMfB+gg8jnWn2boEvFI7KA
         FhNR+BNqYDJjBBQd9y2InLpBK6JUd/C1+OazopAjlGogO3/BQYLKAM1y6219LEogIdBV
         F1xlUOHkODfDJOEgQVFChY3VrpNP+1vv4pSuBGHh+Sk3drGW4Voaf91oreRSebxfPx17
         +cQITeam4FclPvfCmwKqjlllHAge1u6lL7MnC0KNVWW4zIxLiqBhUZd6DlySwxFIEa+A
         wlmg==
X-Gm-Message-State: AOAM532ptdmwRuI/X3W92Nx5MVbEZwAcbL8qPLxYOEsDhHL2IUj4jUoF
        B5L776ailw3t6App5VZVX1aljQ==
X-Google-Smtp-Source: ABdhPJyZB5vjT7d/JfEtTBZ44fpfjE6idaPbl/mLkqGjBv2OCTPwzokn0FcFyvA3SLKHoBoTJf/VMA==
X-Received: by 2002:a62:6147:0:b029:142:2501:34e8 with SMTP id v68-20020a6261470000b0290142250134e8mr209057pfb.65.1601310934053;
        Mon, 28 Sep 2020 09:35:34 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:33 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/25] coresight: cti: Fix bug clearing sysfs links on callback
Date:   Mon, 28 Sep 2020 10:35:06 -0600
Message-Id: <20200928163513.70169-19-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

During module unload, a coresight driver module will call back into
the CTI driver to remove any links between the two devices.

The current code has 2 issues:-
1) in the CTI driver the matching code is matching to the wrong device
so misses all the links.
2) The callback is called too late in the unload process resulting in a
crash.

This fixes both the issues.

Fixes: 177af8285b59 ("coresight: cti: Enable CTI associated with devices")
Reported-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cti.c | 2 +-
 drivers/hwtracing/coresight/coresight.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index abc8b32e79b3..38e785d913b0 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -591,7 +591,7 @@ static void cti_remove_assoc_from_csdev(struct coresight_device *csdev)
 		ctidrv = csdev_to_cti_drvdata(csdev->ect_dev);
 		ctidev = &ctidrv->ctidev;
 		list_for_each_entry(tc, &ctidev->trig_cons, node) {
-			if (tc->con_dev == csdev->ect_dev) {
+			if (tc->con_dev == csdev) {
 				cti_remove_sysfs_link(ctidrv, tc);
 				tc->con_dev = NULL;
 				break;
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 4f4485b17458..b8b0a20e93c9 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1246,8 +1246,6 @@ static void coresight_device_release(struct device *dev)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
-	if (cti_assoc_ops && cti_assoc_ops->remove)
-		cti_assoc_ops->remove(csdev);
 	fwnode_handle_put(csdev->dev.fwnode);
 	kfree(csdev->refcnt);
 	kfree(csdev);
@@ -1582,6 +1580,8 @@ void coresight_unregister(struct coresight_device *csdev)
 {
 	etm_perf_del_symlink_sink(csdev);
 	/* Remove references of that device in the topology */
+	if (cti_assoc_ops && cti_assoc_ops->remove)
+		cti_assoc_ops->remove(csdev);
 	coresight_remove_conns(csdev);
 	coresight_clear_default_sink(csdev);
 	coresight_release_platform_data(csdev, csdev->pdata);
-- 
2.25.1

