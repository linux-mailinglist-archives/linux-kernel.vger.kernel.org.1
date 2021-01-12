Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65732F3590
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393006AbhALQPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:15:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54798 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392987AbhALQPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:00 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9ZPi086506;
        Tue, 12 Jan 2021 16:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=1dXdaNMkQ9ht1Yl969Ei1/05Yx6TSU8Ts6Eld26isIU=;
 b=fk4VzTQVsbMvG2GKU+A18L9zddMqfm+6T7u4FpAxFs0l7gWtxngJCvUi06leiScaZlHv
 4iqz/rlG3EG63tjWc5OrLDEeo1Yl4iLBkQgZPQnrMEaydqGGdygAjrZeIJT9h8fo6ovi
 bRq+7am3Mepn0M6NNLjkMdcL6dYoAmHao14/mTOY7Z33GDfHt4efDuVUZNIpB4nQ/mJE
 jyPYRjBPIqbn+gcfeQaMQE6w+SZ5i8fFyKpH9npBv7buYc4UC3toVe1OgjLKCmpJrYM1
 kr9ByRcP+kywh1rccZt9o6t0dM6DJk43zshPcmhuHJWQII95SSqhbCE3witkjd2HIICy Pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 360kg1q4xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGA2av094680;
        Tue, 12 Jan 2021 16:13:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 360key12s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:58 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGDwf8019815;
        Tue, 12 Jan 2021 16:13:58 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:57 -0800
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
Subject: [PATCH v2 40/70] fs/binfmt_elf: Use maple tree iterators for fill_files_note()
Date:   Tue, 12 Jan 2021 11:12:10 -0500
Message-Id: <20210112161240.2024684-41-Liam.Howlett@Oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/binfmt_elf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index fa50e8936f5fc..92b67b914bf96 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1609,6 +1609,7 @@ static int fill_files_note(struct memelfnote *note)
 	user_long_t *data;
 	user_long_t *start_end_ofs;
 	char *name_base, *name_curpos;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 	/* *Estimated* file count and total data size needed */
 	count = mm->map_count;
@@ -1633,7 +1634,7 @@ static int fill_files_note(struct memelfnote *note)
 	name_base = name_curpos = ((char *)data) + names_ofs;
 	remaining = size - names_ofs;
 	count = 0;
-	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		struct file *file;
 		const char *filename;
 
-- 
2.28.0

