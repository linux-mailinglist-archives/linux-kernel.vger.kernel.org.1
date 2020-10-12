Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6518A28B527
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgJLMzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbgJLMzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q9GM/RC1q+vCqZJJfD/E/PUDck+Uo5hffUOgkPmx7l8=;
        b=bHeXEPf3aa24cH2mrW9ITVB3Ai0sKkb4vqZYQiQcF0eFyandIpZ7x72V6mEcvxF1SasNML
        jMPEIADJiqSk2iQJuFYHgFrpud1PPywshvlKxwZq4d4cGNHJ3MWKPgmUHIURx+gCoOoC8P
        j78TVVxZZD3i0jCi/ZcXEoItwr7ShtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-d5mjEzCnMdSllyEiygdUvg-1; Mon, 12 Oct 2020 08:54:58 -0400
X-MC-Unique: d5mjEzCnMdSllyEiygdUvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80C8085EE96;
        Mon, 12 Oct 2020 12:54:57 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EF9D60C07;
        Mon, 12 Oct 2020 12:54:51 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 11/29] virtio-mem: use "unsigned long" for nr_pages when fake onlining/offlining
Date:   Mon, 12 Oct 2020 14:53:05 +0200
Message-Id: <20201012125323.17509-12-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No harm done, but let's be consistent.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index cb2e8f254650..00d1cfca4713 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -766,7 +766,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
  * (via generic_online_page()) using PageDirty().
  */
 static void virtio_mem_set_fake_offline(unsigned long pfn,
-					unsigned int nr_pages, bool onlined)
+					unsigned long nr_pages, bool onlined)
 {
 	for (; nr_pages--; pfn++) {
 		struct page *page = pfn_to_page(pfn);
@@ -785,7 +785,7 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
  * (via generic_online_page()), clear PageDirty().
  */
 static void virtio_mem_clear_fake_offline(unsigned long pfn,
-					  unsigned int nr_pages, bool onlined)
+					  unsigned long nr_pages, bool onlined)
 {
 	for (; nr_pages--; pfn++) {
 		struct page *page = pfn_to_page(pfn);
@@ -800,10 +800,10 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
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

