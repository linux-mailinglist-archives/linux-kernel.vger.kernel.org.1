Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8FD27B200
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgI1Qfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgI1Qfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA196C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l126so1522751pfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PFNZXtI95g0K6EiyKzxVVKdekKnnD7HXNlnqY5psBQg=;
        b=os6AcU2wpUMO0LwxaiVbIb+NVpIgu3Edd4DRyzo+QSz8Z+xB5gnAuvQ0ZYVGUOmNUP
         ltE8DtXJ/t27XSxIO+hc3HEpKKOa89eikipbsSo91ZMAOzMup4JZU3F71V7lbVdKvcKM
         XjTbDZ9nBjNHkuZJ6ciMWZDef32e+jz/IQY6ZE96KPTY5zQSd45c1H+EU2VajYEigK7H
         xpwZCclXk6QTkNulj6B4s9MMeQ3vMbB+9I0xwsAJy1kW7xet4+JjxwTjpwYjpzFqlNgk
         QrdhNyso5S1rJhNKVhwMqexKu5BZqTpwNaj9k98l1bgA2mq+V0zWdgDXUJaYh+Z7bA7Z
         ktag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PFNZXtI95g0K6EiyKzxVVKdekKnnD7HXNlnqY5psBQg=;
        b=EHQG5Uwws9r4tf0j4C6HzQzjcpO0IK5qa5hNyiqLk0WKCxvbTz6TrWszpYoqp2wbsn
         epX90D5lM73rswrjQxt4STs58gmMac3yjiQG/4Ff2a+8C5N9Q88Gx4Nr28gJNVJ2O9eC
         8H/OSbrDfZEuIQWnVPoYdZQby7KlR/ZxchXk3NtdVl18ZlqMWiw49Y5tBche60Uf4FXb
         OBWCviGSP/Afg8SJBx6oilwPNGYRDGDUJSDvNxsYXZD7/2ntJXnOnqrRNnfLbrzWsvl3
         McSK4aS0YqTUR69qa77jU+hp6l5zeMDXFIAmEQq5B8GmWoya/+DbeDfIgpdifPwwuDrq
         46ug==
X-Gm-Message-State: AOAM530II+ZQbUPEZjmk9+g7G9A/7vPeaeUlYWYaTumQZw8zRTArLLAh
        cxbjvABejsUBwf4AycCXDU9zNQ==
X-Google-Smtp-Source: ABdhPJzxzKRXw7hgSldaGRbgnB6lTm4etRUB+E3moLb2conlDyuo1tUJTqJZ5ymj2fdq+XbugsKEyA==
X-Received: by 2002:a65:5902:: with SMTP id f2mr1714479pgu.379.1601310935258;
        Mon, 28 Sep 2020 09:35:35 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:34 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/25] coresight: cti: Don't disable ect device if it's not enabled
Date:   Mon, 28 Sep 2020 10:35:07 -0600
Message-Id: <20200928163513.70169-20-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

If associated ect device is not enabled at first place, disable
routine should not be called. Add ect_enabled flag to check whether
ect device is enabled. Fix the issue in below case.  Ect device is
not available when associated coresight device enabled and the
association is established after coresight device is enabled.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 11 ++++++++---
 include/linux/coresight.h               |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index b8b0a20e93c9..711beb92166a 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -244,13 +244,18 @@ coresight_control_assoc_ectdev(struct coresight_device *csdev, bool enable)
 
 	if (!ect_csdev)
 		return 0;
+	if ((!ect_ops(ect_csdev)->enable) || (!ect_ops(ect_csdev)->disable))
+		return 0;
 
 	if (enable) {
-		if (ect_ops(ect_csdev)->enable)
-			ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
+		ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
+		if (!ect_ret)
+			csdev->ect_enabled = true;
 	} else {
-		if (ect_ops(ect_csdev)->disable)
+		if (csdev->ect_enabled) {
 			ect_ret = ect_ops(ect_csdev)->disable(ect_csdev);
+			csdev->ect_enabled = false;
+		}
 	}
 
 	/* output warning if ECT enable is preventing trace operation */
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 3bb738f9a326..7d3c87e5b97c 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -208,6 +208,7 @@ struct coresight_device {
 	/* sysfs links between components */
 	int nr_links;
 	bool has_conns_grp;
+	bool ect_enabled; /* true only if associated ect device is enabled */
 };
 
 /*
-- 
2.25.1

