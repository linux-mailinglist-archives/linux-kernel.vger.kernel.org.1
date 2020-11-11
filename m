Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DA42AF3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgKKOnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgKKOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:43:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE672C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=guPgz0TNY7eqTaXDEackans8P8uyII3aajuZ4DGtNlw=; b=jJ8ICM1W/FW2tjHHgA2ovRoOOP
        pEKBf6s289gSs8azl3MQJqRQmcWzoGOKWroQ8di+7AbOFFdiFNdzKjChhPV5C37+tjZgLOETI+tHB
        608Oa617kI4s0/azJxVDtEouVXZNeVpmWG8Uukbap4ladiSQSQyz/rRjhHmxegJ0U0gy6KLZHJxKz
        vB38ed3+jvnqwTo1bgrMSoA/EoHjO5XsJN4UZtWYRuiFA/sr1e/63q2147xxAl5c/hwnfXFV6Q8dV
        /AkBzNP3y89XgCn99k0yKP0Zp5RonXkVaSfJ1IEKIOMH2JfrqV8/f9iue5WEsqaEpUYI32ojx7z0O
        CLLYxyuQ==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcrLH-0002j1-91; Wed, 11 Nov 2020 14:43:25 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kcrLG-006xqR-II; Wed, 11 Nov 2020 14:43:22 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86 <x86@kernel.org>, Qian Cai <cai@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/3] iommu/amd: Don't register interrupt remapping irqdomain when IR is disabled
Date:   Wed, 11 Nov 2020 14:43:20 +0000
Message-Id: <20201111144322.1659970-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <87o8k4fcpc.fsf@nanos.tec.linutronix.de>
References: <87o8k4fcpc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

This was potentially allowing I/OAPIC and MSI interrupts to be parented
in the IOMMU IR domain even when IR was disabled. Don't do that.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/iommu/amd/init.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 263670d36fed..90a8add186e0 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1601,9 +1601,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	if (ret)
 		return ret;
 
-	ret = amd_iommu_create_irq_domain(iommu);
-	if (ret)
-		return ret;
+	if (amd_iommu_irq_remap) {
+		ret = amd_iommu_create_irq_domain(iommu);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Make sure IOMMU is not considered to translate itself. The IVRS
-- 
2.26.2

