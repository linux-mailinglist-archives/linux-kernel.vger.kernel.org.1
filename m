Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E6A26C9EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgIPTiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgIPTTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:19:35 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5220BC06121D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:57 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l71so1963206pge.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FvuIkxfcV8X2+0uLwFbqf+4k5/cPYO6E0EaPLwQPqlo=;
        b=Luh/b7D+Lf+LfdLUezJT3ubo9A0S1/9jkPh4OV9s9bnQg34RQf9lIOzHtwy58a3ulp
         vFwptqbcVUkLtuoZS4du3f378wGMkGi0BKtlxX4XZ2NayetoyaM5RqqvR7paTs7oTERa
         Vs9sb40BXq+/+v3s83tb1D3a5EyuMew+WHnYpDJDdubbPp6yV1bIeYCNcHoc+TBr6+P4
         y4scvLjawCyis9UHi93mzAfUM3EnrMI69Yl9h+VrYtpRGD3Ie/oeySvn+suNg341hsmG
         N4z1L7vOP0Rxpsq1HMBQnnK1B1QxbwBUmnxPr2FTshphyoB//hlEVe0zi6WUO5TKMRk5
         q6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FvuIkxfcV8X2+0uLwFbqf+4k5/cPYO6E0EaPLwQPqlo=;
        b=jCTOtGjWTe131QXZNjdhi3aycEQpznmYj6glxjwTyM2xxBtW9DU+y1bA7+3uBkh5b9
         PXg73/bTtS0kNbG2kJZzhtIEKrU5mSdZ5UbiFlvvb4uNvDC45xnCy+UHZkW9rVlFBTJ6
         JP/hg2o0b1gBzSn5P+JxMA67dC6R4rOedbbMBysuyUOH/+lAEmmF/XQT5/hPdTGgjtAt
         uiHxvvCkTkCwQrv0OtyaKb5F9nqPbvnMwk9yOL4gnt4MxMRmXRY+zB/1sN+IFhS/3O/B
         8VSqEWpua2qi11rEzIJ1X+MutZwUgPZu11CdETKnyrSEZ2Txey2zw7z6X0WvPiSVcwaW
         Gajw==
X-Gm-Message-State: AOAM533g5jIPW3piLn4g4yrqtT8ag1ByXiW4LJZniEHB4Em/UBQzsPqo
        6va6exyr/Dt5HHwKNZZ4XSUTew==
X-Google-Smtp-Source: ABdhPJzHmItbqylQSYz5sL8T8+nFutv+uJU4HY+dHmj307pl4G6qohVb9lC8U4O6R4MHQjbNdSkUpw==
X-Received: by 2002:a65:685a:: with SMTP id q26mr10324522pgt.28.1600283876831;
        Wed, 16 Sep 2020 12:17:56 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:56 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/16] coresight: etm4x: Fix number of resources check for ETM 4.3 and above
Date:   Wed, 16 Sep 2020 13:17:37 -0600
Message-Id: <20200916191737.4001561-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

The initialisation code checks TRCIDR4 to determine the number of resource
selectors available on the system. Since ETM v 4.3, the value 0 has a
different meaning. This patch takes into account this change.

Cc: stable@vger.kernel.org
Signed-off-by: Mike Leach <mike.leach@linaro.org>
[Removed '.' in patch title, added stable]
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 8 +++++++-
 drivers/hwtracing/coresight/coresight-etm4x.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index b29ad4f7fac2..f5ab13aaecea 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -742,8 +742,14 @@ static void etm4_init_arch_data(void *info)
 	 * The number of resource pairs conveyed by the HW starts at 0, i.e a
 	 * value of 0x0 indicate 1 resource pair, 0x1 indicate two and so on.
 	 * As such add 1 to the value of NUMRSPAIR for a better representation.
+	 *
+	 * For ETM v4.3 and later, 0x0 means 0, and no pairs are available -
+	 * the default TRUE and FALSE resource selectors are omitted.
+	 * Otherwise for values 0x1 and above the number is N + 1 as per v4.2.
 	 */
-	drvdata->nr_resource = BMVAL(etmidr4, 16, 19) + 1;
+	drvdata->nr_resource = BMVAL(etmidr4, 16, 19);
+	if ((drvdata->arch < ETM4X_ARCH_4V3) || (drvdata->nr_resource > 0))
+		drvdata->nr_resource += 1;
 	/*
 	 * NUMSSCC, bits[23:20] the number of single-shot
 	 * comparator control for tracing. Read any status regs as these
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 5259f96fd28a..eefc7371c6c4 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -200,6 +200,9 @@
 /* NS MON (EL3) mode never implemented */
 #define ETM_EXLEVEL_NS_VICTLR_MASK	GENMASK(22, 20)
 
+/* Interpretation of resource numbers change at ETM v4.3 architecture */
+#define ETM4X_ARCH_4V3	0x43
+
 /**
  * struct etmv4_config - configuration information related to an ETMv4
  * @mode:	Controls various modes supported by this ETM.
-- 
2.25.1

