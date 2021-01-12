Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8B22F3550
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393059AbhALQPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:15:11 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42870 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393043AbhALQPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:10 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9AUv181196;
        Tue, 12 Jan 2021 16:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=W446BaYZjeLXs0PknwR8j9lr6WpCWH9r2L0TDS4cMIs=;
 b=hJmOGlCMLUL7+Aqlb/NJCh+8iICnShe5XcCP8rSfAKzvO2mCsWDWOjAAI1GGCEPk84aR
 HNTw/+zHXdCJ9kHYe7sKwsXgnJ4RcwixerRDGchIXWbLGHaLddnZ6XgWcpWzwZPHiqYx
 6awzBHYVgR27GxgTOC2FdHd6dykmNzrTVCzmcu8cDUvLqxAtTA6C5zIQKECNJ6Sy/6FR
 h3TTE8l7bIwEitCHwBaCx725NeTT8L1z8uu1wsvZ/C3EzwWfG7q9orpCdIClsQ87Ci1v
 oO+wHT4fRV1rg2gOqFJ/QjD+TgJXd7rAhKNNxsVy1eoUVGmL5Ch23ZGXl5J013KtqWT1 Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 360kvjy1nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGBYD4142770;
        Tue, 12 Jan 2021 16:13:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 360ke6rh88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:53 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGDqdK004644;
        Tue, 12 Jan 2021 16:13:52 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:52 -0800
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
Subject: [PATCH v2 37/70] drivers/misc/cxl: Use maple tree iterators for cxl_prefault_vma()
Date:   Tue, 12 Jan 2021 11:12:07 -0500
Message-Id: <20210112161240.2024684-38-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/misc/cxl/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 01153b74334a1..47951b84f2cda 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -313,6 +313,7 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 	struct vm_area_struct *vma;
 	int rc;
 	struct mm_struct *mm;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 	mm = get_mem_context(ctx);
 	if (mm == NULL) {
@@ -322,7 +323,7 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 	}
 
 	mmap_read_lock(mm);
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		for (ea = vma->vm_start; ea < vma->vm_end;
 				ea = next_segment(ea, slb.vsid)) {
 			rc = copro_calculate_slb(mm, ea, &slb);
-- 
2.28.0

