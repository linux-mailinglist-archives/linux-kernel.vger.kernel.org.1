Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F69294883
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 08:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395142AbgJUG4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 02:56:12 -0400
Received: from smtp.h3c.com ([60.191.123.50]:10849 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbgJUG4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 02:56:12 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 09L6t8vc026263
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Oct 2020 14:55:08 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 21 Oct 2020 14:55:10 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <megaraidlinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] scsi: megaraid_sas: use spin_lock() in hard IRQ
Date:   Wed, 21 Oct 2020 14:45:02 +0800
Message-ID: <20201021064502.35469-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 09L6t8vc026263
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we already in hard IRQ context when running megasas_isr(), so use
spin_lock() is enough, which is faster than spin_lock_irqsave().

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 2b7e7b5f3..bd186254d 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3977,15 +3977,14 @@ static irqreturn_t megasas_isr(int irq, void *devp)
 {
 	struct megasas_irq_context *irq_context = devp;
 	struct megasas_instance *instance = irq_context->instance;
-	unsigned long flags;
 	irqreturn_t rc;
 
 	if (atomic_read(&instance->fw_reset_no_pci_access))
 		return IRQ_HANDLED;
 
-	spin_lock_irqsave(&instance->hba_lock, flags);
+	spin_lock(&instance->hba_lock);
 	rc = megasas_deplete_reply_queue(instance, DID_OK);
-	spin_unlock_irqrestore(&instance->hba_lock, flags);
+	spin_unlock(&instance->hba_lock);
 
 	return rc;
 }
-- 
2.17.1

