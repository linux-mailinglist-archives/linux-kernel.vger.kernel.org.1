Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAD82F3567
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406300AbhALQRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:17:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46090 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406269AbhALQRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:17:01 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGFcVp007649;
        Tue, 12 Jan 2021 16:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=cvUMqHn+O3qM5VQ3zNFulOfYkZZq1edj4JVDmgDeWIY=;
 b=UH31THU5dEnah58m5BmnaLXMD0vSwL5Xy4nQ3fu7epJXFmfcvwQcZ6rMunM6pPAy7vXD
 GPxIMa51K8b/D/OMbviiopqmjvmCVElKjk7xV+b1jYs5hr/3M8IH29wiUsNyTKFCaC8+
 1asK9zz+RYoBDIroUC4SRrtZTJrHz/VyztFokOUAArWA81xi0C0TwNmzyaGypEhOKSLl
 4z0GCfV4Xa8NG4DE2pAXYC6x3sd9D3FAERjRB7eWXl3RECcSyC/GkI/9Vwvtheqo2+wd
 cNRpcjlMPOTfygcUhIfQ9ruMzkpVSu2pcf9yM/5XkeKAfnqK7BJFDkAYkNSeY0ZeWgRz 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 360kvjy236-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:16:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGBYD9142770;
        Tue, 12 Jan 2021 16:14:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 360ke6rhgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:01 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGDx1p030313;
        Tue, 12 Jan 2021 16:13:59 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:58 -0800
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
Subject: [PATCH v2 41/70] fs/coredump: Use maple tree iterators in place of linked list
Date:   Tue, 12 Jan 2021 11:12:11 -0500
Message-Id: <20210112161240.2024684-42-Liam.Howlett@Oracle.com>
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
 engine=8.12.0-2009150000 definitions=main-2101120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/coredump.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index c6acfc694f658..a69f281a08afb 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1040,10 +1040,10 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 	return vma->vm_end - vma->vm_start;
 }
 
-static struct vm_area_struct *first_vma(struct task_struct *tsk,
+static struct vm_area_struct *first_vma(struct mm_struct *mm,
 					struct vm_area_struct *gate_vma)
 {
-	struct vm_area_struct *ret = tsk->mm->mmap;
+	struct vm_area_struct *ret = find_vma(mm, 0);
 
 	if (ret)
 		return ret;
@@ -1054,12 +1054,13 @@ static struct vm_area_struct *first_vma(struct task_struct *tsk,
  * Helper function for iterating across a vma list.  It ensures that the caller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
+static struct vm_area_struct *next_vma(struct mm_struct *mm,
+				       struct vm_area_struct *this_vma,
 				       struct vm_area_struct *gate_vma)
 {
 	struct vm_area_struct *ret;
 
-	ret = this_vma->vm_next;
+	ret = vma_next(mm, this_vma);
 	if (ret)
 		return ret;
 	if (this_vma == gate_vma)
@@ -1097,8 +1098,8 @@ int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
 		return -ENOMEM;
 	}
 
-	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
-			vma = next_vma(vma, gate_vma), i++) {
+	for (i = 0, vma = first_vma(mm, gate_vma); vma != NULL;
+			vma = next_vma(mm, vma, gate_vma), i++) {
 		struct core_vma_metadata *m = (*vma_meta) + i;
 
 		m->start = vma->vm_start;
-- 
2.28.0

