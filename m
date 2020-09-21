Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C96F272B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgIUQKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgIUQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:10:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA82C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:10:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id v14so30704pjd.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+YUGt6aV7OP8RvUr5xgq7JykMZCPIUZje2/XDNY6QSI=;
        b=k708JdgdIi/nSpV4h2XycMDyP077KsVUlK0ZeNYIFirBmbKiGGjKFwwk9P9qFjQrh3
         VOjnqrwORMsNCHfaWtcYiviVqU5JONwe8znOf/tcRo52+DbAnFbgrufqdDAJfA7HxB5P
         uXsj6yQ8YwQVZ+bULbYKD4OqUvj8HQme12sN0vRYTKZVOvNmJvDSOWoA9fhdFCCxQSVx
         ht5BOhSRX+sYx1Ntjfdh6zLwqpCMTYICjWyofGHuAQm8mj6PvdEVpMTSe9HBrz8pZz/n
         vq1mxPvIV1RwejCKPTXle2C2z3wDuKygJ9CrjxV5FQzhJnFL7d9BbA9/INBuFcnxL4bg
         ZM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+YUGt6aV7OP8RvUr5xgq7JykMZCPIUZje2/XDNY6QSI=;
        b=L9JnW713OI5p7OXPfPNNISZA9qlCD+4aLOqRF4PcdJZ33zk4vK4ucii1kofLmOapgD
         WBK+/mReMJQ+vv15OEzxBgsYj3VYi5Z67H0UYHjRewsXRPe6rnnNR4Nrx2TQaR06LN9w
         oDKTexdJ4ribYbU1lflGLoL8tOUpH04DwEq2d5cXAjQeWFRIfnxgab217NV0iDOm+2oS
         FUpCFjwtrb0nIayXa3A6KlEQMLAdWPyzO3uW3ZGnDyEPtfeUqmaqq16dSoh9saXgq3xs
         RapYmdJv22yAo+2/RNO1GM91WA/Jr276mtc3rX94wn711ExTr7d5mIReSVqp7YSGEfII
         59dA==
X-Gm-Message-State: AOAM5321oSAYTCNvKRv/8wo3mFPCzEkAq7B/qqhUKHBem6LsXnPRhX8h
        IQFYvOf0m7IUFN121W6z/LuHHf4nNbOG
X-Google-Smtp-Source: ABdhPJxW8TyC2msT8AHrIOLt25DoGImJ36P3WMzJLDSbMKQj9eph6jiHbEz5WgY61kGXVNY0e+sOoQ==
X-Received: by 2002:a17:90a:ce95:: with SMTP id g21mr78477pju.175.1600704652764;
        Mon, 21 Sep 2020 09:10:52 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6d03:bd12:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id f4sm9204577pgr.68.2020.09.21.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:10:52 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 13/18] bus: mhi: Fix entries based on Kconfig coding style
Date:   Mon, 21 Sep 2020 21:38:10 +0530
Message-Id: <20200921160815.28071-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921160815.28071-1-manivannan.sadhasivam@linaro.org>
References: <20200921160815.28071-1-manivannan.sadhasivam@linaro.org>
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

