Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9BE29FFF4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgJ3I3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:29:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53314 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3I3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:29:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09U8JrDm005865;
        Fri, 30 Oct 2020 08:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=FOz9fxnXNFDQ9uYTgOlDFMUYZpfrBtBXNoe2cGNxUck=;
 b=pTdu12sVApjNX2MnJT38kl+w9pYgtMNFMS0z2NEUVv+ufsjTambVrCvwz00irvA7kd+0
 phm8A80xAhSB/K+ZnWRZF3u2EzFSjEGQ1fa/iSoa1ZjRJ0NqtH3qsSaywwUeIWkhUCnr
 NInPxNcTURSl776lvD8OSGXi72ADFpI1DFJq9Xf7Jo7yd/Oy/3uyRR59+BDW5NM75dlT
 5dpZR6sN0F3qLoWT7Ct/Ch4sgvI4/+iyPQdeaEnyA6Qyq0pV2fd3LlVyoc8AlJjllxOt
 mesuCO/NB/kOJG8STg8deUlD1nm+FH3oKXjFo02DpMWP0AsfNNwCeYnIWUqPucb6zoU5 PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34cc7m8het-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 08:29:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09U8QRKn072572;
        Fri, 30 Oct 2020 08:27:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34cx1u6nk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Oct 2020 08:27:02 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09U8R1Yk031309;
        Fri, 30 Oct 2020 08:27:01 GMT
Received: from ban25x6uut24.us.oracle.com (/10.153.73.24)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Oct 2020 01:27:01 -0700
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, lingshan.zhu@intel.com
Cc:     joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] vhost-vdpa: fix page pinning leakage in error path (rework)
Date:   Fri, 30 Oct 2020 03:45:44 -0400
Message-Id: <1604043944-4897-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com>
References: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=2 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=2
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinned pages are not properly accounted particularly when
mapping error occurs on IOTLB update. Clean up dangling
pinned pages for the error path.

The memory usage for bookkeeping pinned pages is reverted
to what it was before: only one single free page is needed.
This helps reduce the host memory demand for VM with a large
amount of memory, or in the situation where host is running
short of free memory.

Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vhost/vdpa.c | 64 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index b6d9016..8da8558 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -560,6 +560,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 
 	if (r)
 		vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
+	else
+		atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
 
 	return r;
 }
@@ -591,14 +593,16 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
-	unsigned long locked, lock_limit, pinned, i;
+	unsigned long lock_limit, sz2pin, nchunks, i;
 	u64 iova = msg->iova;
+	long pinned;
 	int ret = 0;
 
 	if (vhost_iotlb_itree_first(iotlb, msg->iova,
 				    msg->iova + msg->size - 1))
 		return -EEXIST;
 
+	/* Limit the use of memory for bookkeeping */
 	page_list = (struct page **) __get_free_page(GFP_KERNEL);
 	if (!page_list)
 		return -ENOMEM;
@@ -607,52 +611,64 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 		gup_flags |= FOLL_WRITE;
 
 	npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK)) >> PAGE_SHIFT;
-	if (!npages)
-		return -EINVAL;
+	if (!npages) {
+		ret = -EINVAL;
+		goto free;
+	}
 
 	mmap_read_lock(dev->mm);
 
-	locked = atomic64_add_return(npages, &dev->mm->pinned_vm);
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-
-	if (locked > lock_limit) {
+	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
 		ret = -ENOMEM;
-		goto out;
+		goto unlock;
 	}
 
 	cur_base = msg->uaddr & PAGE_MASK;
 	iova &= PAGE_MASK;
+	nchunks = 0;
 
 	while (npages) {
-		pinned = min_t(unsigned long, npages, list_size);
-		ret = pin_user_pages(cur_base, pinned,
-				     gup_flags, page_list, NULL);
-		if (ret != pinned)
+		sz2pin = min_t(unsigned long, npages, list_size);
+		pinned = pin_user_pages(cur_base, sz2pin,
+					gup_flags, page_list, NULL);
+		if (sz2pin != pinned) {
+			if (pinned < 0) {
+				ret = pinned;
+			} else {
+				unpin_user_pages(page_list, pinned);
+				ret = -ENOMEM;
+			}
 			goto out;
+		}
+		nchunks++;
 
 		if (!last_pfn)
 			map_pfn = page_to_pfn(page_list[0]);
 
-		for (i = 0; i < ret; i++) {
+		for (i = 0; i < pinned; i++) {
 			unsigned long this_pfn = page_to_pfn(page_list[i]);
 			u64 csize;
 
 			if (last_pfn && (this_pfn != last_pfn + 1)) {
 				/* Pin a contiguous chunk of memory */
 				csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
-				if (vhost_vdpa_map(v, iova, csize,
-						   map_pfn << PAGE_SHIFT,
-						   msg->perm))
+				ret = vhost_vdpa_map(v, iova, csize,
+						     map_pfn << PAGE_SHIFT,
+						     msg->perm);
+				if (ret)
 					goto out;
+
 				map_pfn = this_pfn;
 				iova += csize;
+				nchunks = 0;
 			}
 
 			last_pfn = this_pfn;
 		}
 
-		cur_base += ret << PAGE_SHIFT;
-		npages -= ret;
+		cur_base += pinned << PAGE_SHIFT;
+		npages -= pinned;
 	}
 
 	/* Pin the rest chunk */
@@ -660,10 +676,22 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 			     map_pfn << PAGE_SHIFT, msg->perm);
 out:
 	if (ret) {
+		if (nchunks && last_pfn) {
+			unsigned long pfn;
+
+			/*
+			 * Unpin the outstanding pages which are unmapped.
+			 * Mapped pages are accounted in vdpa_map(), thus
+			 * will be handled by vdpa_unmap().
+			 */
+			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
+				unpin_user_page(pfn_to_page(pfn));
+		}
 		vhost_vdpa_unmap(v, msg->iova, msg->size);
-		atomic64_sub(npages, &dev->mm->pinned_vm);
 	}
+unlock:
 	mmap_read_unlock(dev->mm);
+free:
 	free_page((unsigned long)page_list);
 	return ret;
 }
-- 
1.8.3.1

