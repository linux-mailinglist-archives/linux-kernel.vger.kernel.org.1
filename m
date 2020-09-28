Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BDB27B208
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgI1QgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgI1Qfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D825C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u24so1344447pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQAZxuXMQGBtR+XEE1cJor4vajw3CBOa7U4wzhGgrBE=;
        b=c+ufyza4khJYPdz/3PTvWDJmufwz1AAjIsMmQ3Jhoze+AfN8okAxLuv5bXb1I5gKHw
         xhRyvrcc8iuDzXHgtCtJ2yxbculjTci51cPSOls9JCZuY6w1k1xGdi6Uu/9fZpl0cF67
         E7XsFI09xHb4JOqOhgTwpUdcwYtWtpqKnOd8a2hoQOX7HSpip+UW4quUrFEsnQlT88M0
         a+jedxS1/UMRuNKtOb0FGYoOkJDLwSC7Ewqq/oTY0rr+lvvsG5MrSc3bxLyM+QG5Xi7G
         4nMytsyXHy1DkTavPX/EZqlJw5eXy3Pc+C0130bStbHGwfPQAZL7chLFGwgBA5LOUm3Q
         x6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQAZxuXMQGBtR+XEE1cJor4vajw3CBOa7U4wzhGgrBE=;
        b=XXjzlKQxllPEfTGEmCFEDfoP97GiOr9okxjPKmgvH0BJNYIwZWUiRsOAbhnqL3VkYp
         Mq9U/EuL7om/XSR/soHWfw2FsFuFsgCvXS/g7Ss06vdaQhWrLaMVGCTsssY5bA8Je8x/
         2PnUTIzecRWIroQGWpqqzBbrabye+1IjTCk1A9W1RuvEcD7gbgIe6Ss8p54EUsct5eyx
         ELfsvUvoF5uelELeg7uFeSwLIqQnKMg0CRPZPY3WcjoBCMhMgL7r9E59oR3yKbONvKPw
         zMgRDt3jARzoOPeF45aoqSvCCUL9XY2uKzPEmytyBiJKgQW5mKHRYO9pbojDuVHuSWRI
         rPjw==
X-Gm-Message-State: AOAM533adI6D6OSfwRWOoqs4Ak+3fa+Xl/OuHKuSY0XoSBmqIwtCKBqp
        y+7Ys1HWawRbsctU2sXgw1OK5yyWP1VwiA==
X-Google-Smtp-Source: ABdhPJwWvP15f/fbhVDpd4HCUcyFdHiHD7t1vvnFgxCgXFUH0LfFZUnvzJ9ZCHomH+zStSj3hDAclg==
X-Received: by 2002:a63:c00d:: with SMTP id h13mr1816537pgg.358.1601310933065;
        Mon, 28 Sep 2020 09:35:33 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:32 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/25] coresight: cti: Fix remove sysfs link error
Date:   Mon, 28 Sep 2020 10:35:05 -0600
Message-Id: <20200928163513.70169-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

CTI code to remove sysfs link to other devices on shutdown, incorrectly
tries to remove a single ended link when these are all double ended. This
implementation leaves elements in the link info structure undefined which
results in a crash in recent tests for driver module unload.

This patch corrects the link removal code.

Fixes: 73274abb6557 ("coresight: cti: Add in sysfs links to other coresight devices")
Reported-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cti.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index 5003d1f59af0..abc8b32e79b3 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -494,12 +494,15 @@ static bool cti_add_sysfs_link(struct cti_drvdata *drvdata,
 	return !link_err;
 }
 
-static void cti_remove_sysfs_link(struct cti_trig_con *tc)
+static void cti_remove_sysfs_link(struct cti_drvdata *drvdata,
+				  struct cti_trig_con *tc)
 {
 	struct coresight_sysfs_link link_info;
 
+	link_info.orig = drvdata->csdev;
 	link_info.orig_name = tc->con_dev_name;
 	link_info.target = tc->con_dev;
+	link_info.target_name = dev_name(&drvdata->csdev->dev);
 	coresight_remove_sysfs_link(&link_info);
 }
 
@@ -589,7 +592,7 @@ static void cti_remove_assoc_from_csdev(struct coresight_device *csdev)
 		ctidev = &ctidrv->ctidev;
 		list_for_each_entry(tc, &ctidev->trig_cons, node) {
 			if (tc->con_dev == csdev->ect_dev) {
-				cti_remove_sysfs_link(tc);
+				cti_remove_sysfs_link(ctidrv, tc);
 				tc->con_dev = NULL;
 				break;
 			}
@@ -641,7 +644,7 @@ static void cti_remove_conn_xrefs(struct cti_drvdata *drvdata)
 		if (tc->con_dev) {
 			coresight_set_assoc_ectdev_mutex(tc->con_dev,
 							 NULL);
-			cti_remove_sysfs_link(tc);
+			cti_remove_sysfs_link(drvdata, tc);
 			tc->con_dev = NULL;
 		}
 	}
-- 
2.25.1

