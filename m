Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACCE2D46F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbgLIQks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731879AbgLIQkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:40:36 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        kernel-team@android.com
Subject: [PATCH 0/2] Create 'old' ptes for faultaround mappings on arm64 with hardware access flag
Date:   Wed,  9 Dec 2020 16:39:48 +0000
Message-Id: <20201209163950.8494-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This series allows architectures to opt-in at runtime for faultaround
mappings to be created as 'old' instead of 'young'. Although there have
been previous attempts at this, they failed either because the decision
was deferred to userspace [1] or because it was done unconditionally and
shown to regress benchmarks for particular architectures [2].

Since this patch has demonstrated considerable benefits for arm64-based
Android devices with hardware access flag capabilities, patch two enables
this functionality there.

Cheers,

Will

[1] https://www.spinics.net/lists/linux-mm/msg143831.html
[2] 315d09bf30c2 ("Revert "mm: make faultaround produce old ptes"")

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vinayak Menon <vinmenon@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <kernel-team@android.com>

--->8

Will Deacon (2):
  mm: Allow architectures to request 'old' entries when prefaulting
  arm64: mm: Implement arch_wants_old_faultaround_pte()

 arch/arm64/include/asm/cpufeature.h | 12 +++++++++++
 arch/arm64/include/asm/pgtable.h    |  8 +++++++-
 include/linux/mm.h                  |  5 ++++-
 mm/memory.c                         | 31 ++++++++++++++++++++++++++---
 4 files changed, 51 insertions(+), 5 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

