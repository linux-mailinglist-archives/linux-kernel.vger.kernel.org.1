Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E546C2A73AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbgKEARk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:17:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46252 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732719AbgKEAQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:16:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A50FJ0F010171;
        Thu, 5 Nov 2020 00:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=4gHQPbN/0tDjMdMDA26bnyjKuCCik+N8tgyOPGF/nYc=;
 b=SvqrCprg0QNoONrEdCtwCDq+6xuEVykvJh+/u2BgeS0uj4d/iM6rLTVYvASm0qHM/DN2
 12kyYHjVxKlT2HoYviN4WmJrZRtNgjp16KP5V8beMmjqFcjf5nU7tHgMj4xGtOm3RGY8
 NY0YTCUkuQOGOy9TsTjKoFf4hAHJNdEuoXtsYzHqWZINTqYGjBjUZ/Fqvt/aUjnTLWRy
 ENtlRbgGUT9X8wiwbh7wqpN5g8j//wk/HDSotan+wKbllfGbml8k10jN+129fskTqm31
 L6UfmAKKjTYu+2I0gts80ZtOVt1Vy6P+nZaGfSk3p3gTyvJs+4/fh6bZ6Ldy1+p4j28G Jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34hhw2sh0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 05 Nov 2020 00:16:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A505nnq155950;
        Thu, 5 Nov 2020 00:14:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34hvryp8qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Nov 2020 00:14:38 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A50EbYn026226;
        Thu, 5 Nov 2020 00:14:37 GMT
Received: from ban25x6uut24.us.oracle.com (/10.153.73.24)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Nov 2020 16:14:36 -0800
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     mst@redhat.com, jasowang@redhat.com, lingshan.zhu@intel.com
Cc:     joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com
Subject: [PATCH v2] vhost-vdpa: fix page pinning leakage in error path (rework)
Date:   Wed,  4 Nov 2020 18:33:16 -0500
Message-Id: <1604532796-12757-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=2 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=2 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050000
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
Changes in v2:
- Drop the reversion patch
- Fix unhandled page leak towards the end of page_list

 drivers/vhost/vdpa.c | 79 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index b6d9016..e112854 100644
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
@@ -607,52 +611,75 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
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
+				if (ret) {
+					/*
+					 * Unpin the pages that are left unmapped
+					 * from this point on in the current
+					 * page_list. The remaining outstanding
+					 * ones which may stride across several
+					 * chunks will be covered in the common
+					 * error path subsequently.
+					 */
+					unpin_user_pages(&page_list[i],
+							 pinned - i);
 					goto out;
+				}
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
@@ -660,10 +687,26 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 			     map_pfn << PAGE_SHIFT, msg->perm);
 out:
 	if (ret) {
+		if (nchunks && last_pfn) {
+			unsigned long pfn;
+
+			/*
+			 * Unpin the outstanding pages which are yet to be
+			 * mapped but haven't due to vdpa_map() or
+			 * pin_user_pages() failure.
+			 *
+			 * Mapped pages are accounted in vdpa_map(), hence
+			 * the corresponding unpinning will be handled by
+			 * vdpa_unmap().
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

