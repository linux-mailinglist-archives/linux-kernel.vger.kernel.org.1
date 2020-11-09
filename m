Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1C2AB6AE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgKILXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:23:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729650AbgKILXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:23:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BFBJ9114136;
        Mon, 9 Nov 2020 11:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=eHZrLbVYUZh4CLglYJbimy4Cf1h2wuErP22WKC3JKHk=;
 b=0Vjh0sAqfz3IIXX0w2Qj2+/z2AJNBJIT6iE2askMIXeMdQ3KMv/pne/arJMJgNws+Aw0
 1nS+l8A0pjDXknU6KjCFhkKFC6yCQxcLCePjNYArKvE7y0hdvzRDqxCxgJLTx2IEvi80
 m+2xyv1xHwWfzZVZbMl4Cc97L7/Q6JS7ViGSdgCYgjE2+fnr2mPNdKA15oKXWvgfE+CY
 EIUwNq6QYU1IGr1RfdcM9w26pQErnKhvUPFJidsP8JuI87azztUbaMXzpE+GgOS+phYG
 2fx248gPzcw9sVbYWYI+7/jV0cqpVwegurDok85VNXcZWQpqKSt4FwD0fj7b101ByMlO 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34p72ebk5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 09 Nov 2020 11:22:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A9BK5fI116644;
        Mon, 9 Nov 2020 11:22:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34p5gv4xpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Nov 2020 11:22:34 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A9BMWl9021880;
        Mon, 9 Nov 2020 11:22:32 GMT
Received: from linux.home (/92.157.91.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Nov 2020 03:22:32 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     "tglx@linutronix.de"@userv0122.oracle.com,
        "mingo@redhat.com"@userv0122.oracle.com,
        "bp@alien8.de"@userv0122.oracle.com,
        "hpa@zytor.com"@userv0122.oracle.com,
        "x86@kernel.org"@userv0122.oracle.com,
        "dave.hansen@linux.intel.com"@userv0122.oracle.com,
        "luto@kernel.org"@userv0122.oracle.com,
        "peterz@infradead.org"@userv0122.oracle.com,
        "linux-kernel@vger.kernel.org"@userv0122.oracle.com,
        "thomas.lendacky@amd.com"@userv0122.oracle.com,
        "jroedel@suse.de"@userv0122.oracle.com
Cc:     "konrad.wilk@oracle.com"@userv0122.oracle.com,
        "jan.setjeeilers@oracle.com"@userv0122.oracle.com,
        "junaids@google.com"@userv0122.oracle.com,
        "oweisse@google.com"@userv0122.oracle.com,
        "rppt@linux.vnet.ibm.com"@userv0122.oracle.com,
        "graf@amazon.de"@userv0122.oracle.com,
        "mgross@linux.intel.com"@userv0122.oracle.com,
        "kuzuno@gmail.com"@userv0122.oracle.com,
        "alexandre.chartre@oracle.com"@userv0122.oracle.com
Subject: [RFC][PATCH 20/24] x86/pti: Execute NMI handler on the kernel stack
Date:   Mon,  9 Nov 2020 12:23:15 +0100
Message-Id: <20201109112319.264511-21-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201109112319.264511-1-alexandre.chartre@oracle.com>
References: <20201109112319.264511-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9799 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011090074
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

