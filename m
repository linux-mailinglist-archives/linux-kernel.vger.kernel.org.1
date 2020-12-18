Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A4F2DE823
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbgLRReJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbgLRReH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:34:07 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE78AC0619D9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:38 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y8so1750774plp.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9CEMg8/C2aYpmWeg0E4atqdzCFaHxz28xvWGUTHAaOU=;
        b=yGs7YdcFnxcZHUhZKvzMEbe1PoyRwerMN9vB8qmQpIYY5RgBnNuhxZWwwwB5/lvtFg
         9aJAr/2jeVGd5E7TkoiosCRVL+V2SC9ScrAd1I7lPVLdPTptBIB/4ja3BZ22oVY/H6AH
         wpHzqrnB2kie/SygjiVg0/5VGSkus9A0nJfBMGaQyoLUrvLjKQUk9NxGCznEYIopt5cf
         wk7hTGXGofPIP6g70XV74OnoSi7Zd8w+swDXnkXafAcUjM3MJz8BdJ9PsuxasooCH7X0
         igKonz3VPr3d+M7++I1Xnr/DrGqjSSPU6VGBw0JHnNO72G74JFt7Deq3r0RBR+Adc/bY
         w0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CEMg8/C2aYpmWeg0E4atqdzCFaHxz28xvWGUTHAaOU=;
        b=SylhvPQxe42NvLrSUPTd1phhhma7Qd6UcVrsAmnjV7mbZPyxvaPe4KK6K9E81hDa+I
         /tmtP3homSmryrAPBDW4PHup1tExGm+pno9z2b+bIED2MEMklxqWE4I5zuRqLZLyim7l
         zCtjxtMnUh/uiLcC5uWsUL/UGdGwLsIU0bBzEndAmQAOlfP7eoteDbqAv7iMKlhh93wA
         g+NGxHniBhuAPZxUq1a4fILUMmLZCIfmGfBNK2c5W4rKUtjyswdiyPeAp5lhvjzdfpTX
         RH6lcGWHRDaOHS48nMjnavsKnciImKAhefZQdlUs6YhoDJnMgDMc5mfHkqWiJNes3Ase
         z7kQ==
X-Gm-Message-State: AOAM5333TezW5n5gk0kDFz+G3vLia+INAkrxCnFXSHg2R4P7Rx36knMB
        Bz7Rw0zxz/bYTw8teOClW5r/wQ==
X-Google-Smtp-Source: ABdhPJyx4COQ1gqOq1bLZo5G263DD9QApp1/1tOEBa7Tyyg0pG3GsdzUzZUkAtVUJbF7z4bYaR6IYw==
X-Received: by 2002:a17:90a:e28a:: with SMTP id d10mr5142068pjz.77.1608312758354;
        Fri, 18 Dec 2020 09:32:38 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l11sm9892957pgt.79.2020.12.18.09.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 09:32:37 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/17] remoteproc: Add new RPROC_ATTACHED state
Date:   Fri, 18 Dec 2020 10:32:18 -0700
Message-Id: <20201218173228.2277032-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
References: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new RPROC_ATTACHED state to take into account scenarios
where the remoteproc core needs to attach to a remote processor
that is booted by another entity.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_sysfs.c | 1 +
 include/linux/remoteproc.h            | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index d1cf7bf277c4..1167adcf8741 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -201,6 +201,7 @@ static const char * const rproc_state_string[] = {
 	[RPROC_RUNNING]		= "running",
 	[RPROC_CRASHED]		= "crashed",
 	[RPROC_DELETED]		= "deleted",
+	[RPROC_ATTACHED]	= "attached",
 	[RPROC_DETACHED]	= "detached",
 	[RPROC_LAST]		= "invalid",
 };
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 571615e77e6f..f02958a6c001 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -406,6 +406,8 @@ struct rproc_ops {
  * @RPROC_RUNNING:	device is up and running
  * @RPROC_CRASHED:	device has crashed; need to start recovery
  * @RPROC_DELETED:	device is deleted
+ * @RPROC_ATTACHED:	device has been booted by another entity and the core
+ *			has attached to it
  * @RPROC_DETACHED:	device has been booted by another entity and waiting
  *			for the core to attach to it
  * @RPROC_LAST:		just keep this one at the end
@@ -422,8 +424,9 @@ enum rproc_state {
 	RPROC_RUNNING	= 2,
 	RPROC_CRASHED	= 3,
 	RPROC_DELETED	= 4,
-	RPROC_DETACHED	= 5,
-	RPROC_LAST	= 6,
+	RPROC_ATTACHED	= 5,
+	RPROC_DETACHED	= 6,
+	RPROC_LAST	= 7,
 };
 
 /**
-- 
2.25.1

