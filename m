Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0ED2DF46E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 09:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgLTI3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 03:29:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727043AbgLTI3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 03:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608452885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=DUjf0b7Cp0HBk1u4zghdBX7mQ4cTJHbAWmAcP28K9Oo=;
        b=hq68T6dcKKT5M7pPfRghFASlvUT+T4cWtiBKuJd0BFfwP0vgIseVCYuuI7CYpN+1x4uVe9
        KM1SfFtpbJx4NGBJbZlue/j0Lr+PuKklLle5hb9X/98XMQ0OyYfMaiQ65qMb7nN9+2CNBC
        vLn/jYssOh+GKbCmv7WRmwGWuZe+xGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-BZpv9fMcNgmuY6AH8FCnrQ-1; Sun, 20 Dec 2020 03:28:03 -0500
X-MC-Unique: BZpv9fMcNgmuY6AH8FCnrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B7E5800D53;
        Sun, 20 Dec 2020 08:28:02 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4049C60C13;
        Sun, 20 Dec 2020 08:27:55 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        gopakumarr@vmware.com, rppt@kernel.org, david@redhat.com,
        bhe@redhat.com
Subject: [PATCH v2 0/5] Fix the incorrect memmep defer init handling and do some cleanup 
Date:   Sun, 20 Dec 2020 16:27:49 +0800
Message-Id: <20201220082754.6900-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VMware reported the performance regression during memmap_init() invocation.
And they bisected to commit 73a6e474cb376 ("mm: memmap_init: iterate over
memblock regions rather that check each PFN") causing it.

https://lore.kernel.org/linux-mm/DM6PR05MB52921FF90FA01CC337DD23A1A4080@DM6PR05MB5292.namprd05.prod.outlook.com/

After investigation, it's caused by incorrect memmap init defer handling
in memmap_init_zone() after commit 73a6e474cb376. The current
memmap_init_zone() only handle one memory region of one zone, while
memmap_init() iterates over all its memory regions and pass them one by
one into memmap_init_zone() to handle.

So in this patchset, patch 1/5 fixes the bug observed by VMware. Patch
2~5/5 clean up codes.
accordingly.

VMware helped do the testing for the patch 1 of v1 version which was based
on master branch of Linus's tree on their VMware ESI platform, while the
patch 1 is not changed in functionality in v2. And I haven't got a
ia64 machine to compile or test, will really appreciate if anyone can help
compile this patchset on one. This patchset is based on the latest next/master,
only did the basic test.  

Baoquan He (5):
  mm: memmap defer init dosn't work as expected
  mm: rename memmap_init() and memmap_init_zone()
  mm: simplify parater of function memmap_init_zone()
  mm: simplify parameter of setup_usemap()
  mm: remove unneeded local variable in free_area_init_core

 arch/ia64/include/asm/pgtable.h |  3 +-
 arch/ia64/mm/init.c             | 16 +++++----
 include/linux/mm.h              |  5 +--
 mm/memory_hotplug.c             |  2 +-
 mm/page_alloc.c                 | 60 ++++++++++++++++-----------------
 5 files changed, 43 insertions(+), 43 deletions(-)

-- 
2.17.2

