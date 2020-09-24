Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57503276BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgIXITJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:19:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35804 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgIXITJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:19:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08O8DWWe142262;
        Thu, 24 Sep 2020 08:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=7egQBYQqq8C83Ezi5WpH3BkBL/lnKIXaisoxSN5Yi+Q=;
 b=hLIkyNH4fXxuzfNCZZ+dXgrZSB+k5n7ix32F7JS1PcdgHxreuA9Gz6F1j1Hdl3ceNGcT
 8kdn0s/OpdTg5ngcW9VYXf+T3cIDCir+TQ+unpT0XZILqAbNy+iVcyl8qgV2XsKZN4lN
 WXhyEYNkyURzJBMt2KxhBlLw/i6Fwj3r9z+C1iQXRgybG7NJuiENvFwJcLQmVnnohub0
 PPWYIN2PmHVR+Uz031jhkc++0BrLcRPxmTm/0U/tlRqcHkEYPayyJqN1hmjxczJixeQQ
 bJu3gl0fprsm9YriFwMascnehRi+zfT8C78OIpficHR2nusrmq03EgeOyqHwaAksFdb0 yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33qcpu3nds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 08:18:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08O8FSYI193293;
        Thu, 24 Sep 2020 08:18:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33nux2dy4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 08:18:45 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08O8IdvE012820;
        Thu, 24 Sep 2020 08:18:40 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 01:18:39 -0700
Date:   Thu, 24 Sep 2020 11:18:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Abdiel Janulgue <abdiel.janulgue@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/i915: Uninitialized variable in
 i915_gem_object_map_page()
Message-ID: <20200924081830.GA1568157@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240064
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9753 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "i" iterator is never set to zero.  This probably doesn't affect
testing because GCC sometimes initializes variables and also we have a
new pluggin to initialize stack variables to zero.

Fixes: 7edd32a9e614 ("drm/i915: use vmap in i915_gem_object_map")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Hi Andrew, this should probably go through the -mm tree and get folded
into the original patch.

 drivers/gpu/drm/i915/gem/i915_gem_pages.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 90029ea83aed..12bedabc1daa 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -266,6 +266,7 @@ static void *i915_gem_object_map_page(struct drm_i915_gem_object *obj,
 			return NULL;
 	}
 
+	i = 0;
 	for_each_sgt_page(page, iter, obj->mm.pages)
 		pages[i++] = page;
 	vaddr = vmap(pages, n_pages, 0, pgprot);
@@ -291,6 +292,7 @@ static void *i915_gem_object_map_pfn(struct drm_i915_gem_object *obj)
 			return NULL;
 	}
 
+	i = 0;
 	for_each_sgt_daddr(addr, iter, obj->mm.pages)
 		pfns[i++] = (iomap + addr) >> PAGE_SHIFT;
 	vaddr = vmap_pfn(pfns, n_pfn, pgprot_writecombine(PAGE_KERNEL_IO));
-- 
2.28.0

