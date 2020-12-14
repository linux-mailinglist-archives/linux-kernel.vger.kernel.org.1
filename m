Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794B02D9B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408340AbgLNPmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:42:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:58646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730761AbgLNPmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:42:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F861AC7F;
        Mon, 14 Dec 2020 15:41:38 +0000 (UTC)
Date:   Mon, 14 Dec 2020 16:41:38 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/build for v5.11
Message-ID: <20201214154138.GK26358@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two x86/build fixes for v5.11.

Thx.

---

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.11

for you to fetch changes up to 2838307b019dfec0c309c4e8e589658736cff4c9:

  x86/build: Remove -m16 workaround for unsupported versions of GCC (2020-12-01 17:17:18 +0100)

----------------------------------------------------------------
- Fix the vmlinux size check on 64-bit along with adding useful clarifications on the topic
(Arvind Sankar)

- Remove -m16 workaround now that the GCC versions that need it are unsupported
(Nick Desaulniers)

----------------------------------------------------------------
Arvind Sankar (1):
      x86/build: Fix vmlinux size check on 64-bit

Nick Desaulniers (1):
      x86/build: Remove -m16 workaround for unsupported versions of GCC

 arch/x86/Makefile                    |  9 +--------
 arch/x86/boot/code16gcc.h            | 12 ------------
 arch/x86/include/asm/page_32_types.h |  8 +++++++-
 arch/x86/include/asm/page_64_types.h |  6 ++++--
 arch/x86/include/asm/pgtable_32.h    | 18 ++++++------------
 arch/x86/kernel/head_64.S            | 20 +++++++++-----------
 arch/x86/kernel/vmlinux.lds.S        | 12 +++---------
 7 files changed, 30 insertions(+), 55 deletions(-)
 delete mode 100644 arch/x86/boot/code16gcc.h

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
