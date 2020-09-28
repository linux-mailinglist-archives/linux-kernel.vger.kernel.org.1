Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE4E27A87C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgI1HXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726547AbgI1HXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:23:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601277797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AtlT1iMWF/5W20OzcxPMZU+Wl3+AYaRi4YGqQPBZpu0=;
        b=E65hplX2+rtU6/lq391d9n75S0jdj6xFF2BL8bDlnhUkgp63QgYj2gXWjYhOTFdypZ+UHE
        +m3JAvV3ut4NkcL827Pspj5H8dTj6cQJqBRDPdrXhPPsUL1b4bGqT/7j0ygZ07ZDL3nSRI
        Cf4YLnkUXcIRGkCdYGfGTLMhA3/2htE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-b1irE8ZdNk-jN2STRIXOiA-1; Mon, 28 Sep 2020 03:23:15 -0400
X-MC-Unique: b1irE8ZdNk-jN2STRIXOiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9CC359;
        Mon, 28 Sep 2020 07:23:13 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-128.bne.redhat.com [10.64.54.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 874C57838A;
        Mon, 28 Sep 2020 07:23:10 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        anshuman.khandual@arm.com, robin.murphy@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v3 0/2] arm64/mm: Enable color zero pages
Date:   Mon, 28 Sep 2020 17:22:54 +1000
Message-Id: <20200928072256.13098-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature of color zero pages isn't enabled on arm64, meaning all
read-only (anonymous) VM areas are backed up by same zero page. It
leads pressure to data cache on reading data from them. In extreme
case, the same data cache set could be experiencing high pressure
and thrashing. This tries to enable color zero pages to resolve the
issue.

PATCH[1/2] decouples the zero PGD table from zero page
PATCH[2/2] allocates the needed zero pages according to L1 cache size

Testing
=======
[1] The experiment reveals how heavily the (L1) data cache miss impacts
    the overall application's performance. The machine where the test
    is carried out has the following L1 data cache topology. In the
    mean while, the host kernel have following configurations.

    The test case allocates contiguous page frames through HugeTLBfs
    and reads 4-bytes data from the same offset (0x0) from these (N)
    contiguous page frames. N is equal to 8 or 9 separately in the
    following two test cases. This is repeated for one million of
    times.

    Note that 8 is number of L1 data cache ways. The experiment is
    cause L1 cache thrashing on one particular set.

    Host:      CONFIG_ARM64_PAGE_SHIFT=12
               DEFAULT_HUGE_PAGE_SIZE=2MB
    L1 dcache: cache-line-size=64
               number-of-sets=64
               number-of-ways=8

                            N=8           N=9
    ------------------------------------------------------------------
    cache-misses:           43,429        9,038,460
    L1-dcache-load-misses:  43,429        9,038,460
    seconds time elapsed:   0.299206372   0.722253140   (2.41 times)

[2] The experiment should have been carried out on machine where the
    L1 data cache capacity of one particular way is larger than 4KB.
    However, I'm unable to find such kind of machines. So I have to
    evaluate the performance impact caused by L2 data cache thrashing.
    The experiment is carried out on the machine, which has following
    L1/L2 data cache topology. The host kernel configuration is same
    to [1].

    The corresponding test program allocates contiguous page frames
    through hugeTLBfs and builds VMAs backed by zero pages. These
    contiguous pages are sequentially read from fixed offset (0) in step
    of 32KB and by 8 times. After that, the VMA backed by zero pages are
    sequentially read in step of 4KB and by once. It's repeated by 8
    millions of times.

    Note 32KB is the cache capacity in one L2 data cache way and 8 is
    number of L2 data cache sets. This experiment is to cause L2 data
    cache thrashing on one particular set.

    L1 dcache:  <same as [1]>
    L2 dcache:  cache-line-size=64
                number-of-sets=512
                number-of-ways=8

    -----------------------------------------------------------------------
    cache-references:       1,427,213,737    1,421,394,472
    cache-misses:              35,804,552       42,636,698
    L1-dcache-load-misses:     35,804,552       42,636,698
    seconds time elapsed:   2.602511671      2.098198172      (+19.3%)

Changes since v2:

   * Rebased to last upstream kernel (5.9.rc6)             (Gavin)
   * Improved commit log                                   (Gavin)
   * Provide performance data in the cover letter          (Catalin)


Gavin Shan (2):
  arm64/mm: Introduce zero PGD table
  arm64/mm: Enable color zero pages

 arch/arm64/include/asm/cache.h       |  3 ++
 arch/arm64/include/asm/mmu_context.h |  6 +--
 arch/arm64/include/asm/pgtable.h     | 11 ++++-
 arch/arm64/kernel/cacheinfo.c        | 67 ++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c            |  2 +-
 arch/arm64/kernel/vmlinux.lds.S      |  4 ++
 arch/arm64/mm/init.c                 | 37 +++++++++++++++
 arch/arm64/mm/mmu.c                  |  7 ---
 arch/arm64/mm/proc.S                 |  2 +-
 drivers/base/cacheinfo.c             |  3 +-
 include/linux/cacheinfo.h            |  6 +++
 11 files changed, 132 insertions(+), 16 deletions(-)

-- 
2.23.0

