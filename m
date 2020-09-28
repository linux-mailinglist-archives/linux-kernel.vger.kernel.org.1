Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C1027A622
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgI1EKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1EKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:10:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77D7C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:10:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 5so7155839pgf.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N1lX7l+McFM6cV+ssdxZ5AClsLBq3ozRzVIZ+mY0GZo=;
        b=Zsb4ex2+zDbadoDBlAJE+0lEop1QXXdIQXburj46gULleI+ODVb6gUDXw5lZPME3WP
         htU4xBZmkEuY85h0YBC11Eqej5iVA3KDybeo0Bijo3jkY5ZiYG8lUNchf15iW39oM9cf
         Q/cAVhVS8YhpDpOB5Bb0TTsNDXIDDNIkMkSMsUp7qwuTx0HWIuRs80ylOjSwH4nyYaqf
         Q7O3jCe3c6rXE+bFGG/QJ0SO3/PEYfrcQQEYqz/8H7I8TSbvgmB2ywAxBl+K8AbZcgua
         kTazgSkEe53N1Nq0+2P3Q/RPgdyF3fDk9PFXdpWM+XoIadxO5DCux4p6StaiY97kpDv3
         ZxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N1lX7l+McFM6cV+ssdxZ5AClsLBq3ozRzVIZ+mY0GZo=;
        b=rj32eqxcCJ0rk5EqJn/sbD9PVdguv41vgLIakzII9EmxpbX7XtGyluhwf/8/76uxfG
         K1nFRlYBFh9R8xWLqXKlErFB+KfS5i4CCnJ19Xt1LXpcOYysItpl5Is175hPOiW5qhVq
         eY1Y4by9jXfuN9s8UL9Gfs9jJIJBhoLtKGxaerK8lPowpGI681Ij6i8C4c3tWOyXmQM1
         zPlJOMxAhQCHAUvwnJptUR1kOiLjeSP+I+Ug6jEAUYwkeRN975TfoU8VGhlf97RD7Vn0
         QWEeuY6arzzahKds7SHmSE56r8Yw/BhEUl8swOad9whck+L5uOn6gNismfqWMEpR0HOM
         TXiw==
X-Gm-Message-State: AOAM530XdAKQarZLUNqbc4ym87UKMtKvlp1qNced97AzqmmSGzZCpjlQ
        28gwk5UGlF1ydQhc9lkTqNi9
X-Google-Smtp-Source: ABdhPJxzFdxTnbyAekcwlFMHPtG82khFWyb9XDbCbl4Xmfh6/f20JojZrbdL4AIrtxv/pyWU4mvlvA==
X-Received: by 2002:aa7:9427:0:b029:142:2501:35df with SMTP id y7-20020aa794270000b0290142250135dfmr9138883pfo.63.1601266234299;
        Sun, 27 Sep 2020 21:10:34 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6003:40df:7c40:5a87:eb86:87b0])
        by smtp.gmail.com with ESMTPSA id n21sm8306322pgl.7.2020.09.27.21.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 21:10:33 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 01/21] bus: mhi: fix doubled words and struct image_info kernel-doc
Date:   Mon, 28 Sep 2020 09:39:31 +0530
Message-Id: <20200928040951.18207-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
References: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
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

