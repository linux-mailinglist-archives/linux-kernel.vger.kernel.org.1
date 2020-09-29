Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7072727D51A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgI2Rxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgI2RxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:53:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B12C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:53:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ml18so233739pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+YUGt6aV7OP8RvUr5xgq7JykMZCPIUZje2/XDNY6QSI=;
        b=mRQxkYoBixvJF1Le8FkMC7LqWivfP6TeMbb2iQTv4mM0ZgzljpKRJDTRddL64xWz6c
         mtlxflF7/QMYBmW8VSR3s1sZ2NL3yXglpQWXn/4VYn2NCM7Z45ayYC2foijdM7sX+M0w
         afD1EWXxxd6GDzYcJ111JY5uPu2irdqYzNtt6PFINaN2JIB7YmuDllLUlrp0zwnS35Ql
         Uh1/qwlrBIym8lxKpZOZj+5hNpiCVOsMztxm3SjkZBVqKnNT5DX1jHbEEYRUiVMDQ9A6
         dRubqe8zhJcn4ZmAWl8xQmbvpFa4ZHjo6IQl0dLlb+lvgay+00GeZ0AHXYGJ+tDT6bSb
         gfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+YUGt6aV7OP8RvUr5xgq7JykMZCPIUZje2/XDNY6QSI=;
        b=XKWAqEYi62CBlZtEuJGNvbetjeiufhoZEp9lfP8+uEQM91BeJcB7iyLH+UT/y0rHYG
         uj6ryFHkK3eT1c+TW/hy5mBIqc/pz1/58B2OUw7JmnZk7bND+KxCNrznLznYBlfG7loS
         CTQWJT9jVL1kFiq+PRKQpltGg5bXqOT6AE50SxKI2al8hwbLqyEDSH2hymoCO7gwLVh4
         +DZRWU2oGKrmNTVJq2uBPcmKE9LRoxSl6IGrNleJBDbzahRDVbdaE9YSPK3XbWwoJTDw
         28cCOwW6iDmA5D1c0gZ8762lR14owhrE9zCPg3Kvuite5tYPfy3WMfAT7zlX+ZHNmhpM
         AEPA==
X-Gm-Message-State: AOAM531id0yLZr6p27p/qcKn36iwmPJm/au5Jvw5oE2Ix4hNNOY2DYCI
        V9dl24pbUl4PdMRCxnOU23lwrVrlhNZlv2Y=
X-Google-Smtp-Source: ABdhPJxJ9UPNW1HcIz7wS8wh7ox8xeVaye082jOi3ooDXcMMyUFdRZPHpcUGy4j1gALBpIytLrQdbA==
X-Received: by 2002:a17:90a:aa90:: with SMTP id l16mr1921077pjq.0.1601402004018;
        Tue, 29 Sep 2020 10:53:24 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id r188sm6271046pfc.67.2020.09.29.10.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:53:23 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 13/19] bus: mhi: Fix entries based on Kconfig coding style
Date:   Tue, 29 Sep 2020 23:22:12 +0530
Message-Id: <20200929175218.8178-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
References: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Kconfig coding style mandates use of tabs for the configuration
definition and an additional two spaces for the help text. Make the
required changes to the MHI Kconfig adhering to those guidelines.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/mhi/Kconfig b/drivers/bus/mhi/Kconfig
index a8bd9bd7db7c..6677cccd61f3 100644
--- a/drivers/bus/mhi/Kconfig
+++ b/drivers/bus/mhi/Kconfig
@@ -6,9 +6,9 @@
 #
 
 config MHI_BUS
-       tristate "Modem Host Interface (MHI) bus"
-       help
-	 Bus driver for MHI protocol. Modem Host Interface (MHI) is a
-	 communication protocol used by the host processors to control
-	 and communicate with modem devices over a high speed peripheral
-	 bus or shared memory.
+	tristate "Modem Host Interface (MHI) bus"
+	help
+	  Bus driver for MHI protocol. Modem Host Interface (MHI) is a
+	  communication protocol used by the host processors to control
+	  and communicate with modem devices over a high speed peripheral
+	  bus or shared memory.
-- 
2.17.1

