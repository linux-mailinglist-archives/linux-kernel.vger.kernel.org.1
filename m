Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A7D2D8E2A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 16:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbgLMPLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 10:11:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726991AbgLMPLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 10:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607872195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=UIPal/iSZ9+R48jbZZ5wjjvQIt/y+OdbRYPpNTUIVyo=;
        b=CbbxM2vsoE/venrmNG6dWTwi9CRN9vr1ebTBsUYTIltD4klgt8G5ouQChwRkekS2OS1uIo
        9zWbKBnIwwF9/lC38Sk9bFJZsbHZNXzTnW4I5TI+qU0j+m5CXvZQ29fmmolwrK8BeezyI3
        4ulc9mtIOqLn/2OLf9bDvr0ePT1RZ5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-WRlB6oiHNnehtBfWXj6Auw-1; Sun, 13 Dec 2020 10:09:51 -0500
X-MC-Unique: WRlB6oiHNnehtBfWXj6Auw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FA2B107ACE3;
        Sun, 13 Dec 2020 15:09:49 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A76BF1F45B;
        Sun, 13 Dec 2020 15:09:44 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, gopakumarr@vmware.com,
        akpm@linux-foundation.org, rppt@kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        clang-built-linux@googlegroups.com, rostedt@goodmis.org,
        manir@vmware.com, lauyiuch@vmware.com, pjonasson@vmware.com,
        rajaramv@vmware.com
Subject: [PATCH 0/2] Fix the incorrect memmap init defer handling
Date:   Sun, 13 Dec 2020 23:09:40 +0800
Message-Id: <20201213150942.20990-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VMware reported the performance regression during memmap_init() invocation.
And they bisected to commit 73a6e474cb376 ("mm: memmap_init: iterate over
memblock regions rather that check each PFN") causing it.

After investigation, it's caused by incorrect memmap init defer handling
in memmap_init_zone() after commit 73a6e474cb376. The current
memmap_init_zone() only handle one memory region of one zone, while
memmap_init() iterates over all its memory regions and pass them one by
one into memmap_init_zone() to handle.

So in this patchset, patch 1/2 fixes the bug observed by VMware. Patch
2/2 clean up the inappropriate name of memmap_init(), memmap_init_zone()
accordingly.

VMware helped do the testing on their VMware ESI platform. This patchset
is based on 5.10.0-rc7+, master branch of Linus's tree.

Baoquan He (2):
  mm: memmap defer init dosn't work as expected
  mm: rename memmap_init() and memmap_init_zone()

 arch/ia64/mm/init.c |  8 ++++----
 include/linux/mm.h  |  5 +++--
 mm/memory_hotplug.c |  2 +-
 mm/page_alloc.c     | 22 ++++++++++++----------
 4 files changed, 20 insertions(+), 17 deletions(-)

-- 
2.17.2

