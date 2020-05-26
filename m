Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456EA1D7821
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 14:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgERMJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 08:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgERMJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:09:03 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D14207D8;
        Mon, 18 May 2020 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589803743;
        bh=SEByoyU7zUcqsSozfnjODsKZnvuUk1JfOriPckML+F4=;
        h=From:To:Cc:Subject:Date:From;
        b=l3i7U26etrohomOegVf5fBfK9nF8sMSrRZr9e1n0cdxHeZ4Spq8JggfufDwtUFK6/
         cAujaYLrudSVf4FcCMAL/8TRYSkHDpQJwxLF4ly33rlqD/Ujx5kwHLdsNY4ja4eHSb
         cf93eYsTh/FFxkQ3gvoPNnknZD/0SbtETKejRph0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] ia64: Hide the archdata.iommu field behind generic IOMMU_API
Date:   Mon, 18 May 2020 14:08:54 +0200
Message-Id: <20200518120855.27822-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a generic, kernel wide configuration symbol for enabling the
IOMMU specific bits: CONFIG_IOMMU_API.  Implementations (including
INTEL_IOMMU driver) select it so use it here as well.

This makes the conditional archdata.iommu field consistent with other
platforms and also fixes any compile test builds of other IOMMU drivers,
when INTEL_IOMMU is not selected).

For the case when INTEL_IOMMU and COMPILE_TEST are not selected, this
should create functionally equivalent code/choice.  With COMPILE_TEST
this field could appear if other IOMMU drivers are chosen but
INTEL_IOMMU not.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

See:
https://lore.kernel.org/lkml/202005181412.frC4juFy%25lkp@intel.com/
---
 arch/ia64/include/asm/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/device.h b/arch/ia64/include/asm/device.h
index 410a769ece95..3eb397415381 100644
--- a/arch/ia64/include/asm/device.h
+++ b/arch/ia64/include/asm/device.h
@@ -6,7 +6,7 @@
 #define _ASM_IA64_DEVICE_H
 
 struct dev_archdata {
-#ifdef CONFIG_INTEL_IOMMU
+#ifdef CONFIG_IOMMU_API
 	void *iommu; /* hook for IOMMU specific extension */
 #endif
 };
-- 
2.17.1

