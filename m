Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0072AF3F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgKKOnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgKKOni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:43:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE79C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iTdV0mHZYe+sdGibQPFC9otqc1o9gZ0ZHDnf75vgCEc=; b=mDT5v9BTiuNA96kadN3zbZ8w4z
        hfc0AbEvLUVkGY7Yj8jHTwad9TuVf+2t5vECoL3OLILuCaWZXYOIyj/95ilAW/zJxdsqPlWNF0URV
        bM8CuSGhpzxFiJc3bCaNZBiDsD6PH02Ut5lFi2hC1xPyLwUmVy/VkZvV5HQc4Q7lh75/mvzC3ATh/
        qUsEIrGs7MzqdmGVy2feGxIXCPAL+HzAqa9Umxnf92zBSYanyBrwv1XpNYzXgihex7OPcPBpBPWQg
        QWmEqG+/RM+y9ij+LPAA5FVJjC7Qnq625Tw9qwqKNJ/ETrqazid6X2mSk3hFZz42RdyTWnGDRPCBA
        RZRTrdGw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcrLH-0002jN-TL; Wed, 11 Nov 2020 14:43:25 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kcrLG-006xqT-Ik; Wed, 11 Nov 2020 14:43:22 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86 <x86@kernel.org>, Qian Cai <cai@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/3] iommu/amd: Fix union of bitfields in intcapxt support
Date:   Wed, 11 Nov 2020 14:43:21 +0000
Message-Id: <20201111144322.1659970-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111144322.1659970-1-dwmw2@infradead.org>
References: <87o8k4fcpc.fsf@nanos.tec.linutronix.de>
 <20201111144322.1659970-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

All the bitfields in here are overlaid on top of each other since
they're a union. Change the second u64 to be in a struct so it does
the intended thing.

Fixes: b5c3786ee3704 ("iommu/amd: Use msi_msg shadow structs")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/iommu/amd/init.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 90a8add186e0..a94b96f1e13a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1969,13 +1969,15 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
 
 union intcapxt {
 	u64	capxt;
-	u64	reserved_0		:  2,
-		dest_mode_logical	:  1,
-		reserved_1		:  5,
-		destid_0_23		: 24,
-		vector			:  8,
-		reserved_2		: 16,
-		destid_24_31		:  8;
+	struct {
+		u64	reserved_0		:  2,
+			dest_mode_logical	:  1,
+			reserved_1		:  5,
+			destid_0_23		: 24,
+			vector			:  8,
+			reserved_2		: 16,
+			destid_24_31		:  8;
+	};
 } __attribute__ ((packed));
 
 /*
-- 
2.26.2

