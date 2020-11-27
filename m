Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA9C2C6B04
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbgK0RxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732435AbgK0RxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:53:10 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7763BC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:10 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v21so3003067plo.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SEMszfaeuUMfImi2qkZXkG9b/+atgWaOE79vRse18HQ=;
        b=eSYyYpuVToMAOJMzdxtB/W5YpPslDKCRMHpeeEwshv0oxw9TDx6jtOaJspmxtmG2p2
         p/JcJtRiX/ZN2k49u5bSziBPqisCfnoDR7diGAQ0viTuBnR9Dp2H4jSJPf+aSRruef37
         Q+jRFuStTELa21FJpirQ5yyUzYoTAmKvpNKEeufVwovDWJ3HbYs481PoblVTb+22RY24
         S4Rjn9uGNtICzglAHjbPtC2s6093WO4L58GxngwHvNW1zKi06hw1lXrQJa6GtgbsrAYt
         D0Bmc7fdhYWtVuhiuKgYoWVoqXzcHmcpX7j2oI+fUWFemZx48f7ayRLoA54pEk0JRGKH
         FVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEMszfaeuUMfImi2qkZXkG9b/+atgWaOE79vRse18HQ=;
        b=tHU2ahWkzxd6Hfc6HU20lPW4kgK+5iEsOM8+7V9pg+vs+wN1SdJNfA3+FvvR0rlYwp
         y/XUY7fUtkDVUhAR3CG7yvQ652lWtFJNl1eKo3vmftDslWUwfqvIZibO91WCRrn6I0t3
         d0o/efiisgFUWTiDlCYM4hTFe2wCxlTNxZTFY2OjJH9ap26+yLHwFT1wjUHPBXKXUd1Q
         BsHo9KOx4TC8UmZ0DknY6rnNVdPHfUkAbyOpxBVGpZM6rPdE4uHr/nZ2gpYtm7ltYp3T
         hCB6p89FntyB4S/ougMOoAULp5/bPfpac/thvBZ6TYht4ZObw1E+2+7YHhyrdGxR8omo
         /1Dw==
X-Gm-Message-State: AOAM531Hn+ytSvQiZun33ULy+9idcapgOYqDvjpnSIG6aLkYqMSskHm/
        dutwDfiXWsJqOvPynQn+6mOJNQ==
X-Google-Smtp-Source: ABdhPJweg0+K3PYxashlkdKyFMrDzdf4hlRLCU+0F6R8xbMsg6QW9P+w9A0yDxTYr00CCAU4UqcdCw==
X-Received: by 2002:a17:902:8d82:b029:d8:c5e8:9785 with SMTP id v2-20020a1709028d82b02900d8c5e89785mr7925196plo.5.1606499590077;
        Fri, 27 Nov 2020 09:53:10 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:53:09 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] coresight: tmc-etr: Check if page is valid before dma_map_page()
Date:   Fri, 27 Nov 2020 10:52:53 -0700
Message-Id: <20201127175256.1092685-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
References: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Jinlong <jinlmao@codeaurora.org>

alloc_pages_node() return should be checked before calling
dma_map_page() to make sure that valid page is mapped or
else it can lead to aborts as below:

 Unable to handle kernel paging request at virtual address ffffffc008000000
 Mem abort info:
 <snip>...
 pc : __dma_inv_area+0x40/0x58
 lr : dma_direct_map_page+0xd8/0x1c8

 Call trace:
  __dma_inv_area
  tmc_pages_alloc
  tmc_alloc_data_pages
  tmc_alloc_sg_table
  tmc_init_etr_sg_table
  tmc_alloc_etr_buf
  tmc_enable_etr_sink_sysfs
  tmc_enable_etr_sink
  coresight_enable_path
  coresight_enable
  enable_source_store
  dev_attr_store
  sysfs_kf_write

Cc: stable@vger.kernel.org
Fixes: 99443ea19e8b ("coresight: Add generic TMC sg table framework")
Signed-off-by: Mao Jinlong <jinlmao@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 525f0ecc129c..a31a4d7ae25e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -217,6 +217,8 @@ static int tmc_pages_alloc(struct tmc_pages *tmc_pages,
 		} else {
 			page = alloc_pages_node(node,
 						GFP_KERNEL | __GFP_ZERO, 0);
+			if (!page)
+				goto err;
 		}
 		paddr = dma_map_page(real_dev, page, 0, PAGE_SIZE, dir);
 		if (dma_mapping_error(real_dev, paddr))
-- 
2.25.1

