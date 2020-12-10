Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9C2D6302
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392441AbgLJRGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:06:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35816 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731400AbgLJRFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:05:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGnTsm044409;
        Thu, 10 Dec 2020 17:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=agWKUJMIdmkhfoR9Wm0Fk5qM6zqtsMCROZPU/u1p+8I=;
 b=vX/nkPjrj8rYblAc5yfoxm1VgCpFrcbiw+cIndrtU/ENto4VZAj+z6MhL4XcudCO0fPD
 Y6NY7GW5VHW8E/LYFEQtaUUuVQXgO1hcwyLmFH5SLvsMPeYoJEoHcS8c+3kBCyV/X9fb
 bI09f9shfjbLzhl4MHquMdzC9luO285yoe5/XOZpWwUKBsspjsfKTt7kVmc6uPpzXCbz
 fVX2qXmBpmhpyvxjWlCfaNinJD2oRn4XHa2Sv5zMwErFnX+Zq8Rcz61gucT1bIctU5Ov
 FJ/XxosBw4ndQ63xdnm7iYEJo5VyyG08qgeSXysljOYPeKYxOJWAeqy/2SRSh6BzXgIX Ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35825meh23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:04:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGwvvp080537;
        Thu, 10 Dec 2020 17:04:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 358kywm3af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:52 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BAH4p1I005252;
        Thu, 10 Dec 2020 17:04:51 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:51 -0800
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@google.com>, Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 15/28] mm/mmap: Change vm_brk_flags() to use mm_populate_vma()
Date:   Thu, 10 Dec 2020 12:03:49 -0500
Message-Id: <20201210170402.3468568-16-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=842 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=852 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip searching for the vma to populate after creating it by passing in a pointer.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ec2e92b03f9d1..dc7a742fbe131 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3026,10 +3026,10 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 	// This vma left intentionally blank.
 	mas_walk(&mas);
 	ret = do_brk_flags(&mas, &vma, addr, len, flags);
-	populate = ((mm->def_flags & VM_LOCKED) != 0);
 	mmap_write_unlock(mm);
+	populate = ((mm->def_flags & VM_LOCKED) != 0);
 	if (populate && !ret)
-		mm_populate(addr, len);
+		mm_populate_vma(vma, addr, addr + len);
 	return ret;
 }
 EXPORT_SYMBOL(vm_brk_flags);
-- 
2.28.0

