Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3472A0A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgJ3PwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:52:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48394 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3PwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:52:18 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UFnWGY099062;
        Fri, 30 Oct 2020 15:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=M8PTIODvLNUFHHyfGSAyZPimivloXIZ/HBatAnV1IWE=;
 b=L9dMiBRd08sZBojslzSxCJojLcfCkqRMeUcGhTOm7ZbUGdKshvkNSwpD7iIeKqJhsSxT
 1A7PENGNfmezR61SY/PJl+CEJIgmVATnIsGtwV97/aUgzMPYCf2gDqRH2nFz6DBLj2pM
 gF8P9yQGIkHGed1L4CXkXssu5lRml94GpvknOcE6Klw2Y9FwWnQCAyWyKe+rSi8MOTHv
 jaUUBlnxY44Vus9aDqig2YcpR4H3TG3D/nY0MJ64CiuZvOq3TAQUeDbZ6jum1Lj5VcC4
 MmhKtgJngSU0pqR3hOE+BY1HJSkNG5K5OU/v/vFNEngjOgoHRsAMC9svWDLZt2mCfQab Ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34c9sbahyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 15:52:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UFoEJS080973;
        Fri, 30 Oct 2020 15:52:12 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
        by aserp3020.oracle.com with ESMTP id 34cx61udse-1;
        Fri, 30 Oct 2020 15:52:12 +0000
From:   john.p.donnelly@oracle.com
To:     linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, andriy.shevchenko@linux.intel.com
Subject: [PATCH 4.14 ] platform/x86: Corrects warning: missing braces around initializer
Date:   Fri, 30 Oct 2020 08:52:11 -0700
Message-Id: <20201030155211.7218-1-john.p.donnelly@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Donnelly <john.p.donnelly@oracle.com>

The assignment statement of a local variable "struct tp_nvram_state s[2] = {0}; "
is not valid for all versions of compilers (UEK6 on OL7).

Fixes: 515ded02bc4b ("platform/x86: thinkpad_acpi: initialize tp_nvram_state variable")

Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index ffaaccded34e..c41ac0385304 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2477,7 +2477,7 @@ static void hotkey_compare_and_issue_event(struct tp_nvram_state *oldn,
  */
 static int hotkey_kthread(void *data)
 {
-	struct tp_nvram_state s[2] = { 0 };
+	struct tp_nvram_state s[2];
 	u32 poll_mask, event_mask;
 	unsigned int si, so;
 	unsigned long t;
@@ -2488,6 +2488,8 @@ static int hotkey_kthread(void *data)
 	if (tpacpi_lifecycle == TPACPI_LIFE_EXITING)
 		goto exit;
 
+	memset(&s, 0, sizeof(s));
+
 	set_freezable();
 
 	so = 0;
-- 
2.27.0

