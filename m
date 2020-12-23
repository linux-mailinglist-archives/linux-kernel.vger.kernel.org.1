Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91CD2E19A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgLWIJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727468AbgLWIJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608710901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=X+E4mOCbGmFY6qa2D9l+paxorGnjOvKByACYD2gWYp4=;
        b=SCbNnDW5DfOReoMzij+AmZlgZ2A6Lp2mFBpfcrEiZEcCDPYjGe1BuN5jfFOEiYGU8O11oS
        8XQ9rknY+p3R+vlHpv/ed709E1q1NHhCTkQlJOqJCt6W+chiPf4rmQHW0bKRdVur2xPyU/
        zJJPNuVJF1JTOyP7DpZdDtJgDpGne1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-6olFiZpQM5m1XhotItqKMA-1; Wed, 23 Dec 2020 03:08:19 -0500
X-MC-Unique: 6olFiZpQM5m1XhotItqKMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EC0D8049C0;
        Wed, 23 Dec 2020 08:08:18 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-111.pek2.redhat.com [10.72.13.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87E1C5D9CC;
        Wed, 23 Dec 2020 08:08:12 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        gopakumarr@vmware.com, rppt@kernel.org, david@redhat.com,
        bhe@redhat.com
Subject: [PATCH v3 0/1] mm: memmap defer init dosn't work as expected
Date:   Wed, 23 Dec 2020 16:08:10 +0800
Message-Id: <20201223080811.16211-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Post the regression fix in a standalone patch as Andrew suggested for
-stable branch better back porting. This is rebased on the latest
master branch of mainline kenrel, surely there's almost no change
comparing with v2.
https://lore.kernel.org/linux-mm/20201220082754.6900-1-bhe@redhat.com/

Tested on a system with 24G ram as below, adding 'memmap=128M!0x500000000'
to split the one ram region into two regions in numa node1 to simulate
the scenario of VMware.

[  +0.000000] BIOS-provided physical RAM map:
[  +0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009bfff] usable
[  +0.000000] BIOS-e820: [mem 0x000000000009c000-0x000000000009ffff] reserved
[  +0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[  +0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000006cdcefff] usable
[  +0.000000] BIOS-e820: [mem 0x000000006cdcf000-0x000000006efcefff] reserved
[  +0.000000] BIOS-e820: [mem 0x000000006efcf000-0x000000006fdfefff] ACPI NVS
[  +0.000000] BIOS-e820: [mem 0x000000006fdff000-0x000000006fffefff] ACPI data
[  +0.000000] BIOS-e820: [mem 0x000000006ffff000-0x000000006fffffff] usable
[  +0.000000] BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff] reserved
[  +0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000ffffffff] reserved
[  +0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000067f1fffff] usable
[  +0.000000] BIOS-e820: [mem 0x000000067f200000-0x000000067fffffff] reserved

Test passed as below. As you can see, with patch applied, memmap init
will cost much less time on numa node 1:

Without the patch:
[    0.065029] Early memory node ranges
[    0.065030]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.065032]   node   0: [mem 0x0000000000100000-0x000000006cdcefff]
[    0.065034]   node   0: [mem 0x000000006ffff000-0x000000006fffffff]
[    0.065036]   node   0: [mem 0x0000000100000000-0x000000027fffffff]
[    0.065038]   node   1: [mem 0x0000000280000000-0x00000004ffffffff]
[    0.065040]   node   1: [mem 0x0000000508000000-0x000000067f1fffff]
[    0.065185] Zeroed struct page in unavailable ranges: 16533 pages
[    0.065187] Initmem setup node 0 [mem 0x0000000000001000-0x000000027fffffff]
[    0.069616] Initmem setup node 1 [mem 0x0000000280000000-0x000000067f1fffff]
[    0.096298] ACPI: PM-Timer IO Port: 0x408

With the patch applied:
[    0.065029] Early memory node ranges
[    0.065030]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.065032]   node   0: [mem 0x0000000000100000-0x000000006cdcefff]
[    0.065034]   node   0: [mem 0x000000006ffff000-0x000000006fffffff]
[    0.065036]   node   0: [mem 0x0000000100000000-0x000000027fffffff]
[    0.065038]   node   1: [mem 0x0000000280000000-0x00000004ffffffff]
[    0.065041]   node   1: [mem 0x0000000508000000-0x000000067f1fffff]
[    0.065187] Zeroed struct page in unavailable ranges: 16533 pages
[    0.065189] Initmem setup node 0 [mem 0x0000000000001000-0x000000027fffffff]
[    0.069572] Initmem setup node 1 [mem 0x0000000280000000-0x000000067f1fffff]
[    0.070161] ACPI: PM-Timer IO Port: 0x408


Baoquan He (1):
  mm: memmap defer init dosn't work as expected

 arch/ia64/mm/init.c | 4 ++--
 include/linux/mm.h  | 5 +++--
 mm/memory_hotplug.c | 2 +-
 mm/page_alloc.c     | 8 +++++---
 4 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.17.2

