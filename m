Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3682A86DB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbgKETPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:15:23 -0500
Received: from shelob.surriel.com ([96.67.55.147]:60542 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731965AbgKETPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:15:22 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kakj1-00048T-Bd; Thu, 05 Nov 2020 14:15:11 -0500
From:   Rik van Riel <riel@surriel.com>
To:     hughd@google.com
Cc:     xuyu@linux.alibaba.com, akpm@linux-foundation.org, mgorman@suse.de,
        aarcange@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, vbabka@suse.cz, mhocko@suse.com
Subject: [PATCH 0/2] mm,thp,shm: limit shmem THP alloc gfp_mask
Date:   Thu,  5 Nov 2020 14:15:06 -0500
Message-Id: <20201105191508.1961686-1-riel@surriel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation flags of anonymous transparent huge pages can be controlled
through the files in /sys/kernel/mm/transparent_hugepage/defrag, which can
help the system from getting bogged down in the page reclaim and compaction
code when many THPs are getting allocated simultaneously.

However, the gfp_mask for shmem THP allocations were not limited by those
configuration settings, and some workloads ended up with all CPUs stuck
on the LRU lock in the page reclaim code, trying to allocate dozens of
THPs simultaneously.

This patch applies the same configurated limitation of THPs to shmem
hugepage allocations, to prevent that from happening.

This way a THP defrag setting of "never" or "defer+madvise" will result
in quick allocation failures without direct reclaim when no 2MB free
pages are available.

With this patch applied, THP allocations for tmpfs will be a little
more aggressive than today for files mmapped with MADV_HUGEPAGE,
and a little less aggressive for files that are not mmapped or
mapped without that flag.

v5: reduce gfp mask further if needed, to accomodate i915 (Matthew Wilcox)
v4: rename alloc_hugepage_direct_gfpmask to vma_thp_gfp_mask (Matthew Wilcox)
v3: fix NULL vma issue spotted by Hugh Dickins & tested
v2: move gfp calculation to shmem_getpage_gfp as suggested by Yu Xu


