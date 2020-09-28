Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9F427B203
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgI1Qfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgI1Qft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2D0C0613D8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 197so1318634pge.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IMd2wxbWSskBrQ2C+X7YA5Ufqq005IN1/YwGk6ozQGg=;
        b=ilWQBABA6kMOrJoh/CKJlyxmjAFWLqWaWPFEc1dIuByBNPZQa0yfmTbHaUIGnrkmQG
         IPLjyH+PiMWw0+FjN1+lWtjTZmVOk+nUf5MG2YNuJTJ2pbtyslBYfrrCx+Tbm1i+6/k+
         vT0XPbNzxe98Ox53FByw8fSCLG/r/DQcrRugYVyVq+vJXOeQLlnVH52ZDu2TpKjFxk8P
         zrov+AQ277aJmWzONeUS6xBhiu8j3F5g3nDUZv9zMdot3nIwRBSfEfIHZyQaxr2U2WT2
         uixCS/wxyRkw4WhfL21r0+hBkhw5/5ifToK6bnvfGLaQ+rfFMdaeeAB0KWZVsA1Pubnr
         qf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IMd2wxbWSskBrQ2C+X7YA5Ufqq005IN1/YwGk6ozQGg=;
        b=KYyq5vVzAyJb1OTi7V6Qcddpi57xKnF0bM9r+qQTqE38gvtIEI4tONvbKvHq6mxzzW
         Ux74kMhAeUetM+4c5Jgj5FB43I15no3t4FAPEIquiE3ukIS9kuWEtHaW8HXMxyKMQhyd
         z7Hwy3nEGCZqdoIZEFswXLajqe4NED0h6hTCZumTAUkyIuA7hsClpO/XEpqV4Rdbn9s4
         Ok3ZL1AMO7u2q/hmxW5nffqsV3dxdKk0to5CueEu5cA+CM0//wVM7cL/DMY1Dg/OH38E
         rUwXmCGovu5GIcKDqrL9JjR/7XUhabM3GVqs1Y4JK9SUh9KiATGF0FgurH+QvPgNp/ry
         0R6g==
X-Gm-Message-State: AOAM533M8u2zqDMWL9vuviYP/UKFGZeRG2KsyoMWdZAD7RfmUvjNK+GX
        hT1GtFkT8+ao7CLo+EGofYYLLKXtRntNAQ==
X-Google-Smtp-Source: ABdhPJz2khhedvAGxqkeK5cUNSNg/eSDC0o9IXllj+NsVS2MWD18lzl8cv2QMY2GEcKzuAdlruZGow==
X-Received: by 2002:a63:144d:: with SMTP id 13mr827354pgu.153.1601310936257;
        Mon, 28 Sep 2020 09:35:36 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:35 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/25] coresight: cti: Increase reference count when enabling cti
Date:   Mon, 28 Sep 2020 10:35:08 -0600
Message-Id: <20200928163513.70169-21-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

CTI device is enabled when associated coresight device is enabled.
Increase the module and device reference count for CTI device
when it's enabled. This can prevent CTI device be removed or
module be unloaded when CTI device is enabled by an active trace
session.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 711beb92166a..546c97045afe 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -241,19 +241,30 @@ coresight_control_assoc_ectdev(struct coresight_device *csdev, bool enable)
 {
 	int ect_ret = 0;
 	struct coresight_device *ect_csdev = csdev->ect_dev;
+	struct module *mod;
 
 	if (!ect_csdev)
 		return 0;
 	if ((!ect_ops(ect_csdev)->enable) || (!ect_ops(ect_csdev)->disable))
 		return 0;
 
+	mod = ect_csdev->dev.parent->driver->owner;
 	if (enable) {
-		ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
-		if (!ect_ret)
-			csdev->ect_enabled = true;
+		if (try_module_get(mod)) {
+			ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
+			if (ect_ret) {
+				module_put(mod);
+			} else {
+				get_device(ect_csdev->dev.parent);
+				csdev->ect_enabled = true;
+			}
+		} else
+			ect_ret = -ENODEV;
 	} else {
 		if (csdev->ect_enabled) {
 			ect_ret = ect_ops(ect_csdev)->disable(ect_csdev);
+			put_device(ect_csdev->dev.parent);
+			module_put(mod);
 			csdev->ect_enabled = false;
 		}
 	}
-- 
2.25.1

