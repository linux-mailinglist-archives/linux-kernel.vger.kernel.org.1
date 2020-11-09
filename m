Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7302ABF0D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbgKIOoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:44:04 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48024 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbgKIOoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:44:03 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EhioX194583;
        Mon, 9 Nov 2020 14:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=eHZrLbVYUZh4CLglYJbimy4Cf1h2wuErP22WKC3JKHk=;
 b=YuDMQdv7oI9Ld8AxbKnmDNB7zvXJDMPe0mxKjeeen2w1Ejkbsrx9lKgjW7JJ6ojpYbd4
 kiRiN9iZl82anYG1Bq38MHxjJJohGeOPYapZOMe9yNVrr255x3KDYIkwSJ9KyCWyNIIf
 1ebaylIJ2BLZIm5hbJTIBnCsLhsK0dsmk4RUCHovkueIFhNo+lrFd3RJtg2Ykh8MLirn
 zIBH+UbZIfOqxLPQe+1I5/lyYu/reDj2QnJqnGJ1CitKoYkhuFAjXuuiClEqGCZ6xqzo
 dAqVjI908/Jyow4AHVYsFkmpzLVTGXpJE2VcrXvCNduJBJo29WOgzmZoqrJETA3S/Qm2 nQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34nkhkp7ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 14:43:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9EemTn174469;
        Mon, 9 Nov 2020 14:43:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34p5fxs2gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 14:43:44 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A9EhgUv031931;
        Mon, 9 Nov 2020 14:43:42 GMT
Received: from linux.nl.oracle.com (/10.175.27.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 06:43:41 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH 20/24] x86/pti: Execute NMI handler on the kernel stack
Date:   Mon,  9 Nov 2020 15:44:21 +0100
Message-Id: <20201109144425.270789-21-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109144425.270789-1-alexandre.chartre@oracle.com>
References: <20201109144425.270789-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a NMI from userland, the kernel is entered and it switches
the stack to the PTI stack which is mapped both in the kernel and in
the user page-table. When executing the NMI handler, switch to the
kernel stack (which is mapped only in the kernel page-table) so that
no kernel data leak to the userland through the stack.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/kernel/nmi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4bc77aaf1303..be0f654c3095 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -506,8 +506,18 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	inc_irq_stat(__nmi_count);
 
-	if (!ignore_nmis)
-		default_do_nmi(regs);
+	if (!ignore_nmis) {
+		if (user_mode(regs)) {
+			/*
+			 * If we come from userland then we are on the
+			 * trampoline stack, switch to the kernel stack
+			 * to execute the NMI handler.
+			 */
+			run_idt(default_do_nmi, regs);
+		} else {
+			default_do_nmi(regs);
+		}
+	}
 
 	idtentry_exit_nmi(regs, irq_state);
 
-- 
2.18.4

