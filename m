Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E15C2AD049
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgKJHUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgKJHUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:20:10 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798AFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 23:20:10 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id i13so4604558pgm.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 23:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6nP9JdNbvB32WvH3g9vlgcvuC9Z9huJ+Sj31cT5K9U=;
        b=mzfiMPb0952EhsBRXCBhANIHZUUVzD+DJ7SWwYeXLAfPahkfmqZ76+tD6RINHgSjux
         BjIaNAkQls5BsPHiiwfOg3RUP/U1l0MdZbYeZhMSuxyhD3LraHbdN4bnG9/PkQwfRTbJ
         /0TCQ55iA0i5+hiV64uDBRrYEqwN2Lrfgge2q5Hztu41rCZaSe9OzRAhZ36ckNQ9D1S6
         LZwOK58ye6H8y5tgSs1A4DmGMagGP7uyp5m8bUXfVIaKQtpSU5BwO7KTNvMwtFOH2b9k
         xevsT5MJnCtjv2pk0StlIXWCXS0Tg6pVnwYnsd0ZWh52p77iJQJDymiEw98Gvbq/3xoO
         Lr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6nP9JdNbvB32WvH3g9vlgcvuC9Z9huJ+Sj31cT5K9U=;
        b=RsaY0fQOrrGR9+BPxgR3Zt9LTWgvCUbBBx11HNHz6OWNz7ASn68v9ZMiTbprzUZMLo
         jnOaT+JdgB3V+sB47pQNIBLfBQmD+2vWHx59onQmrsAWTN9dZ0s5r5JhEEuWeyXFhqL2
         4CdBXkwWkHtRHyOBygnP+8zoYkxevrkduE7eThYfPJX/NNYMNtW8d+Mhys0XkhVyjhWi
         mKBJubYiVuKs3pXnuNg9b/44NQWvv1IxHGfBdXqSnXeVMdD+vCaElrKXGX4M4Ehq2ndX
         0hAmqrxyz7/zqDVKUeESxN95y5QtmuuWqp73Ev3Z8pGWVp04RoHg25UhgNt0kwmK285Z
         HT+w==
X-Gm-Message-State: AOAM533FlMDGdcQp40VipubLKb7DeWjs+yo4Ql0Nw+NGs+L7F4x0F/4U
        CcBcdWkM9S+05/DVNSltI6ynhu0+zHE=
X-Google-Smtp-Source: ABdhPJygL/bvlUm3EQiP4+xf7MRcSwyrR18UTDKygf+vM0MyMNltVMw/5wtlEOk7efvGOhhJccDmuQ==
X-Received: by 2002:a63:1d15:: with SMTP id d21mr16092820pgd.433.1604992809793;
        Mon, 09 Nov 2020 23:20:09 -0800 (PST)
Received: from ZB-PF0YQ8ZU.360buyad.local ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id n27sm13552401pfq.59.2020.11.09.23.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 23:20:09 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ning.sun@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org,
        tboot-devel@lists.sourceforge.net,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH v2] iommu/vt-d: avoid unnecessory panic if iommu init fail in tboot system
Date:   Tue, 10 Nov 2020 15:19:08 +0800
Message-Id: <20201110071908.3133-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"intel_iommu=off" command line is used to disable iommu but iommu is force
enabled in a tboot system for security reason.

However for better performance on high speed network device, a new option
"intel_iommu=tboot_noforce" is introduced to disable the force on.

By default kernel should panic if iommu init fail in tboot for security
reason, but it's unnecessory if we use "intel_iommu=tboot_noforce,off".

Fix the code setting force_on and move intel_iommu_tboot_noforce
from tboot code to intel iommu code.

Fixes: 7304e8f28bb2 ("iommu/vt-d: Correctly disable Intel IOMMU force on")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
v2: move ckeck of intel_iommu_tboot_noforce into iommu code per Baolu.

 arch/x86/kernel/tboot.c     | 3 ---
 drivers/iommu/intel/iommu.c | 5 +++--
 include/linux/intel-iommu.h | 1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 992fb14..420be87 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -514,9 +514,6 @@ int tboot_force_iommu(void)
 	if (!tboot_enabled())
 		return 0;
 
-	if (intel_iommu_tboot_noforce)
-		return 1;
-
 	if (no_iommu || swiotlb || dmar_disabled)
 		pr_warn("Forcing Intel-IOMMU to enabled\n");
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1b1ca63..4d9b298 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -179,7 +179,7 @@ static inline unsigned long virt_to_dma_pfn(void *p)
  * (used when kernel is launched w/ TXT)
  */
 static int force_on = 0;
-int intel_iommu_tboot_noforce;
+static int intel_iommu_tboot_noforce;
 static int no_platform_optin;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
@@ -4885,7 +4885,8 @@ int __init intel_iommu_init(void)
 	 * Intel IOMMU is required for a TXT/tboot launch or platform
 	 * opt in, so enforce that.
 	 */
-	force_on = tboot_force_iommu() || platform_optin_force_iommu();
+	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
+		    platform_optin_force_iommu();
 
 	if (iommu_init_mempool()) {
 		if (force_on)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index fbf5b3e..d956987 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -798,7 +798,6 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
-extern int intel_iommu_tboot_noforce;
 extern int intel_iommu_gfx_mapped;
 #else
 static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
-- 
1.8.3.1

