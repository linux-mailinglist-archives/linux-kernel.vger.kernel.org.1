Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB21C26C9BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgIPTVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgIPTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:19:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C86C061352
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so4440970pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0uNOvGB6rUb/6Wge2+zVi2CVioKcm2kY4sTfTs2ztTc=;
        b=nFj128Hpt/ngFdgL72D8VO/D730YM7ANn/edQINa2cXvgEwmgYFnSZMkXaJVuCe59Z
         r+feZtf+0MAPDm46d2xzx5bnRsHNumFHEH5RQFKfdM+Cin0R89gxg0cUqQt5J9CmoJB4
         mot0FWrSiCH4Cdke16zQylNGIMUj7BliwwyqwyYClSKGlcBQlQGWUgP0SG/1m5HWOMAe
         eCQCFRaGaAjZTzhLSgma2Qn0i9h7xbWO9121lYc6dcJ9lmCdPMw0bfW11TfXnrhC3Mls
         60NT9PgtUgFbDFe63GmNVWmXSDPq6ef2MSaHO/IftMTYLk3nMRbs/IBZJHtqFE3iGJw+
         /QAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0uNOvGB6rUb/6Wge2+zVi2CVioKcm2kY4sTfTs2ztTc=;
        b=WPBALr3HXVmPT8bDn9zinLj0kjMBftuliS2wtybYGfkFQZt97mcJkk68D8s21n7Bgs
         glVNpoFYo76MFuJ/FjCVWEgSL8LVoWhx+kkLs9XUon6bHeIiFjsEhefSdBSp7p16UaS4
         0HAVJK6go/BzEoHYO0AQJJSIChKz0pFgTeFizbt1yX+vefGljfOC/V9KIAodwH0vktq9
         y0PgxL2fVzk1d1m9qes2549gOLedneqtUl5caC+UHRPo295v1gFBvZySagatWvAh78Wd
         5nnwpT8mCP7Fcv2KYXIzSzW07mguEThJcknLsJaUAL8hhUq9G3kjh3mDCdivscZ/9/IB
         lSNg==
X-Gm-Message-State: AOAM532vEWyH60UBhua/abcEq6HWFdHYjU5sotWbILX5YyEfJdX9cTKb
        efCLCiAuF8G761trTcofBWZqqQ==
X-Google-Smtp-Source: ABdhPJx0MiHiiGTPhNQdOx875EloCFk/Qn3vdbGOL8WQgxcaBGrvx0ggnF6mqJ8WhqZweIupkKPE+Q==
X-Received: by 2002:a62:503:0:b029:13e:d13d:a0f9 with SMTP id 3-20020a6205030000b029013ed13da0f9mr23556330pff.21.1600283868487;
        Wed, 16 Sep 2020 12:17:48 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:48 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/16] coresight: etm4x: Fix issues within reset interface of sysfs
Date:   Wed, 16 Sep 2020 13:17:29 -0600
Message-Id: <20200916191737.4001561-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Zhou <jonathan.zhouwen@huawei.com>

The member @nr_addr_cmp is not a bool value, using operator '>'
instead to avoid unexpected failure.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: lizixian@hisilicon.com
Fixes: a77de2637c9e ("coresight: etm4x: moving sysFS entries to a dedicated file")
Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index b673e738bc9a..a588cd6de01c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -206,7 +206,7 @@ static ssize_t reset_store(struct device *dev,
 	 * each trace run.
 	 */
 	config->vinst_ctrl = BIT(0);
-	if (drvdata->nr_addr_cmp == true) {
+	if (drvdata->nr_addr_cmp > 0) {
 		config->mode |= ETM_MODE_VIEWINST_STARTSTOP;
 		/* SSSTATUS, bit[9] */
 		config->vinst_ctrl |= BIT(9);
-- 
2.25.1

