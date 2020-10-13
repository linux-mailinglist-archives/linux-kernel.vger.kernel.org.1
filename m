Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E8728C961
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 09:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390227AbgJMHa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 03:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390018AbgJMHa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 03:30:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AFDC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 00:30:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n6so22400470wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 00:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d1itffo3X+hs/Kx12mE/CckAQ68mnKs9JtFcGt6GmGA=;
        b=fKo8s7aGRbyQ/M1hKfql+Q8iDgL6L07G252DWiGsDX27Px293F5Ek90661OxTtJInI
         Et8G+vGvSGKFDLSrQbZFBwno+kQhC6bvQztaaSvdMznWEWq0xuYtlahIUT4j/Qdg+NQc
         mydgbhDVlNkcvW8DcIvoweMXXP+7NboZ8XphcCmCZLT1wyqmmxL3mu86JcTPcqSLSlLK
         az2rhkDgmtJn4nWqPCOY8ZAJEy/p9h2SZc8/Mb8pL3Hvn8iPA3G37gnWm9kB69KV3cK5
         hkC45e9LrAqR3B+Y9nvBUs8PvoXwiaxA1kGn68tvQxpqIzZ1+31izraYBnZ1d+dt4NPj
         u42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d1itffo3X+hs/Kx12mE/CckAQ68mnKs9JtFcGt6GmGA=;
        b=HjxfG5EF52Tzjnbh83zV/kRsv9Fib1REGcZpOcoxGIpuYNh94lqDVvvYLutIj9sIeI
         uHM6yqEuhDBgujDiGo9O7j5ur0VIxcJQQhXi5JFl0cFYRDB1OmJXtoo/MFuYjTgqUzQf
         jFkfQTlvg5U+D7nrFrWeVsklTPJ2DWaNI+k6B9vvaXo6uGavefLoTIKN6JopvlPY1zih
         fHcv4+bbnYamkqxRdBUzNwcryBpeyuq42M84xDHFLy0/1AuUkqoXYGbALhNGFXFuzsaL
         ULZ8N62LPTX68RgHTASpzV8QTH2PMOyvlO5K4wUCNeQca2pvzlTn2KcCweqE2qySL6yo
         1Ptw==
X-Gm-Message-State: AOAM531ns49Q/W+jfCzX5J5K8giW6i74wltp33xivfamtlBLFIlDOc0z
        9srcQKwuVyxvLQF1CS5SzWeRyw==
X-Google-Smtp-Source: ABdhPJwToXjrL09HlvAznisOXzNoxKEpn+drBc0B0fY4v9mtvl2Qjr6iZLO2MIRsQNf6sU6ThGFUQw==
X-Received: by 2002:adf:e4c4:: with SMTP id v4mr8989706wrm.79.1602574257128;
        Tue, 13 Oct 2020 00:30:57 -0700 (PDT)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id d2sm18051159wrq.34.2020.10.13.00.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 00:30:56 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH next] iommu: intel: don't dereference iommu_device if IOMMU_API is not built
Date:   Tue, 13 Oct 2020 09:30:55 +0200
Message-Id: <20201013073055.11262-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since commit c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units
with no supported address widths") dmar.c needs struct iommu_device to
be selected. We can drop this dependency by not dereferencing struct
iommu_device if IOMMU_API is not selected and by reusing the information
stored in iommu->drhd->ignored instead.

This fixes the following build error when IOMMU_API is not selected:

drivers/iommu/intel/dmar.c: In function ‘free_iommu’:
drivers/iommu/intel/dmar.c:1139:41: error: ‘struct iommu_device’ has no member named ‘ops’
 1139 |  if (intel_iommu_enabled && iommu->iommu.ops) {
                                                ^

Fixes: c40aaaac1018 ("iommu/vt-d: Gracefully handle DMAR units with no supported address widths")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iommu/intel/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 2d70d56d8e0d..404b40af31cb 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1136,7 +1136,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 
 static void free_iommu(struct intel_iommu *iommu)
 {
-	if (intel_iommu_enabled && iommu->iommu.ops) {
+	if (intel_iommu_enabled && !iommu->drhd->ignored) {
 		iommu_device_unregister(&iommu->iommu);
 		iommu_device_sysfs_remove(&iommu->iommu);
 	}
-- 
2.28.0

