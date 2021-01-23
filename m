Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F41301267
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 03:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbhAWCq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 21:46:58 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:11577 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbhAWCqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 21:46:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611369983; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=eoRl5Yg9+Kk7pQqSSHj/yvwSZ/cQGnqwlmE3BwZXzdY=; b=eXJTisrTBdNWfPhS/oVEdsFAmXywKj+qG1BL3JIf/nUt8Hr0HbUhrjdikEasZNae7MENXyYJ
 9WL6/BsOg39XL28uVDG+vsYt7uYX0OST3Viy9L/7yGvhJ+x5VOaqeNcbsuwF9jSVCHikUJ9G
 gjAymoa3TW2PR7BRLp03rtHaEtI=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 600b8ddfbeacd1a25272eb03 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 23 Jan 2021 02:45:51
 GMT
Sender: subbaram=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D3DFC433CA; Sat, 23 Jan 2021 02:45:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from subbaram-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: subbaram)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA756C433CA;
        Sat, 23 Jan 2021 02:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA756C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=subbaram@codeaurora.org
From:   Subbaraman Narayanamurthy <subbaram@codeaurora.org>
To:     sboyd@kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, collinsd@coreaurora.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: [PATCH] spmi: spmi-pmic-arb: Fix hw_irq overflow
Date:   Fri, 22 Jan 2021 18:45:43 -0800
Message-Id: <1611369943-18685-1-git-send-email-subbaram@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when handling the SPMI summary interrupt, the hw_irq
number is calculated based on SID, Peripheral ID, IRQ index and
APID. This is then passed to irq_find_mapping() to see if a
mapping exists for this hw_irq and if available, invoke the
interrupt handler. Since the IRQ index uses an "int" type, hw_irq
which is of unsigned long data type can take a large value when
SID has its MSB set to 1 and the type conversion happens. Because
of this, irq_find_mapping() returns 0 as there is no mapping
for this hw_irq. This ends up invoking cleanup_irq() as if
the interrupt is spurious whereas it is actually a valid
interrupt. Fix this by using the proper data type (u32) for id.

Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
---
 drivers/spmi/spmi-pmic-arb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index de844b4..bbbd311 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2012-2015, 2017, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2012-2015, 2017, 2021, The Linux Foundation. All rights reserved.
  */
 #include <linux/bitmap.h>
 #include <linux/delay.h>
@@ -505,8 +505,7 @@ static void cleanup_irq(struct spmi_pmic_arb *pmic_arb, u16 apid, int id)
 static void periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
 {
 	unsigned int irq;
-	u32 status;
-	int id;
+	u32 status, id;
 	u8 sid = (pmic_arb->apid_data[apid].ppid >> 8) & 0xF;
 	u8 per = pmic_arb->apid_data[apid].ppid & 0xFF;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

