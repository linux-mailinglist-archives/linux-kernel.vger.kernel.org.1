Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8FB27D4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgI2Rwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgI2Rwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:52:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE79AC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:52:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so5295662pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N1lX7l+McFM6cV+ssdxZ5AClsLBq3ozRzVIZ+mY0GZo=;
        b=PJe+P1fqL1ZX9/RlJKjKd2gP/un7dEK/H0G2AIfohepaT5OC/OAw/1DBId4RkhFPrZ
         gy3a0WXPg9lm5BQV3tUJBgan812XE2gvUhrogAbcnVqb36E3o/6e1+uMxc3kElu7lbn5
         WSpLUGqCj+D4ceWb69emB7b6NSM0is//mKXzYsgjctT6TCWuoU6gDGQdWhNqVpvuDobc
         14WdHCzDv8LwopdKK+L5l9JFcI7W+TYdWZTHqHxGS7NV+kaJXrIDT48yCFBLN8yAHzR1
         sKZ50yWrVRLwFAK1xKKler66w3iMbznDlkBmu/uGkQ/W5cfRDmA9LNfQTJJN7Kjxvena
         L30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N1lX7l+McFM6cV+ssdxZ5AClsLBq3ozRzVIZ+mY0GZo=;
        b=SvRpZloBz6HSSD1aGRj3ZttHiWk1TyGnRNJmXR6PJCqRnsrHf2ZwumJzWKAcjxvqLi
         h+pMQ5C+WslV5FizqZBIxpZKPF7JFPPHx16m6L7RYb77bLXRiawPfv6do63h0JnQdXpO
         cDNQpqEyV3Jt8rh8WGrZjFqrUaYXI9VQ5QsXNw8/EnSZVo1NHhbAl2oEMVZWx1AXEb30
         bmUOWzABJVYmLOcIsn02NMbeWlwT2SXvwYLCML0pRIFHXea8RSwL27tINSIwInSBi4Uo
         DQ4NMX2xxMBoUjVKrfmnuaw2lDu35RGzu60Jat44fJEBA8s20ScAYL+8At75C9NJWXwE
         Enbg==
X-Gm-Message-State: AOAM533BajG/pGDcu99/uZ/veFrbn9QANLQHoPuVN/Z1U3OGe/tUXm3/
        XHLinmXdAH/R0bDE6b3QMc99
X-Google-Smtp-Source: ABdhPJwHl2araGfZcOBIkbzUbUTP/rCz4s3UW/kOg4aDl966UReZYrfICnLxtDiqWExm710mgtV7UQ==
X-Received: by 2002:a17:902:d90e:b029:d2:8cba:8f02 with SMTP id c14-20020a170902d90eb02900d28cba8f02mr5643010plz.38.1601401955331;
        Tue, 29 Sep 2020 10:52:35 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id r188sm6271046pfc.67.2020.09.29.10.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:52:34 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 01/19] bus: mhi: fix doubled words and struct image_info kernel-doc
Date:   Tue, 29 Sep 2020 23:22:00 +0530
Message-Id: <20200929175218.8178-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
References: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop doubled word "table" in kernel-doc.
Fix syntax for the kernel-doc notation for struct image_info.
Note that the bhi_vec field is private and not part of the kernel-doc.

Drop doubled word "device" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Hemant Kumar <hemantk@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[mani: Added bus: prefix to the commit subject]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 include/linux/mhi.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index c4a940d98912..0779bc689b3e 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -85,13 +85,15 @@ enum mhi_ch_type {
 };
 
 /**
- * struct image_info - Firmware and RDDM table table
- * @mhi_buf - Buffer for firmware and RDDM table
- * @entries - # of entries in table
+ * struct image_info - Firmware and RDDM table
+ * @mhi_buf: Buffer for firmware and RDDM table
+ * @entries: # of entries in table
  */
 struct image_info {
 	struct mhi_buf *mhi_buf;
+	/* private: from internal.h */
 	struct bhi_vec_entry *bhi_vec;
+	/* public: */
 	u32 entries;
 };
 
@@ -593,7 +595,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl);
 
 /**
  * mhi_sync_power_up - Start MHI power up sequence and wait till the device
- *                     device enters valid EE state
+ *                     enters valid EE state
  * @mhi_cntrl: MHI controller
  */
 int mhi_sync_power_up(struct mhi_controller *mhi_cntrl);
-- 
2.17.1

