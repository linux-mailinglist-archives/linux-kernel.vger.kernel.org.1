Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A36A1C3DE8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 17:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgEDPAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 11:00:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46826 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbgEDPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:00:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EnCoh024792;
        Mon, 4 May 2020 15:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=hsMzy6wx1/DEdi8suQdgbXWe0Maq85/ZgmlxYBdz/2E=;
 b=WJAcFefZyCtjaUHMoZAZ8J2amgJ79c/i5nPycj0M7U47/tKdAIox7kCo9sAXBqN8v0pf
 Qdw7QAmJgjSU+Ooe6Yl9dhCs/R1IlNJ1eJ4lzQhKr3misdTrE9U/oEukuT4+3SE9HVV6
 75V446d6RBXXGCy4ecWMmCgyhhQfFgh7hMtuEhNo8BNCOScXeh+KGq5VJGmnQpBK5VZz
 3NbYqq38tpin9A/KCUAS57wDKY7XHS19vhpt4NUyX93XweuAlRmSBn5FbTh7v5kMxLpr
 B9ozcwXIjpAwKxCEQSeyTR6C7b/1aqePCDlrh163eHTTAGHxCO3qvmwfXDDCkFtVZsiR Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30s0tm7dkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:00:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElM7o033871;
        Mon, 4 May 2020 15:00:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30sjnaw244-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:00:03 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044F01rW022337;
        Mon, 4 May 2020 15:00:01 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:00:00 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-2 07/13] mm/dpt: Helper functions to map module into a decorated page-table
Date:   Mon,  4 May 2020 16:58:04 +0200
Message-Id: <20200504145810.11882-8-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504145810.11882-1-alexandre.chartre@oracle.com>
References: <20200504145810.11882-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper functions to easily map a module into a decorated page-table.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/dpt.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/dpt.h b/arch/x86/include/asm/dpt.h
index 85d2c5051acb..5a38d97a70a8 100644
--- a/arch/x86/include/asm/dpt.h
+++ b/arch/x86/include/asm/dpt.h
@@ -2,6 +2,7 @@
 #ifndef ARCH_X86_MM_DPT_H
 #define ARCH_X86_MM_DPT_H
 
+#include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/xarray.h>
 
@@ -44,4 +45,24 @@ extern int dpt_map_range(struct dpt *dpt, void *ptr, size_t size,
 			 enum page_table_level level);
 extern int dpt_map(struct dpt *dpt, void *ptr, unsigned long size);
 
+static inline int dpt_map_module(struct dpt *dpt, char *module_name)
+{
+	struct module *module;
+
+	module = find_module(module_name);
+	if (!module)
+		return -ESRCH;
+
+	return dpt_map(dpt, module->core_layout.base, module->core_layout.size);
+}
+
+/*
+ * Copy the memory mapping for the current module. This is defined as a
+ * macro to ensure it is expanded in the module making the call so that
+ * THIS_MODULE has the correct value.
+ */
+#define DPT_MAP_THIS_MODULE(dpt)			\
+	(dpt_map(dpt, THIS_MODULE->core_layout.base,	\
+		 THIS_MODULE->core_layout.size))
+
 #endif
-- 
2.18.2

