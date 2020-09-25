Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98080278DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgIYQPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:15:49 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2921 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727812AbgIYQPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:15:49 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 9D747FC57CE208BCF606;
        Fri, 25 Sep 2020 17:15:47 +0100 (IST)
Received: from [127.0.0.1] (10.47.7.140) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 25 Sep
 2020 17:15:46 +0100
Subject: Re: [PATCH 1/2] iommu/iova: Flush CPU rcache for when a depot fills
From:   John Garry <john.garry@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <xiyou.wangcong@gmail.com>
References: <1601027469-221812-1-git-send-email-john.garry@huawei.com>
 <1601027469-221812-2-git-send-email-john.garry@huawei.com>
 <bede311f-9a07-98e1-e728-9acd4ad13b51@arm.com>
 <11d30dc2-0b2d-fc30-a07a-9c5f18064d2b@huawei.com>
Message-ID: <039894e1-63d7-54eb-9f17-14f94f884400@huawei.com>
Date:   Fri, 25 Sep 2020 17:12:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <11d30dc2-0b2d-fc30-a07a-9c5f18064d2b@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.7.140]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2020 15:34, John Garry wrote:
> Indeed, I think that the mainline code has a bug:
> 
> If the initial allocation for the loaded/prev magazines fail (give NULL) 
> in init_iova_rcaches(), then in __iova_rcache_insert():
> 
> if (!iova_magazine_full(cpu_rcache->loaded)) {
>      can_insert = true;
> 
> If cpu_rcache->loaded == NULL, then can_insert is assigned true -> bang, 
> as I experimented, below. This needs to be fixed...
> 

This looks better:

Subject: [PATCH] iommu/iova: Avoid double-negatives with magazine helpers

Expression !iova_magazine_full(mag) evaluates true when mag == NULL.

This falls over in __iova_rcache_insert() when loaded == NULL:

if (!iova_magazine_full(cpu_rcache->loaded)) {
	can_insert = true;

...

if (can_insert)
	iova_magazine_push(cpu_rcache->loaded, iova_pfn);

Here, can_insert is evaluated true, which is wrong. Members
loaded/prev can possibly be NULL if the initial allocations fail in
__iova_rcache_insert().

Let's stop using double-negatives, like !iova_magazine_full(), and use
iova_magazine_has_space() instead in this case. And similar for
!iova_magazine_empty().

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 5b4ffab7140b..42ca9d0f39b7 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -827,14 +827,18 @@ iova_magazine_free_pfns(struct iova_magazine *mag, 
struct iova_domain *iovad)
  	mag->size = 0;
  }

-static bool iova_magazine_full(struct iova_magazine *mag)
+static bool iova_magazine_has_space(struct iova_magazine *mag)
  {
-	return (mag && mag->size == IOVA_MAG_SIZE);
+	if (!mag)
+		return false;
+	return mag->size < IOVA_MAG_SIZE;
  }

-static bool iova_magazine_empty(struct iova_magazine *mag)
+static bool iova_magazine_has_pfns(struct iova_magazine *mag)
  {
-	return (!mag || mag->size == 0);
+	if (!mag)
+		return false;
+	return mag->size;
  }

  static unsigned long iova_magazine_pop(struct iova_magazine *mag,
@@ -843,7 +847,7 @@ static unsigned long iova_magazine_pop(struct 
iova_magazine *mag,
  	int i;
  	unsigned long pfn;

-	BUG_ON(iova_magazine_empty(mag));
+	BUG_ON(!iova_magazine_has_pfns(mag));

  	/* Only fall back to the rbtree if we have no suitable pfns at all */
  	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
@@ -859,7 +863,7 @@ static unsigned long iova_magazine_pop(struct 
iova_magazine *mag,

  static void iova_magazine_push(struct iova_magazine *mag, unsigned 
long pfn)
  {
-	BUG_ON(iova_magazine_full(mag));
+	BUG_ON(!iova_magazine_has_space(mag));

  	mag->pfns[mag->size++] = pfn;
  }
@@ -905,9 +909,9 @@ static bool __iova_rcache_insert(struct iova_domain 
*iovad,
  	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
  	spin_lock_irqsave(&cpu_rcache->lock, flags);

-	if (!iova_magazine_full(cpu_rcache->loaded)) {
+	if (iova_magazine_has_space(cpu_rcache->loaded)) {
  		can_insert = true;
-	} else if (!iova_magazine_full(cpu_rcache->prev)) {
+	} else if (iova_magazine_has_space(cpu_rcache->prev)) {
  		swap(cpu_rcache->prev, cpu_rcache->loaded);
  		can_insert = true;
  	} else {
@@ -915,7 +919,8 @@ static bool __iova_rcache_insert(struct iova_domain 
*iovad,

  		if (new_mag) {
  			spin_lock(&rcache->lock);
-			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
+			if (rcache->depot_size < MAX_GLOBAL_MAGS &&
+			    cpu_rcache->loaded) {
  				rcache->depot[rcache->depot_size++] =
  						cpu_rcache->loaded;
  			} else {
@@ -968,9 +973,9 @@ static unsigned long __iova_rcache_get(struct 
iova_rcache *rcache,
  	cpu_rcache = raw_cpu_ptr(rcache->cpu_rcaches);
  	spin_lock_irqsave(&cpu_rcache->lock, flags);

-	if (!iova_magazine_empty(cpu_rcache->loaded)) {
+	if (iova_magazine_has_pfns(cpu_rcache->loaded)) {
  		has_pfn = true;
-	} else if (!iova_magazine_empty(cpu_rcache->prev)) {
+	} else if (iova_magazine_has_pfns(cpu_rcache->prev)) {
  		swap(cpu_rcache->prev, cpu_rcache->loaded);
  		has_pfn = true;
  	} else {
-- 
2.26.2

