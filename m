Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FAC2A5F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgKDIPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgKDIPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:15:07 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FECC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 00:15:07 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t6so9917843plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 00:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rXpZj9JEbKY4eaJISBKEtY6mg37iINmNheRvWpDXMms=;
        b=mBIF++twAozP6cDRdtp0uDdxaaaMGEnQgmAALvspsxzLLXxZc1Gjr7ZptfxzzRNFiV
         j7zWuljPMQT3rltcIz96394euUdSBIIoB9hx6oR3icOj5fI2lpaV77uU+n4SbOt/M+P4
         cQgbinZFYjASF1Qh2OoWauTtcJx58M+azyFPi0UlMjcHXf5t0S4t1yiySzh2m3F5WPfv
         z01NAJCYi1WN5WrBPe7T7BDs5H3pn94q9ZYvhi+4JPYByVJiT1CGMeMq80Qk81UqXmEy
         mrJjWOnPvdMN2p1C6sFJNHyuCMvG1AXyHKES3+1XV0uGM4fHHQxhLkayTb4qQPkpBBhD
         sC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rXpZj9JEbKY4eaJISBKEtY6mg37iINmNheRvWpDXMms=;
        b=hJ3U4JuMRaA0sHgTOjTZS6fU8WrdB3HKiDO1l9Tml409ONVRDLVV0RIWClYal9qJFA
         p5g9iqPhKQfIzO9sPDCr4lJpmrsob6E2Y90wAXpCtkQHXjAzHJnf9wFYuyZa+s9Yjy7i
         tlChpIgCZ9dvQ7mOHxqNS6pIVIYu3alnV/qYLKQZjAJIylmgSjRUyzruQyUIhyyaQBLm
         aGHf3927RdjffhlcZTbr41LYw2vPn6NRdwPKTa7At7s24Lj1YV6LPth5HV81wm7s1WOO
         LuHfAojKbY9Ag9nN9oT0GOisgwRzm2wXs+xblG6gfZMQOHLa9DsIbmD/wj+xNuJ3RDF7
         14RQ==
X-Gm-Message-State: AOAM530xiz/cSbxv8VHIcqheyLaElFyExPYezZ9Ce4NLhTWExA3F19p1
        e9Vm30wPHco0rcJbY6lMOz7GaeEFekg=
X-Google-Smtp-Source: ABdhPJxp6SYKXh78t5jW48OsYnMC46cUl8/HoaKRhgBKgm9SQlvWxQJL8/WBBRNZfF2IlhOoegL7Ng==
X-Received: by 2002:a17:902:143:b029:d2:564a:5de8 with SMTP id 61-20020a1709020143b02900d2564a5de8mr28680943plb.74.1604477706645;
        Wed, 04 Nov 2020 00:15:06 -0800 (PST)
Received: from ZB-PF0YQ8ZU.360buyad.local ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id 136sm1493505pfa.132.2020.11.04.00.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 00:15:05 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ning.sun@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, jroedel@suse.de,
        tboot-devel@lists.sourceforge.net,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH] iommu/vt-d: avoid unnecessory panic if iommu init fail in tboot
Date:   Wed,  4 Nov 2020 16:14:38 +0800
Message-Id: <20201104081438.2075-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"intel_iommu=off" command line is used to disable iommu and iommu is force
enabled in a tboot system. Meanwhile "intel_iommu=tboot_noforce,off"
could be used to force disable iommu in tboot for better performance.

By default kernel should panic if iommu init fail in tboot for security
reason, but it's unnecessory if we use "intel_iommu=tboot_noforce,off".

Fix it by return 0 in tboot_force_iommu() so that force_on is not set.

Fixes: 7304e8f28bb2 ("iommu/vt-d: Correctly disable Intel IOMMU force on")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 arch/x86/kernel/tboot.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 992fb1415c0f..9fd4d162b331 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -511,12 +511,9 @@ struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
 
 int tboot_force_iommu(void)
 {
-	if (!tboot_enabled())
+	if (!tboot_enabled() || intel_iommu_tboot_noforce)
 		return 0;
 
-	if (intel_iommu_tboot_noforce)
-		return 1;
-
 	if (no_iommu || swiotlb || dmar_disabled)
 		pr_warn("Forcing Intel-IOMMU to enabled\n");
 
-- 
2.25.1

