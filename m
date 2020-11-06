Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652FE2A8CD2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgKFC2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgKFC2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:28:40 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591A6C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:28:40 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id h6so2780954pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eyEqMGIHRnKPe3xHe7UousaiWzXJGRfcAUx/vMsQuIw=;
        b=W3FxgVa1m5WnbyCCyqmcTeUkhbF+QyNq5HZj8oSSBG51RGuK+z94BVDoH1loLaMRRl
         emr2UkfgxEO3RcNiLB5dB9uOZyXirNPYVQd6ph42FpVVC8gdsT5NUweyJo3b5D1FyF/G
         +xF10KL7tO8PQN9qDc+iKGBN/FSzht6gcEiG8Z6r6dI70bx0/PqIJvgG4J+KtPvYIcpE
         P1gb84HiYq7uxxf1v2rYicDNub4oKpHfZskY6jvRe9HmGWinLaVZVBxuygvG0M558oje
         EJ26GNLzzAbHm6MzCymWeVQxVsb69i5q/yIlgL1Ueegb9byDe8yzqoVAb6lboGyI2RYA
         n1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyEqMGIHRnKPe3xHe7UousaiWzXJGRfcAUx/vMsQuIw=;
        b=ZHdlkO80/aWBTNj2V/58FduYj7zc0zz9aPzAaL5ZkBl9BmwDB0cTQd4FmKn7b+nH0v
         ADHong9yA7rRx0dkmSqe5OidPpTbP0MwqiZzSTR9mcPspKYM2Yy8v0EiaNk81NKx+5yD
         dsn5XpkQZ0Vv1jPcKokOuJR7pxjB7aYxZ0Azhd2fFzs1disUCyxp6qAm+9clw5kNcPQv
         CjpVmZ3/7GtQ9LOOtxzk+bLXWb26QPvJ1GpnFFJWCzW4kpJeSHFusZybbDC3Xi92TFXC
         +CG6U7e9Tl9aA05ycTX4w83JcuoRtIUpRXDgVopUi4/bdAH0O2YI6FJOPF3UvVdEh6uj
         b6lg==
X-Gm-Message-State: AOAM530xID+vKlNX23yispg32o+QTzau15ewS7V9TaObFaVttbIANlBH
        qOy0y85zdXk/9horK2FzuSQYMQ==
X-Google-Smtp-Source: ABdhPJxI2+dKRxtHxmHOTSrUzZMu1zXt13l3GwZK4faUutL0L8VBwahJNyBePABLt1MktehexZqhuw==
X-Received: by 2002:a17:90a:43c6:: with SMTP id r64mr11402pjg.128.1604629719929;
        Thu, 05 Nov 2020 18:28:39 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:39 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 14/27] mmc: sdhci-uhs2: skip signal_voltage_switch()
Date:   Fri,  6 Nov 2020 11:27:13 +0900
Message-Id: <20201106022726.19831-15-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For UHS2, the signal voltage is supplied by vdd2 which is already 1.8v,
so no voltage switch required.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 2bf78cc4e9ed..1eca89359351 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -178,6 +178,29 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
 
+/*****************************************************************************\
+ *                                                                           *
+ * MMC callbacks                                                             *
+ *                                                                           *
+\*****************************************************************************/
+
+static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
+						  struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	/*
+	 * For UHS2, the signal voltage is supplied by vdd2 which is
+	 * already 1.8v so no voltage switch required.
+	 */
+        if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+             host->version >= SDHCI_SPEC_400 &&
+             host->mmc->flags & MMC_UHS2_SUPPORT)
+                return 0;
+
+	return sdhci_start_signal_voltage_switch(mmc, ios);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -186,6 +209,9 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
 
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
+	host->mmc_host_ops.start_signal_voltage_switch =
+		sdhci_uhs2_start_signal_voltage_switch;
+
 	return 0;
 }
 
-- 
2.28.0

