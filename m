Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549C82B0695
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgKLNic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:38:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbgKLNib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ul1CruwCYx90w7ShMaERvkQrn5bStSp6/chNAktrnL0=;
        b=KM7B/TL09walMtVv5vhD0XeyqbbSLaXsTsaqZsalFhT0JIBmxcvcwasM7vJaaRxJSHpD7G
        sHTJILeK6C0ZrI3IAEqdLQWJl1R0cOv3hNLk1Q8VpqJmXOe9wHJYQ7AoJjO2gQ/dO18vbM
        hB4MMl+F/6XYAE1feGaELtVBumwYmsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-81Uqt09dOKqVsUdrzESfCg-1; Thu, 12 Nov 2020 08:38:27 -0500
X-MC-Unique: 81Uqt09dOKqVsUdrzESfCg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF2361030986;
        Thu, 12 Nov 2020 13:38:25 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7133655766;
        Thu, 12 Nov 2020 13:38:16 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v2 00/29] virtio-mem: Big Block Mode (BBM)
Date:   Thu, 12 Nov 2020 14:37:46 +0100
Message-Id: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Andrew, can we have an ack for patch #27, so that one can go via
the vhost tree for 5.11?

---

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

Patch #1 - #10 are cleanups and optimizations
Patch #11 - #24 are refactorings to prepare for BBM
Patch #25 - #29 implement BBM, including one mm/memory_hotplug extension

This series is based on latest linus/master and can be found at:
 git@github.com:davidhildenbrand/linux.git virtio-mem-bbm-v2

v1 -> v2:
- Code wise, the only bigger change is using an union for sbm/bbm state
- Reworked some subjects/patch descriptions
- Reshuffled patches to make reviweing easier, and to have
  cleanups+optimizations before all refactorings
- "virtio-mem: more precise calculation in
   virtio_mem_mb_state_prepare_next_mb()"
-- Changed subject
-- Avoid two local variables

David Hildenbrand (29):
  virtio-mem: determine nid only once using memory_add_physaddr_to_nid()
  virtio-mem: more precise calculation in
    virtio_mem_mb_state_prepare_next_mb()
  virtio-mem: simplify MAX_ORDER - 1 / pageblock_order handling
  virtio-mem: drop rc2 in virtio_mem_mb_plug_and_add()
  virtio-mem: use "unsigned long" for nr_pages when fake
    onlining/offlining
  virtio-mem: factor out calculation of the bit number within the
    subblock bitmap
  virtio-mem: print debug messages from virtio_mem_send_*_request()
  virtio-mem: factor out fake-offlining into virtio_mem_fake_offline()
  virtio-mem: factor out handling of fake-offline pages in memory
    notifier
  virtio-mem: retry fake-offlining via alloc_contig_range() on
    ZONE_MOVABLE
  virtio-mem: generalize check for added memory
  virtio-mem: generalize virtio_mem_owned_mb()
  virtio-mem: generalize virtio_mem_overlaps_range()
  virtio-mem: drop last_mb_id
  virtio-mem: don't always trigger the workqueue when offlining memory
  virtio-mem: generalize handling when memory is getting onlined
    deferred
  virito-mem: document Sub Block Mode (SBM)
  virtio-mem: memory block states are specific to Sub Block Mode (SBM)
  virito-mem: subblock states are specific to Sub Block Mode (SBM)
  virtio-mem: nb_sb_per_mb and subblock_size are specific to Sub Block
    Mode (SBM)
  virtio-mem: memory block ids are specific to Sub Block Mode (SBM)
  virito-mem: existing (un)plug functions are specific to Sub Block Mode
    (SBM)
  virtio-mem: memory notifier callbacks are specific to Sub Block Mode
    (SBM)
  virtio-mem: factor out adding/removing memory from Linux
  virtio-mem: Big Block Mode (BBM) memory hotplug
  virtio-mem: allow to force Big Block Mode (BBM) and set the big block
    size
  mm/memory_hotplug: extend offline_and_remove_memory() to handle more
    than one memory block
  virtio-mem: Big Block Mode (BBM) - basic memory hotunplug
  virtio-mem: Big Block Mode (BBM) - safe memory hotunplug

 drivers/virtio/virtio_mem.c | 1789 +++++++++++++++++++++++++----------
 mm/memory_hotplug.c         |  105 +-
 2 files changed, 1376 insertions(+), 518 deletions(-)

-- 
2.26.2

