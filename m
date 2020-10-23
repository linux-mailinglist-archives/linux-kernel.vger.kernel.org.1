Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429EF297640
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbgJWR5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:57:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43244 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754021AbgJWR5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:57:02 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09NHtQfR016737;
        Fri, 23 Oct 2020 17:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=4zxd3ptZdEcqBmIGvpJr2OlJGLs4SbYdy4/wlWqVbZs=;
 b=S98QTqRCOxVIj3y5/hYWqGZ+hW7k0txwjW/FYlyGPD3Co6um7sp9UpMQZE7HWSYvMCSY
 chCYH/YtcuqcNQ9/7CzmNqDswtR93x0nVU4YxXIVrJUOI2kgLN5PzcSICkIS82xgzwEw
 5eaTNAVXTVbs+fjqebVvjFADFFxKs4qOX9+A9AfR+0FUSgJxNdsZ8kChE7AMGiJFU9rD
 zM1YaCbNfKKy/TkWGCUzGI5qDYsIQlA3bNHpBDYzy/iQHGVdaKNWBCCy2YtpJbwhSj5V
 FTa2E9bnKZlC6YkZvajQMvAmYclGGkxJXcAoBRXT93j0Uup34UfQQHuAC5PrOOVKI0Rj tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 347p4bcgvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Oct 2020 17:56:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09NHeBNu044162;
        Fri, 23 Oct 2020 17:56:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34ak1babg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Oct 2020 17:56:41 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09NHudhe005487;
        Fri, 23 Oct 2020 17:56:39 GMT
Received: from concerto.us.oracle.com (/10.65.191.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 23 Oct 2020 10:56:38 -0700
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     jannh@google.com, hch@infradead.org, catalin.marinas@arm.com,
        davem@davemloft.net, akpm@linux-foundation.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, anthony.yznaga@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH] sparc64: Use arch_validate_flags() to validate ADI flag
Date:   Fri, 23 Oct 2020 11:56:11 -0600
Message-Id: <20201023175611.12819-1-khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9783 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=912 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9783 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=911 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When userspace calls mprotect() to enable ADI on an address range,
do_mprotect_pkey() calls arch_validate_prot() to validate new
protection flags. arch_validate_prot() for sparc looks at the first
VMA associated with address range to verify if ADI can indeed be
enabled on this address range. This has two issues - (1) Address
range might cover multiple VMAs while arch_validate_prot() looks at
only the first VMA, (2) arch_validate_prot() peeks at VMA without
holding mmap lock which can result in race condition.

arch_validate_flags() from commit c462ac288f2c ("mm: Introduce
arch_validate_flags()") allows for VMA flags to be validated for all
VMAs that cover the address range given by user while holding mmap
lock. This patch updates sparc code to move the VMA check from
arch_validate_prot() to arch_validate_flags() to fix above two
issues.

Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 arch/sparc/include/asm/mman.h | 54 +++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
index f94532f25db1..274217e7ed70 100644
--- a/arch/sparc/include/asm/mman.h
+++ b/arch/sparc/include/asm/mman.h
@@ -57,35 +57,39 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
 {
 	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_ADI))
 		return 0;
-	if (prot & PROT_ADI) {
-		if (!adi_capable())
-			return 0;
+	return 1;
+}
 
-		if (addr) {
-			struct vm_area_struct *vma;
+#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
+/* arch_validate_flags() - Ensure combination of flags is valid for a
+ *	VMA.
+ */
+static inline bool arch_validate_flags(unsigned long vm_flags)
+{
+	/* If ADI is being enabled on this VMA, check for ADI
+	 * capability on the platform and ensure VMA is suitable
+	 * for ADI
+	 */
+	if (vm_flags & VM_SPARC_ADI) {
+		if (!adi_capable())
+			return false;
 
-			vma = find_vma(current->mm, addr);
-			if (vma) {
-				/* ADI can not be enabled on PFN
-				 * mapped pages
-				 */
-				if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
-					return 0;
+		/* ADI can not be enabled on PFN mapped pages */
+		if (vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
+			return false;
 
-				/* Mergeable pages can become unmergeable
-				 * if ADI is enabled on them even if they
-				 * have identical data on them. This can be
-				 * because ADI enabled pages with identical
-				 * data may still not have identical ADI
-				 * tags on them. Disallow ADI on mergeable
-				 * pages.
-				 */
-				if (vma->vm_flags & VM_MERGEABLE)
-					return 0;
-			}
-		}
+		/* Mergeable pages can become unmergeable
+		 * if ADI is enabled on them even if they
+		 * have identical data on them. This can be
+		 * because ADI enabled pages with identical
+		 * data may still not have identical ADI
+		 * tags on them. Disallow ADI on mergeable
+		 * pages.
+		 */
+		if (vm_flags & VM_MERGEABLE)
+			return false;
 	}
-	return 1;
+	return true;
 }
 #endif /* CONFIG_SPARC64 */
 
-- 
2.25.1

