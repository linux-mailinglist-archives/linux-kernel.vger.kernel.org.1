Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A367327A639
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgI1EL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgI1ELZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:11:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDB5C0613D4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:11:24 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so7136858pgl.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+YUGt6aV7OP8RvUr5xgq7JykMZCPIUZje2/XDNY6QSI=;
        b=AOeLHt/KDm80VKiduR8Ny1aiS600MblMO8wr+UFAVtGy8ynNYhB6EqPpBWGvv2lg6r
         5zPnMMi59qGXKVdR/N7PTEtgjwAzGEUEASaaMi/EjIjxcFNlaYH0K7UeKhN4wPeZQJrI
         ASKRXDJmUKlje8EiKsArwTef6qEqjbXvUXmfOFaFAa1kkluqew9WwfMJgq1rFXUPRsjI
         0d//gNgWYfGFyTUNEN6OxG6I56N2CzLpi4u3aQyqcdmAammzoOWIvBO6QGTsMAtN8v3W
         mA1dmqf4p/ohWieRbTOaSIIgQ5D5QgBYJLqz45XovJCprwQFnPOfBml9VQTCV++B901O
         tAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+YUGt6aV7OP8RvUr5xgq7JykMZCPIUZje2/XDNY6QSI=;
        b=D/GbOAkT/6dzwy4NMXin76zbuJrS7qE/fYjxMAA4m4upGB/FCTiHtAalQci9T0NjZZ
         /7P9bHWXT3EaXGFWVBoOrX2vR/1nwjrYQ6AfnvUZkpd4f1AZmzce6A9TmZmImdRSM1At
         5c5zpHeUi1ZgRF7aC6wAVUDQeZiBon502NEkbDpwQvOH0EWhwTym8IKAmS6aMjp+RhTg
         5mzs1BwIED588kcU9iEOkll95j4XWI+O+/509zqYSxdavR4UVvlgdZyCJypg+2o++RIq
         qcZxAJqu/Ps4u5WwPMBxicT4t+mS0NYztVGHjm/VjIamsz8MKOtrEa+wFngOoMdPruCp
         WJTg==
X-Gm-Message-State: AOAM530ptuEwIRt/dbCkNrOmPSTaLPQFJo7bbfLXwi64S2L8J7ReBcWT
        QdErRSrlxQ9mQ9po3d/ijoiP
X-Google-Smtp-Source: ABdhPJy5NlcTy2vGgfZAtEyXp28882bTlk7+SZpb1IT19eAjj79KZzuV1VUbXyFmEt/KxYkYDEY5qw==
X-Received: by 2002:a17:902:8493:b029:d2:42a6:238 with SMTP id c19-20020a1709028493b02900d242a60238mr9474319plo.4.1601266284258;
        Sun, 27 Sep 2020 21:11:24 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6003:40df:7c40:5a87:eb86:87b0])
        by smtp.gmail.com with ESMTPSA id n21sm8306322pgl.7.2020.09.27.21.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 21:11:23 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 13/21] bus: mhi: Fix entries based on Kconfig coding style
Date:   Mon, 28 Sep 2020 09:39:43 +0530
Message-Id: <20200928040951.18207-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
References: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
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

