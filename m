Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382CA296DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 13:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463051AbgJWLeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 07:34:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43964 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462980AbgJWLeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:34:36 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09NBOxfq013150;
        Fri, 23 Oct 2020 11:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=tbKiGTsT3s13Xp9OSxn215JhwhGeMxGx2qrXzzVgyvI=;
 b=B8KcomkT8cV4HfCW1C7w22aZJIcXSiso+p9BX+YeETprhJNWQPMo4Of4gMPkBbrh4bWA
 rWUrXWUEf2+bdC5TQI9TbLRMEwLri58JhRW7nk6bgKlXqWTBMLZlyyawWSDJIti+8CJU
 PM4/VccVK7Shix04PVGJDqp5icPvr9GyOCZrQDqirUEzC20hnRWGMpdW1HhVJWRDeAl5
 rBERygRKZlpEVdSANOYYk/JOlI01IFHQtVti0m/9E+BDf7o+AB/Dc2i+7iWOPn0wWKMJ
 e41JXGGWJq2KW4G/Li6tTbE7ap35E9ojfgmfM5BGF++o0yyutSgGK50/M+JKrUQGqbKy TQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 347p4barwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Oct 2020 11:34:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09NBQ2xK151409;
        Fri, 23 Oct 2020 11:34:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34ak1ayjv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Oct 2020 11:34:18 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09NBYBgc010958;
        Fri, 23 Oct 2020 11:34:11 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 23 Oct 2020 04:34:10 -0700
Date:   Fri, 23 Oct 2020 14:34:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Auld <matthew.auld@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/i915: Fix a crash in shmem_pin_map() error handling
Message-ID: <20201023113401.GG282278@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9782 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9782 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010230081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a signedness bug in shmem_pin_map() error handling because "i"
is unsigned.  The "while (--i >= 0)" will loop forever until the system
crashes.

Fixes: bfed6708d6c9 ("drm/i915: use vmap in shmem_pin_map")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/i915/gt/shmem_utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/gt/shmem_utils.c
index f011ea42487e..7eb542018219 100644
--- a/drivers/gpu/drm/i915/gt/shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
@@ -52,8 +52,9 @@ struct file *shmem_create_from_object(struct drm_i915_gem_object *obj)
 void *shmem_pin_map(struct file *file)
 {
 	struct page **pages;
-	size_t n_pages, i;
+	size_t n_pages;
 	void *vaddr;
+	int i;
 
 	n_pages = file->f_mapping->host->i_size >> PAGE_SHIFT;
 	pages = kvmalloc_array(n_pages, sizeof(*pages), GFP_KERNEL);
-- 
2.28.0

