Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4C528FE0F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 08:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393953AbgJPGLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 02:11:22 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:52490 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390533AbgJPGLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 02:11:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCAHyCo_1602828676;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCAHyCo_1602828676)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 14:11:16 +0800
Date:   Fri, 16 Oct 2020 14:11:16 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 11/29] virtio-mem: use "unsigned long" for nr_pages
 when fake onlining/offlining
Message-ID: <20201016061116.GK86495@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-12-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-12-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:05PM +0200, David Hildenbrand wrote:
>No harm done, but let's be consistent.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/virtio/virtio_mem.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index cb2e8f254650..00d1cfca4713 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -766,7 +766,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
>  * (via generic_online_page()) using PageDirty().
>  */
> static void virtio_mem_set_fake_offline(unsigned long pfn,
>-					unsigned int nr_pages, bool onlined)
>+					unsigned long nr_pages, bool onlined)
> {
> 	for (; nr_pages--; pfn++) {
> 		struct page *page = pfn_to_page(pfn);
>@@ -785,7 +785,7 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
>  * (via generic_online_page()), clear PageDirty().
>  */
> static void virtio_mem_clear_fake_offline(unsigned long pfn,
>-					  unsigned int nr_pages, bool onlined)
>+					  unsigned long nr_pages, bool onlined)
> {
> 	for (; nr_pages--; pfn++) {
> 		struct page *page = pfn_to_page(pfn);
>@@ -800,10 +800,10 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
>  * Release a range of fake-offline pages to the buddy, effectively
>  * fake-onlining them.
>  */
>-static void virtio_mem_fake_online(unsigned long pfn, unsigned int nr_pages)
>+static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
> {
> 	const unsigned long max_nr_pages = MAX_ORDER_NR_PAGES;
>-	int i;
>+	unsigned long i;
> 
> 	/*
> 	 * We are always called at least with MAX_ORDER_NR_PAGES
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
