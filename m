Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC832F358E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406693AbhALQUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:20:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35088 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392994AbhALQPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGDn4M162430;
        Tue, 12 Jan 2021 16:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=efm5Qo8sMnfNkUEZI2BtdTwiszHBoNWwLnT4vdpoihU=;
 b=OhnKnJ0HSlqLrhLEWr+C5AJsf+6v3B6rJs7nP/9OdjfWtxf+wVoj+y468kJ8HDZihkEe
 Gjn65QhYtn33Lsa38bUiiqpd3R1LSy6EcaIHC7/AeFognmrBZTVDDvHeXTud7zAJ8bdn
 icdf6AXyh3Pb3Mp917RcuRyoOaGk0kETIcT4yaf6Oi2R5YVMtjDoGmWr9opes9m/ythw
 eK3ZFyhsoZpacLSnvEiMesXE7/2Pazi9XWVJALNHtNHRAiS2ZmBFrAppz3Fmchgaw8Om
 7qou/7lai/OtoyxcAuurbxWfFO4uaKhz3zp3IwvR2F6Cr6vymYKrPby9lwxARqnjuCzo tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 360kcyq5fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGA3if094766;
        Tue, 12 Jan 2021 16:13:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 360key12rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:58 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGDuvN030282;
        Tue, 12 Jan 2021 16:13:56 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:55 -0800
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
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 39/70] drivers/tee/optee: Use maple tree iterators for __check_mem_type()
Date:   Tue, 12 Jan 2021 11:12:09 -0500
Message-Id: <20210112161240.2024684-40-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/tee/optee/call.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index c981757ba0d40..94acf379eaeeb 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -545,12 +545,17 @@ static bool is_normal_memory(pgprot_t p)
 
 static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
 {
-	while (vma && is_normal_memory(vma->vm_page_prot)) {
-		if (vma->vm_end >= end)
-			return 0;
-		vma = vma->vm_next;
+	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_start, vma->vm_start);
+
+
+	mas_for_each(&mas, vma, end) {
+		if (!is_normal_memory(vma->vm_page_prot))
+		    break;
 	}
 
+	if (!vma)
+		return 0;
+
 	return -EINVAL;
 }
 
-- 
2.28.0

