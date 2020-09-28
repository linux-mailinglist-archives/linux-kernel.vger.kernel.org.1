Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFAD27B1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgI1QfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgI1QfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39033C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q123so1541902pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9uBCtknHRVZ5YnORcKUKYFX5Ylh+EACLqKEbj0M9418=;
        b=AlPBzp9R1iGsWkWvsea30Ky4Jf59IpYlVNEppTSV6TglRjfCq5a7ee/tdFR+FATgSC
         /UahVo/hAwOOuBnVwCX7/4N1czOyehEX71/q8UC5X527oiXyG1QwlmH1u9PKJ+46yFp0
         Szb7ViFF0+Jo+82wfVFuaiypgv6HQYG0wHb/MhwNr8WslXoEMpfw4tmFpKWNyqk0LVEn
         O7+lGP8G+eHtd9gepldPpDT/FzhO/B9a7uGgHziEdjMbmhAF98h5lUbct1a6f7oeA6QF
         svhwaD1f0uxniFxcY8PpyXpkMTP9UFBt5cjruXn3ktU4KD4+O+OQYszVB8D1bXAHDsrp
         cb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9uBCtknHRVZ5YnORcKUKYFX5Ylh+EACLqKEbj0M9418=;
        b=VqY/oUXYILFJTz3s/fyJIZQEuX7dzunBwnJsHN+dk7BwX9ksyLKCBgPAYasdHqTZwr
         k0AV5Ow3pcZiV+dYzR3d5QFMJ9UegKClvL17HkURSfqb3ZPGtjwKcfvhlGz8K+jHJU2M
         f0PNI2WYWOpjXi/C5pL/Z2CZOaPa55H/4MEwe24N6541ThrBImFuHl9oxR4kRrPwzK9w
         yslmLRZS0gf4arXXZpL87ylbI/ntjU36+JY6yLgdS+xPYuTXB4HgX9c7s9JhI8M95/cX
         sB4Gn4xK6ZRGqP8rlHTzh6GZgPrAWzQNpclk9vzql1Yjmk/ncSNQlQi3tNaRcy6nrAM/
         pYhQ==
X-Gm-Message-State: AOAM532o+7RadIIAJ/75FijlzYNBL7ygW1hLt/dRFjA2bl0it3S8NMOi
        fTqmxj1ALIM+gagdmt+8iJPxOA==
X-Google-Smtp-Source: ABdhPJz6aKTIfIyMjaMa3S62Vjbum7V1Km03/87+OVuGz5uTmbrdR9pwN1RYvGZ0BVneyop2M5lliA==
X-Received: by 2002:a63:f104:: with SMTP id f4mr1834586pgi.365.1601310917763;
        Mon, 28 Sep 2020 09:35:17 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:17 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/25] coresight: Use IS_ENABLED for CONFIGs that may be modules
Date:   Mon, 28 Sep 2020 10:34:51 -0600
Message-Id: <20200928163513.70169-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Checking for ifdef CONFIG_x fails if CONFIG_x=m.  Use IS_ENABLED
that is true for both built-ins and modules, instead.  Required
when building coresight components as modules.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.h | 2 +-
 drivers/hwtracing/coresight/coresight-priv.h     | 2 +-
 include/linux/coresight.h                        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 015213abe00a..05f89723e282 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -57,7 +57,7 @@ struct etm_event_data {
 	struct list_head * __percpu *path;
 };
 
-#ifdef CONFIG_CORESIGHT
+#if IS_ENABLED(CONFIG_CORESIGHT)
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
 int etm_perf_add_symlink_sink(struct coresight_device *csdev);
 void etm_perf_del_symlink_sink(struct coresight_device *csdev);
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 5fe773c4d6cc..28695e26e5c6 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -166,7 +166,7 @@ int coresight_make_links(struct coresight_device *orig,
 void coresight_remove_links(struct coresight_device *orig,
 			    struct coresight_connection *conn);
 
-#ifdef CONFIG_CORESIGHT_SOURCE_ETM3X
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
 extern int etm_readl_cp14(u32 off, unsigned int *val);
 extern int etm_writel_cp14(u32 off, u32 val);
 #else
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 58fffdecdbfd..3bb738f9a326 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -324,7 +324,7 @@ struct coresight_ops {
 	const struct coresight_ops_ect *ect_ops;
 };
 
-#ifdef CONFIG_CORESIGHT
+#if IS_ENABLED(CONFIG_CORESIGHT)
 extern struct coresight_device *
 coresight_register(struct coresight_desc *desc);
 extern void coresight_unregister(struct coresight_device *csdev);
-- 
2.25.1

