Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162D11B5B28
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 14:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgDWMPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 08:15:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2844 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbgDWMPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:15:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A4908958FBB233F2235E;
        Thu, 23 Apr 2020 20:15:12 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 20:15:02 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <hadar.gat@arm.com>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] hwrng: cctrng - Make some symbols static
Date:   Thu, 23 Apr 2020 20:21:21 +0800
Message-ID: <1587644481-38192-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings:

drivers/char/hw_random/cctrng.c:316:6: warning: symbol
'cc_trng_compwork_handler' was not declared. Should it be static?
drivers/char/hw_random/cctrng.c:451:6: warning: symbol
'cc_trng_startwork_handler' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/char/hw_random/cctrng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index e82716c..3ff37a6 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -313,7 +313,7 @@ static void cc_trng_hw_trigger(struct cctrng_drvdata *drvdata)
 	cc_trng_enable_rnd_source(drvdata);
 }
 
-void cc_trng_compwork_handler(struct work_struct *w)
+static void cc_trng_compwork_handler(struct work_struct *w)
 {
 	u32 isr = 0;
 	u32 ehr_valid = 0;
@@ -448,7 +448,7 @@ static irqreturn_t cc_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-void cc_trng_startwork_handler(struct work_struct *w)
+static void cc_trng_startwork_handler(struct work_struct *w)
 {
 	struct cctrng_drvdata *drvdata =
 			container_of(w, struct cctrng_drvdata, startwork);
-- 
2.6.2

