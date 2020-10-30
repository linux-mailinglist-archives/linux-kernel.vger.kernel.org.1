Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10AA2A0A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgJ3PzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:55:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51012 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgJ3PzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:55:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UFsn7R139214;
        Fri, 30 Oct 2020 15:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=cx76qkqxiV9bt2I+uaEscbVIUvLGOKrK7fug+vlp3FE=;
 b=fHxBB7Nx1sUmuX7TN2ehNDVxxggdvLsjPg1zVD9s3uCkmu+VgzLE+XId3w3DcNkYqg/8
 vlcMXmql+005kePd/0Cy3puHvOQdAiQ97Tuz6FgvJ3Tc1YMzpvf+FQUuVHAEOtrByBFy
 yLL6Ia4vjv0AaPL7BRidSucJQt/YLKTYMHeOmyF/7NDqnuTdHYMkgkRmtyCwHUTcMrgE
 rAnN/b8wmsV0jAH3YcZgDT6zgMlDO3wN63u1vJpJ9p22wc5hFBuktEl5O9uz9w0W9f1i
 3J8ZSzutkbSk9lgxRxpQk6HZtSvUZdghJyYWv6sV8uWnhiW3Ou2Mn5gsVrHoYlWFlwFQ 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34dgm4g1cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 15:55:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UFpYs2010425;
        Fri, 30 Oct 2020 15:55:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
        by userp3030.oracle.com with ESMTP id 34cx70ug65-1;
        Fri, 30 Oct 2020 15:55:02 +0000
From:   john.p.donnelly@oracle.com
To:     linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, andriy.shevchenko@linux.intel.com
Subject: [PATCH 4.14 v2 ] platform/x86: Corrects warning: missing braces around initializer
Date:   Fri, 30 Oct 2020 08:55:01 -0700
Message-Id: <20201030155501.7491-1-john.p.donnelly@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=1 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Donnelly <john.p.donnelly@oracle.com>

The assignment statement of a local variable "struct tp_nvram_state s[2] = {0};
is not valid for all versions of compilers.

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

