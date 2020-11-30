Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B512C920D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbgK3XHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:07:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730941AbgK3XHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606777569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9V9FuQlcHe27aEonW+OALoveBudDEu+UmzrjYKQNh4E=;
        b=f65bBdp8HofHOKndXrFLtxyObWxiltBcwo5yhpJtFzKUQNvmz8tX4nQAM6z+LWCY07Vo90
        SLIRgCGPfKKmiq2oH36xYvtaklE/kiybixKu4DzO/DDPaFsSFEBAInRaUiNClxszX98p1c
        TgO3Fzw6fX3q1qD3bd1GBcA40WON2DI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-zctFAYMlMWq_fnz1pJGXIQ-1; Mon, 30 Nov 2020 18:06:07 -0500
X-MC-Unique: zctFAYMlMWq_fnz1pJGXIQ-1
Received: by mail-qt1-f199.google.com with SMTP id z8so9472475qti.17
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9V9FuQlcHe27aEonW+OALoveBudDEu+UmzrjYKQNh4E=;
        b=I2e0xhjS0ZWuCnMPP7yJwYNNAJka9f7eZU9Kc2RRgcl9ZDlWMokn9zD0gxTR0u/8ah
         3m0SRHPBJTP1eQcC0ENZjiai6Gkk5/Y608zlvl1SuWV6178ZGFy9LL358P/TMpViu2qP
         5GY7mS9D7T72GvU39SYs4MWuWPa+ho6WmSwhdtNTU2F8XXriTeuznXp+wPdhJSnYkFG/
         vC8ON2gT59liwsxaEXeIyDm8WGnZwdJ1Ir6i8aILVpUJ8mDBMTOADhbA6t7d3wp7pgI/
         244nFSN30X/Ww11mraiiaTZLSkMymNpUEumq2WfT5Y69YWD/XXSF9fyOoaxio1O2z0EM
         /5tQ==
X-Gm-Message-State: AOAM532xaZtxKjJjdrDTDe3yezDoIjBD9vxPMLNZSldJCbH/jG5uB8iT
        vBvLAEwtRfYe6Dl2EoZChE0W8HBIHCI0k2FDQYiDk4JBwuRIqBGZjmSKbrFOR88r2qE6O+LeC/a
        88Yx176uPAjljVaCilQju3nCWbB01Q+ixc//mcPc2/l7p5fjGMOWG6fjEgbyp6omMmgGtOWCggg
        ==
X-Received: by 2002:a0c:f585:: with SMTP id k5mr103830qvm.13.1606777566713;
        Mon, 30 Nov 2020 15:06:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/Dym6WjHP1+CpIQT83RJxo3OYyzcdTaNwpv/TvzTB4YWBqy3oSKltZ0fsvSU7z/TUTcO8sg==
X-Received: by 2002:a0c:f585:: with SMTP id k5mr103794qvm.13.1606777566321;
        Mon, 30 Nov 2020 15:06:06 -0800 (PST)
Received: from xz-x1.redhat.com ([142.126.81.247])
        by smtp.gmail.com with ESMTPSA id v28sm16605610qkj.103.2020.11.30.15.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 15:06:05 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] mm: Don't fault around userfaultfd-registered regions on reads
Date:   Mon, 30 Nov 2020 18:06:03 -0500
Message-Id: <20201130230603.46187-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Faulting around for reads are in most cases helpful for the performance so that
continuous memory accesses may avoid another trip of page fault.  However it
may not always work as expected.

For example, userfaultfd registered regions may not be the best candidate for
pre-faults around the reads.

For missing mode uffds, fault around does not help because if the page cache
existed, then the page should be there already.  If the page cache is not
there, nothing else we can do, either.  If the fault-around code is destined to
be helpless for userfault-missing vmas, then ideally we can skip it.

For wr-protected mode uffds, errornously fault in those pages around could lead
to threads accessing the pages without uffd server's awareness.  For example,
when punching holes on uffd-wp registered shmem regions, we'll first try to
unmap all the pages before evicting the page cache but without locking the
page (please refer to shmem_fallocate(), where unmap_mapping_range() is called
before shmem_truncate_range()).  When fault-around happens near a hole being
punched, we might errornously fault in the "holes" right before it will be
punched.  Then there's a small window before the page cache was finally
dropped, and after the page will be writable again (NOTE: the uffd-wp protect
information is totally lost due to the pre-unmap in shmem_fallocate(), so the
page can be writable within the small window).  That's severe data loss.

Let's grant the userspace full control of the uffd-registered ranges, rather
than trying to do the tricks.

Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

v2:
- use userfaultfd_armed() directly [Mike]

Note that since no file-backed uffd-wp support is there yet upstream, so the
uffd-wp check is actually not really functioning.  However since we have all
the necessary uffd-wp concepts already upstream, maybe it's better to do it
once and for all.

This patch comes from debugging a data loss issue when working on the uffd-wp
support on shmem/hugetlbfs.  I posted this out for early review and comments,
but also because it should already start to benefit missing mode userfaultfd to
avoid trying to fault around on reads.
---
 mm/memory.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index eeae590e526a..59b2be22565e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3933,6 +3933,23 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	int off;
 	vm_fault_t ret = 0;
 
+	/*
+	 * Be extremely careful with uffd-armed regions.
+	 *
+	 * For missing mode uffds, fault around does not help because if the
+	 * page cache existed, then the page should be there already.  If the
+	 * page cache is not there, nothing else we can do either.
+	 *
+	 * For wr-protected mode uffds, errornously fault in those pages around
+	 * could lead to threads accessing the pages without uffd server's
+	 * awareness, finally it could cause ghostly data corruption.
+	 *
+	 * The idea is that, every single page of uffd regions should be
+	 * governed by the userspace on which page to fault in.
+	 */
+	if (unlikely(userfaultfd_armed(vmf->vma)))
+		return 0;
+
 	nr_pages = READ_ONCE(fault_around_bytes) >> PAGE_SHIFT;
 	mask = ~(nr_pages * PAGE_SIZE - 1) & PAGE_MASK;
 
-- 
2.26.2

