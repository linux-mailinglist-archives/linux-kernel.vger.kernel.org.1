Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82F12953E6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505838AbgJUVMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:12:34 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:55576 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2505830AbgJUVMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:12:33 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ACA014017F;
        Wed, 21 Oct 2020 21:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603314752; bh=d1zs99Yld9s2RHCZmSsagEGcX6j+DDeOamZ2x71qpRA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZSInftFpwvUMRUx14/xl4CsFWgoK19XF47WJ2gpENTe3BXSluldHFCTqiiWTGqifc
         r9JEn/RcdaQFlyud9jEIhz3s9mwxHCoaG78fpi6cgJCBICdDP3HILm7rVeLFDJ18be
         i2QpHvQpz6nHoPp10EjBaTpFS5pA82yvi6L8DYZkH8AmbwuBwFb8LkPQSP5UXJRkkv
         YapIYIzqnclsEV2NlQQrq0RV3M0LKS148z9CXUYJI+La1E+aD1LlSovWJVDOh5a2Oy
         UTQbeB2y7cyVATYP0fRW8bRj7HyLLMmsDNUmJME6scwPA+CI2LeqsvX/Qx1ahGzO+i
         Q7BSLHyUn+1og==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id D44A8A01F0;
        Wed, 21 Oct 2020 21:12:28 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARC: bitops: Remove unecessary operation and value
Date:   Wed, 21 Oct 2020 23:12:20 +0200
Message-Id: <21124fbdd2ebfe150cc750f673a31e89d6fe5752.1603314740.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 1-bit shift rotation to the left on x variable located on
4   last if statement can be removed because the computed value is will
not be used afront.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 arch/arc/include/asm/bitops.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index 50eb3f6..8cddddc 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -297,10 +297,8 @@ static inline int constant_fls(unsigned int x)
 		x <<= 2;
 		r -= 2;
 	}
-	if (!(x & 0x80000000u)) {
-		x <<= 1;
+	if (!(x & 0x80000000u))
 		r -= 1;
-	}
 	return r;
 }
 
-- 
2.7.4

