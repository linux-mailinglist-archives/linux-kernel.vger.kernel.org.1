Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEB12798C8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 14:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgIZMQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 08:16:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36150 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZMQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 08:16:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08QCBBQN046392;
        Sat, 26 Sep 2020 12:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=atEIomq8hYf7tlxHSLLvPfiNgFz6Bihcw8H+gjRKPKo=;
 b=YF3FsYqaNtFhap2zJKSSFNUq+hRUx002Q0I7nNH/vcksgMnscdVeBnT4/5gwcYy3QS31
 Cmdd1IdsHvZwdCvFUZOB3DSU+PWtik/x9Uh+XZiYu0mmXNdWWQwT9O+vTMwvk0nz6jdp
 oflGxvTjeYOMgIEYgr9Xf4TAtUT7R4RQWIYR3HgfZk4ugWj4zwMGSg+zWFzIwkT5lxY3
 ++JNr7Q3QzhSqG6G1div/DTJ1mNttqQrx+Zdhuq4R+wHkJCb+Zr/KJy7C2GWM/7V8phA
 /YPXcncGcb2AknOMwwxDTczzBsb0KHJmanLaPVlttt5eW51zuemiJZP2MN18vspCW/Rt kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33swkkgjfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 26 Sep 2020 12:16:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08QCAFCt164221;
        Sat, 26 Sep 2020 12:14:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33sweydxbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Sep 2020 12:14:15 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08QCE9LC032097;
        Sat, 26 Sep 2020 12:14:10 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 26 Sep 2020 05:14:09 -0700
Date:   Sat, 26 Sep 2020 15:14:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v3] mm/hmm/test: use after free in dmirror_allocate_chunk()
Message-ID: <20200926121402.GA7467@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b31586-426a-e0b1-803e-3eff30196c05@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009260112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=2 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009260112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error handling code does this:

err_free:
	kfree(devmem);
        ^^^^^^^^^^^^^
err_release:
	release_mem_region(devmem->pagemap.range.start, range_len(&devmem->pagemap.range));
                           ^^^^^^^^
The problem is that when we use "devmem->pagemap.range.start" the
"devmem" pointer is either NULL or freed.

Neither the allocation nor the call to request_free_mem_region() has to
be done under the lock so I moved those to the start of the function.

Fixes: 1f9c4bb986d9 ("mm/memremap_pages: convert to 'struct range'")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
---
v2: The first version introduced a locking bug
v3: Markus Elfring pointed out that the Fixes tag was wrong.  This bug
was in the original commit and then fixed and then re-introduced.  I was
quite bothered by how this bug lasted so long in the source code, but
now we know.  As soon as it is introduced we fixed it.

One problem with the kernel QC process is that I think everyone marks
the bug as "old/dealt with" so it was only because I was added a new
check for resource leaks that it was found when it was re-introduced.

 lib/test_hmm.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index c8133f50160b..e151a7f10519 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -459,6 +459,22 @@ static bool dmirror_allocate_chunk(struct dmirror_device *mdevice,
 	unsigned long pfn_last;
 	void *ptr;
 
+	devmem = kzalloc(sizeof(*devmem), GFP_KERNEL);
+	if (!devmem)
+		return -ENOMEM;
+
+	res = request_free_mem_region(&iomem_resource, DEVMEM_CHUNK_SIZE,
+				      "hmm_dmirror");
+	if (IS_ERR(res))
+		goto err_devmem;
+
+	devmem->pagemap.type = MEMORY_DEVICE_PRIVATE;
+	devmem->pagemap.range.start = res->start;
+	devmem->pagemap.range.end = res->end;
+	devmem->pagemap.nr_range = 1;
+	devmem->pagemap.ops = &dmirror_devmem_ops;
+	devmem->pagemap.owner = mdevice;
+
 	mutex_lock(&mdevice->devmem_lock);
 
 	if (mdevice->devmem_count == mdevice->devmem_capacity) {
@@ -471,30 +487,14 @@ static bool dmirror_allocate_chunk(struct dmirror_device *mdevice,
 				sizeof(new_chunks[0]) * new_capacity,
 				GFP_KERNEL);
 		if (!new_chunks)
-			goto err;
+			goto err_release;
 		mdevice->devmem_capacity = new_capacity;
 		mdevice->devmem_chunks = new_chunks;
 	}
 
-	res = request_free_mem_region(&iomem_resource, DEVMEM_CHUNK_SIZE,
-					"hmm_dmirror");
-	if (IS_ERR(res))
-		goto err;
-
-	devmem = kzalloc(sizeof(*devmem), GFP_KERNEL);
-	if (!devmem)
-		goto err_release;
-
-	devmem->pagemap.type = MEMORY_DEVICE_PRIVATE;
-	devmem->pagemap.range.start = res->start;
-	devmem->pagemap.range.end = res->end;
-	devmem->pagemap.nr_range = 1;
-	devmem->pagemap.ops = &dmirror_devmem_ops;
-	devmem->pagemap.owner = mdevice;
-
 	ptr = memremap_pages(&devmem->pagemap, numa_node_id());
 	if (IS_ERR(ptr))
-		goto err_free;
+		goto err_release;
 
 	devmem->mdevice = mdevice;
 	pfn_first = devmem->pagemap.range.start >> PAGE_SHIFT;
@@ -525,12 +525,12 @@ static bool dmirror_allocate_chunk(struct dmirror_device *mdevice,
 
 	return true;
 
-err_free:
-	kfree(devmem);
 err_release:
-	release_mem_region(devmem->pagemap.range.start, range_len(&devmem->pagemap.range));
-err:
 	mutex_unlock(&mdevice->devmem_lock);
+	release_mem_region(devmem->pagemap.range.start, range_len(&devmem->pagemap.range));
+err_devmem:
+	kfree(devmem);
+
 	return false;
 }
 
-- 
2.28.0
