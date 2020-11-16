Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C04A2B464F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgKPOr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:47:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38130 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbgKPOr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:47:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEiGvB190154;
        Mon, 16 Nov 2020 14:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=eHZrLbVYUZh4CLglYJbimy4Cf1h2wuErP22WKC3JKHk=;
 b=aSE9koehE+aE6JuJBMoazn/Rhq76AdX9S+/8yyFf9mcQWCKnXa9+fKXG5FNVGHqBa3zm
 mvUDlFCG6L7S0yzpbDmO7etk+VBszcaZhYmo2agoTd6uHODHVQMDOhIOJ5CTPS8hGLeO
 c9VkyBTNIFkEcMFzy88/evkUqN7BTMvEHredth95b5ATnIS+cP1iXa5svs4dLqRcmlAX
 3Bc78B+48Eyh3VwG73Uf7rVHbJVxg8g0GMVbnTKd3kNicDxYgnGU5aqzF3pzT2A3bB5I
 LzsFidqTmUk9axEu2UGXfyHT6I6IJYMg0as697BuOWRo+eV2j6Q05OOWmmUfDWHlwYqJ Sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34t76kncw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 14:47:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGEjD0J164549;
        Mon, 16 Nov 2020 14:47:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34umcww4d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 14:47:37 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AGElbkB024562;
        Mon, 16 Nov 2020 14:47:37 GMT
Received: from localhost.localdomain (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 06:47:36 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de
Cc:     konrad.wilk@oracle.com, jan.setjeeilers@oracle.com,
        junaids@google.com, oweisse@google.com, rppt@linux.vnet.ibm.com,
        graf@amazon.de, mgross@linux.intel.com, kuzuno@gmail.com,
        alexandre.chartre@oracle.com
Subject: [RFC][PATCH v2 18/21] x86/pti: Execute NMI handler on the kernel stack
Date:   Mon, 16 Nov 2020 15:47:54 +0100
Message-Id: <20201116144757.1920077-19-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160090
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

