Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D0D2A5F41
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgKDIUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgKDIUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:20:11 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61C6C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 00:20:10 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o3so15923667pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 00:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMC7KT98x49skg9kEqjdGQnBbZ+1J2nc85cU6FlABV4=;
        b=eLVcedigA819LViJREK7rebAOBPi5ZCiK03S5hHPFCnzm1u4bNfUTbOa92j03VozK5
         fkJ7YQ+a9VhsMKkQ9GIq1PsApy8JtSxSRq6KVKM9tTK3/PvAJnZB0gwIViVjWxqMomjT
         euxnpguLCL6KBMCKbOL8Cg4i/cuFnYMROPD9/LPV7KkjLL2Jh3fEgY2uXtcL2fWGDaRa
         AGxB4wnaeIEph80WAEBaT8EjvsqoYuuICAY+4NfgKA9rFCkFlwLaYcP70Z52dBcJcg6O
         uQtIsPClTEpcFW51LPax5mPQXc3/cliK//GZWVIEcwAtEGDKAIWm4xK/bX46mRa9GFTK
         Vgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMC7KT98x49skg9kEqjdGQnBbZ+1J2nc85cU6FlABV4=;
        b=rX6AJcC8/ly17y/iE7Pua7h6DzznYQgYJ3Vg3AA5PKHDaQkAj8FlO8twD3vSU24clT
         P7L3C1vkQgWMGi24y8Eo+uGd6KUkfZg29+d6opZLYOYzhGdLXrKLSObMF5Cf1a41yg8G
         znvkHZruKUhUrF/ey9TC8wd4tDUkK3tSZbEpD8xUkL3BoFU2v9n30YUqLjjmYxk8wxBP
         xrYGqzZlU9gEVGeXoOoKi9AEs237kfgjXoi9gYrvu0pMvB/F5Cy2CWlZnM9HJWhFWZjl
         KURRA5fQ1qxd6S14gsYvirrnI0M/5dYturlaJhV1G3VVVkNRTj5dpH5LdNxSXVXaLkJ8
         5nTw==
X-Gm-Message-State: AOAM531aCa3Cjml2hBIv+VaSTDZvnMP0mhfogvqbi+pn+AzqccOdp50H
        pzU4VcBjXx2TDw5zKZCA3c49yAedUks=
X-Google-Smtp-Source: ABdhPJyaqqhYVEHLX70GURN6fXuYYZkMaC6LaYP2ytjcoN7jI9Mzeac0pK0nVMni9MdSllxt28O+Dw==
X-Received: by 2002:a17:90b:1218:: with SMTP id gl24mr3174291pjb.131.1604478010174;
        Wed, 04 Nov 2020 00:20:10 -0800 (PST)
Received: from ZB-PF0YQ8ZU.360buyad.local ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id z7sm969322pjc.41.2020.11.04.00.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 00:20:09 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH] iommu/vt-d: remove redundant variable no_platform_optin
Date:   Wed,  4 Nov 2020 16:19:36 +0800
Message-Id: <20201104081936.2128-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no_platform_optin is redundant with dmar_disabled and it's only used in
platform_optin_force_iommu(), remove it and use dmar_disabled instead.

Meanwhile remove all the dead code in platform_optin_force_iommu().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 drivers/iommu/intel/iommu.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8651f6d4dfa0..a011d1ed63ef 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -180,7 +180,6 @@ static int rwbf_quirk;
  */
 static int force_on = 0;
 int intel_iommu_tboot_noforce;
-static int no_platform_optin;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
 
@@ -440,7 +439,6 @@ static int __init intel_iommu_setup(char *str)
 			pr_info("IOMMU enabled\n");
 		} else if (!strncmp(str, "off", 3)) {
 			dmar_disabled = 1;
-			no_platform_optin = 1;
 			pr_info("IOMMU disabled\n");
 		} else if (!strncmp(str, "igfx_off", 8)) {
 			dmar_map_gfx = 0;
@@ -4810,20 +4808,12 @@ static inline bool has_external_pci(void)
 
 static int __init platform_optin_force_iommu(void)
 {
-	if (!dmar_platform_optin() || no_platform_optin || !has_external_pci())
+	if (!dmar_platform_optin() || dmar_disabled || !has_external_pci())
 		return 0;
 
-	if (no_iommu || dmar_disabled)
+	if (no_iommu)
 		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
 
-	/*
-	 * If Intel-IOMMU is disabled by default, we will apply identity
-	 * map for all devices except those marked as being untrusted.
-	 */
-	if (dmar_disabled)
-		iommu_set_default_passthrough(false);
-
-	dmar_disabled = 0;
 	no_iommu = 0;
 
 	return 1;
-- 
2.25.1

