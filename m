Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EE82F746F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbhAOIeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:34:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbhAOIeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:34:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8017522597;
        Fri, 15 Jan 2021 08:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610699600;
        bh=KpXmcXL6FYc320RhBuERzath9qSEZFkBf2bJF4H4cmc=;
        h=From:To:Cc:Subject:Date:From;
        b=SW/g2dTWKGHibp7GcZoc7RanuaeEfvCGzUkMd2N28NQnlLJpd21DXiKc+XHf8fh8I
         xo3OBIE5Vdj31zcF/CR2c2TE2vijLaJb0ipZGQMTgENBPS79Hh3J/W4eX41XpWh1Q7
         MFTK5UQvdchPjerlzxb5j+EtLXFpulrVGXTYtlfTEkleyvB+x1BHxUEgt6g9PgPO5P
         4YchAEcLGJamFPM4LH6yfLPxCGMDVR6+ep8jsTXJWiztRpiFJOLEIntGHZIOP+hHaO
         LriShka04lSjY7Ny1aZ8GmGlyNI2eTUMMFFkvURjmf8D2gWY/36k5FDT5A4iYejy7x
         MqaCavw9ej1hg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: [PATCH 0/2] x86/setup: consolidate early memory reservations
Date:   Fri, 15 Jan 2021 10:32:53 +0200
Message-Id: <20210115083255.12744-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

David noticed that we do some of memblock_reserve() calls after allocations
are possible:

https://lore.kernel.org/lkml/6ba6bde3-1520-5cd0-f987-32d543f0b79f@redhat.com

For now there is no actual problem because in top-down mode we allocate
from the end of the memory and in bottom-up mode we allocate above the
kernel image. But there is a patch in the mm tree that allow bottom-up
allocations below the kernel:

https://lore.kernel.org/lkml/20201217201214.3414100-2-guro@fb.com

and with this change we may get a memory corruption if an allocation steps
on some of the firmware areas that are yet to be reserved.

The below patches consolidate early memory reservations done during
setup_arch() so that memory used by firmware, bootloader, kernel text/data
and the memory that should be excluded from the available memory for
whatever other reason is reserved before memblock allocations are possible.

The patches are vs v5.11-rc3-mmots-2021-01-12-02-00 as I think they are
prerequisite for the memblock bottom-up changes, but if needed I can rebase
then on another tree.

Mike Rapoport (2):
  x86/setup: consolidate early memory reservations
  x86/setup: merge several reservations of start of the memory

 arch/x86/kernel/setup.c | 85 +++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 42 deletions(-)

-- 
2.28.0

