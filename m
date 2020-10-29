Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC8E29F166
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgJ2Q1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725963AbgJ2Q1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603988850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U6ucExP53XsVuBHTIJjynzcjVBwXkXFE9HrshKR2yNc=;
        b=bpd85E4L3l1MPpogqISFzEkpE2slVXjUgtuShWGvMSkYsTJ3L557jJMh3L/s04hxktKCAj
        dZsfzAR8my365duSinEXWgAVeKaXG0chjzNp9dY/9/OIFmS0QKd3qszA3dZfoY9bMX/xnx
        IrHUNHZf3TRdq08SU3e+G75YZJiyP8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-qPI0bZwUNYmvdiUjZCSeyQ-1; Thu, 29 Oct 2020 12:27:28 -0400
X-MC-Unique: qPI0bZwUNYmvdiUjZCSeyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBA8B18B6472;
        Thu, 29 Oct 2020 16:27:25 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-181.ams2.redhat.com [10.36.112.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B27B5C26A;
        Thu, 29 Oct 2020 16:27:19 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v1 0/4] powernv/memtrace: don't abuse memory hot(un)plug infrastructure for memory allocations
Date:   Thu, 29 Oct 2020 17:27:14 +0100
Message-Id: <20201029162718.29910-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powernv/memtrace is the only in-kernel user that rips out random memory
it never added (doesn't own) in order to allocate memory without a
linear mapping. Let's stop abusing memory hot(un)plug infrastructure for
that - use alloc_contig_pages() for allocating memory and remove the
linear mapping manually.

The original idea was discussed in:
 https://lkml.kernel.org/r/48340e96-7e6b-736f-9e23-d3111b915b6e@redhat.com

I only tested allocations briefly via QEMU TCG - see patch #4 for more
details.

David Hildenbrand (4):
  powerpc/mm: factor out creating/removing linear mapping
  powerpc/mm: print warning in arch_remove_linear_mapping()
  powerpc/mm: remove linear mapping if __add_pages() fails in
    arch_add_memory()
  powernv/memtrace: don't abuse memory hot(un)plug infrastructure for
    memory allocations

 arch/powerpc/mm/mem.c                     |  48 +++++---
 arch/powerpc/platforms/powernv/Kconfig    |   8 +-
 arch/powerpc/platforms/powernv/memtrace.c | 134 ++++++++--------------
 include/linux/memory_hotplug.h            |   3 +
 4 files changed, 86 insertions(+), 107 deletions(-)

-- 
2.26.2

