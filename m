Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A76B2B069F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgKLNiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:38:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728273AbgKLNim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/q5ADxWs1ReqxtomGdawJvY3H3MZGMG2OFcFur4kQ1Y=;
        b=KDqpkJ0rKYT4BrsuQnVShP+76cDy7nZdavGTxth7p0cqwPlPp0QJug9XIdaq4V6AHUFu3B
        poo7GYm3VKbJELWOYxeP9qxjZSS/S234KwnB5WT9ShUHt4voHuyEEbdvRl82a9w3aD7G8l
        AZlhWzoJc0zdKTVdy8D4iFlEJu3GHw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-CBo_IWUqMcyu5d0Rg8eMPg-1; Thu, 12 Nov 2020 08:38:37 -0500
X-MC-Unique: CBo_IWUqMcyu5d0Rg8eMPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DFF7809DE5;
        Thu, 12 Nov 2020 13:38:36 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA7FC75132;
        Thu, 12 Nov 2020 13:38:34 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 05/29] virtio-mem: use "unsigned long" for nr_pages when fake onlining/offlining
Date:   Thu, 12 Nov 2020 14:37:51 +0100
Message-Id: <20201112133815.13332-6-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No harm done, but let's be consistent.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 4f18d9855a0e..94451b401fba 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -717,7 +717,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
  * (via generic_online_page()) using PageDirty().
  */
 static void virtio_mem_set_fake_offline(unsigned long pfn,
-					unsigned int nr_pages, bool onlined)
+					unsigned long nr_pages, bool onlined)
 {
 	for (; nr_pages--; pfn++) {
 		struct page *page = pfn_to_page(pfn);
@@ -736,7 +736,7 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
  * (via generic_online_page()), clear PageDirty().
  */
 static void virtio_mem_clear_fake_offline(unsigned long pfn,
-					  unsigned int nr_pages, bool onlined)
+					  unsigned long nr_pages, bool onlined)
 {
 	for (; nr_pages--; pfn++) {
 		struct page *page = pfn_to_page(pfn);
@@ -751,10 +751,10 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
  * Release a range of fake-offline pages to the buddy, effectively
  * fake-onlining them.
  */
-static void virtio_mem_fake_online(unsigned long pfn, unsigned int nr_pages)
+static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
 {
 	const unsigned long max_nr_pages = MAX_ORDER_NR_PAGES;
-	int i;
+	unsigned long i;
 
 	/*
 	 * We are always called at least with MAX_ORDER_NR_PAGES
-- 
2.26.2

