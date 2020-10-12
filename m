Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4796328B507
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgJLMxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgJLMxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9as9DomaNwaEbcpUvaYzBEVtAuuYaWah59A5A3tRjFI=;
        b=HDpx4AZOalRoTQQbQGeKsDE30iQ/KrQ8fUikC0Z9MMR00Wc9qKULPWzQ6/goWGADgCAiN0
        B5rPXkOXR6l9Ne3zIe4vvgOFq6Q22vq0suR8+V2ZMXw9Q+j+z/uHPhYcme3eiPfswp8MS/
        DArkYvlAIukO5V8k/sYsHzj3su1hE90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-aa_kpuyJPze5snL9n_K6Iw-1; Mon, 12 Oct 2020 08:53:49 -0400
X-MC-Unique: aa_kpuyJPze5snL9n_K6Iw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA6551074654;
        Mon, 12 Oct 2020 12:53:47 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11BC260C07;
        Mon, 12 Oct 2020 12:53:34 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v1 00/29] virtio-mem: Big Block Mode (BBM)
Date:   Mon, 12 Oct 2020 14:52:54 +0200
Message-Id: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio-mem currently only supports device block sizes that span at most
a single Linux memory block. For example, gigantic pages in the hypervisor
result on x86-64 in a device block size of 1 GiB - when the Linux memory
block size is 128 MiB, we cannot support such devices (we fail loading the
driver). Of course, we want to support any device block size in any Linux
VM.

Bigger device block sizes will become especially important once supporting
VFIO in QEMU - each device block has to be mapped separately, and the
maximum number of mappings for VFIO is 64k. So we usually want blocks in
the gigabyte range when wanting to grow the VM big.

This series:
- Performs some cleanups
- Factors out existing Sub Block Mode (SBM)
- Implements memory hot(un)plug in Big Block Mode (BBM)

I need one core-mm change, to make offline_and_remove_memory() eat bigger
chunks.

This series is based on "next-20201009" and can be found at:
	git@gitlab.com:virtio-mem/linux.git virtio-mem-dbm-v1

Once some virtio-mem patches that are pending in the -mm tree are upstream
(I guess they'll go in in 5.10), I'll resend based on Linus' tree.
I suggest to take this (including the MM patch, acks/review please) via the
vhost tree once time has come. In the meantime, I'll do more testing.

David Hildenbrand (29):
  virtio-mem: determine nid only once using memory_add_physaddr_to_nid()
  virtio-mem: simplify calculation in
    virtio_mem_mb_state_prepare_next_mb()
  virtio-mem: simplify MAX_ORDER - 1 / pageblock_order handling
  virtio-mem: drop rc2 in virtio_mem_mb_plug_and_add()
  virtio-mem: generalize check for added memory
  virtio-mem: generalize virtio_mem_owned_mb()
  virtio-mem: generalize virtio_mem_overlaps_range()
  virtio-mem: drop last_mb_id
  virtio-mem: don't always trigger the workqueue when offlining memory
  virtio-mem: generalize handling when memory is getting onlined
    deferred
  virtio-mem: use "unsigned long" for nr_pages when fake
    onlining/offlining
  virtio-mem: factor out fake-offlining into virtio_mem_fake_offline()
  virtio-mem: factor out handling of fake-offline pages in memory
    notifier
  virtio-mem: retry fake-offlining via alloc_contig_range() on
    ZONE_MOVABLE
  virito-mem: document Sub Block Mode (SBM)
  virtio-mem: memory block states are specific to Sub Block Mode (SBM)
  virito-mem: subblock states are specific to Sub Block Mode (SBM)
  virtio-mem: factor out calculation of the bit number within the
    sb_states bitmap
  virito-mem: existing (un)plug functions are specific to Sub Block Mode
    (SBM)
  virtio-mem: nb_sb_per_mb and subblock_size are specific to Sub Block
    Mode (SBM)
  virtio-mem: memory notifier callbacks are specific to Sub Block Mode
    (SBM)
  virtio-mem: memory block ids are specific to Sub Block Mode (SBM)
  virtio-mem: factor out adding/removing memory from Linux
  virtio-mem: print debug messages from virtio_mem_send_*_request()
  virtio-mem: Big Block Mode (BBM) memory hotplug
  virtio-mem: allow to force Big Block Mode (BBM) and set the big block
    size
  mm/memory_hotplug: extend offline_and_remove_memory() to handle more
    than one memory block
  virtio-mem: Big Block Mode (BBM) - basic memory hotunplug
  virtio-mem: Big Block Mode (BBM) - safe memory hotunplug

 drivers/virtio/virtio_mem.c | 1783 +++++++++++++++++++++++++----------
 mm/memory_hotplug.c         |  105 ++-
 2 files changed, 1373 insertions(+), 515 deletions(-)

-- 
2.26.2

