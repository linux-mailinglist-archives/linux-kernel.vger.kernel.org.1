Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAA23039EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389074AbhAZKMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731232AbhAYTUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:20:06 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55403C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:26 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id a7so6759700qkb.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVcNgPh564PK35x1sTZ0bKsntgnqO2EFCpDyFybL0j8=;
        b=KtpKCIStkJW0ly3JgTvKb36YeSL7x+f6o/mLahml2cxqXyWGt2fZTYTDQd/RURaNF7
         0FXE3/XR0RLbKo5OO+PHIL62Pnr+oN5aCoE+RlQDcvxDpdnJ5XPqXfubliPIT4UMjSwC
         6iVt5pv5CpwA8tXb0lY4huBZZfwzU2TI/ip8DY+P2YgX0p4PiUZP/+F/G3Ph/s2/1cPm
         KhsA96SMwWfdBTl22tRZ/w/P+4E/R8DiWudAw4sO3Xy03QL5UvMNiomkIzdmldqURT4I
         wydglkp6i0tHb2oyyeQxiStPG9kCf8rxuIw4LRaPGSviMjqJ0ETZTagQuBLKnNlg2Jh5
         BGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVcNgPh564PK35x1sTZ0bKsntgnqO2EFCpDyFybL0j8=;
        b=JpIT7RTysZmQH3MHtFlon7xTS1qe4L+TXWr86N3dGkRE26jrbr6koMC9Y+tYJ4L2w4
         1imTg+rCfD0t7qGvzyC+F2+nUePMilctTOz6KakKT+HJnh0tsis63Hv26qRysEDvwP+F
         /MYTwzFs20Hr1K+8q0KZmMc3rO7mMS8/g4Mxn4Je/1zm9oWR/9hGQXsg+cVSgNjeB9T+
         QGgoRpOGdr0OSSWQ+CmPzSGkTcccWrruEtr5aSBrP24sY2fjLJzQnO9twP4nf+tjS2/N
         DqruOkC8fK+8pKr2l2jlmckRb4vYFlDka/YZaW7vRnwX1e0CuO+jvK7lSvcQQTHHksl3
         HhGg==
X-Gm-Message-State: AOAM53116QGiA2m3M4szWA73NJ53ijgYWn3dI+oCQ3lqB7R7F/r1PFdl
        AvDdIS/hwpbVopZDkpQyuC9XbA==
X-Google-Smtp-Source: ABdhPJzdMjZYecSvWnmsvqNHnoa43C9Wo9eG6QGNlkx1UYAvpP47qpeoIOjDJC9j51WS0DlUpS+1iQ==
X-Received: by 2002:a37:9905:: with SMTP id b5mr2355893qke.140.1611602365473;
        Mon, 25 Jan 2021 11:19:25 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:24 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v10 00/18] arm64: MMU enabled kexec relocation
Date:   Mon, 25 Jan 2021 14:19:05 -0500
Message-Id: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v10:
	- Addressed a lot of comments form James Morse and from  Marc Zyngier
	- Added review-by's
	- Synchronized with mainline

v9:	- 9 patches from previous series landed in upstream, so now series
	  is smaller
	- Added two patches from James Morse to address idmap issues for machines
	  with high physical addresses.
	- Addressed comments from Selin Dag about compiling issues. He also tested
	  my series and got similar performance results: ~60 ms instead of ~580 ms
	  with an initramfs size of ~120MB.
v8:
	- Synced with mainline to keep series up-to-date
v7:
	-- Addressed comments from James Morse
	- arm64: hibernate: pass the allocated pgdp to ttbr0
	  Removed "Fixes" tag, and added Added Reviewed-by: James Morse
	- arm64: hibernate: check pgd table allocation
	  Sent out as a standalone patch so it can be sent to stable
	  Series applies on mainline + this patch
	- arm64: hibernate: add trans_pgd public functions
	  Remove second allocation of tmp_pg_dir in swsusp_arch_resume
	  Added Reviewed-by: James Morse <james.morse@arm.com>
	- arm64: kexec: move relocation function setup and clean up
	  Fixed typo in commit log
	  Changed kern_reloc to phys_addr_t types.
	  Added explanation why kern_reloc is needed.
	  Split into four patches:
	  arm64: kexec: make dtb_mem always enabled
	  arm64: kexec: remove unnecessary debug prints
	  arm64: kexec: call kexec_image_info only once
	  arm64: kexec: move relocation function setup
	- arm64: kexec: add expandable argument to relocation function
	  Changed types of new arguments from unsigned long to phys_addr_t.
	  Changed offset prefix to KEXEC_*
	  Split into four patches:
	  arm64: kexec: cpu_soft_restart change argument types
	  arm64: kexec: arm64_relocate_new_kernel clean-ups
	  arm64: kexec: arm64_relocate_new_kernel don't use x0 as temp
	  arm64: kexec: add expandable argument to relocation function
	- arm64: kexec: configure trans_pgd page table for kexec
	  Added invalid entries into EL2 vector table
	  Removed KEXEC_EL2_VECTOR_TABLE_SIZE and KEXEC_EL2_VECTOR_TABLE_OFFSET
	  Copy relocation functions and table into separate pages
	  Changed types in kern_reloc_arg.
	  Split into three patches:
	  arm64: kexec: offset for relocation function
	  arm64: kexec: kexec EL2 vectors
	  arm64: kexec: configure trans_pgd page table for kexec
	- arm64: kexec: enable MMU during kexec relocation
	  Split into two patches:
	  arm64: kexec: enable MMU during kexec relocation
	  arm64: kexec: remove head from relocation argument
v6:
	- Sync with mainline tip
	- Added Acked's from Dave Young
v5:
	- Addressed comments from Matthias Brugger: added review-by's, improved
	  comments, and made cleanups to swsusp_arch_resume() in addition to
	  create_safe_exec_page().
	- Synced with mainline tip.
v4:
	- Addressed comments from James Morse.
	- Split "check pgd table allocation" into two patches, and moved to
	  the beginning of series  for simpler backport of the fixes.
	  Added "Fixes:" tags to commit logs.
	- Changed "arm64, hibernate:" to "arm64: hibernate:"
	- Added Reviewed-by's
	- Moved "add PUD_SECT_RDONLY" earlier in series to be with other
	  clean-ups
	- Added "Derived from:" to arch/arm64/mm/trans_pgd.c
	- Removed "flags" from trans_info
	- Changed .trans_alloc_page assumption to return zeroed page.
	- Simplify changes to trans_pgd_map_page(), by keeping the old
	  code.
	- Simplify changes to trans_pgd_create_copy, by keeping the old
	  code.
	- Removed: "add trans_pgd_create_empty"
	- replace init_mm with NULL, and keep using non "__" version of
	  populate functions.
v3:
	- Split changes to create_safe_exec_page() into several patches for
	  easier review as request by Mark Rutland. This is why this series
	  has 3 more patches.
	- Renamed trans_table to tans_pgd as agreed with Mark. The header
	  comment in trans_pgd.c explains that trans stands for
	  transitional page tables. Meaning they are used in transition
	  between two kernels.
v2:
	- Fixed hibernate bug reported by James Morse
	- Addressed comments from James Morse:
	  * More incremental changes to trans_table
	  * Removed TRANS_FORCEMAP
	  * Added kexec reboot data for image with 380M in size.

Enable MMU during kexec relocation in order to improve reboot performance.

If kexec functionality is used for a fast system update, with a minimal
downtime, the relocation of kernel + initramfs takes a significant portion
of reboot.

The reason for slow relocation is because it is done without MMU, and thus
not benefiting from D-Cache.

Performance data
----------------
For this experiment, the size of kernel plus initramfs is small, only 25M.
If initramfs was larger, than the improvements would be greater, as time
spent in relocation is proportional to the size of relocation.

Previously:
kernel shutdown	0.022131328s
relocation	0.440510736s
kernel startup	0.294706768s

Relocation was taking: 58.2% of reboot time

Now:
kernel shutdown	0.032066576s
relocation	0.022158152s
kernel startup	0.296055880s

Now: Relocation takes 6.3% of reboot time

Total reboot is x2.16 times faster.

With bigger userland (fitImage 380M), the reboot time is improved by 3.57s,
and is reduced from 3.9s down to 0.33s

Previous approaches and discussions
-----------------------------------
v9: https://lore.kernel.org/lkml/20200326032420.27220-1-pasha.tatashin@soleen.com
v8: https://lore.kernel.org/lkml/20191204155938.2279686-1-pasha.tatashin@soleen.com
v7: https://lore.kernel.org/lkml/20191016200034.1342308-1-pasha.tatashin@soleen.com
v6: https://lore.kernel.org/lkml/20191004185234.31471-1-pasha.tatashin@soleen.com
v5: https://lore.kernel.org/lkml/20190923203427.294286-1-pasha.tatashin@soleen.com
v4: https://lore.kernel.org/lkml/20190909181221.309510-1-pasha.tatashin@soleen.com
v3: https://lore.kernel.org/lkml/20190821183204.23576-1-pasha.tatashin@soleen.com
v2: https://lore.kernel.org/lkml/20190817024629.26611-1-pasha.tatashin@soleen.com
v1: https://lore.kernel.org/lkml/20190801152439.11363-1-pasha.tatashin@soleen.com

Older approaches:
https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com
reserve space for kexec to avoid relocation, involves changes to generic code
to optimize a problem that exists on arm64 only:

https://lore.kernel.org/lkml/20190716165641.6990-1-pasha.tatashin@soleen.com
The first attempt to enable MMU, some bugs that prevented performance
improvement. The page tables unnecessary configured idmap for the whole
physical space.

https://lore.kernel.org/lkml/20190731153857.4045-1-pasha.tatashin@soleen.com
No linear copy, bug with EL2 reboots.

James Morse (2):
  arm64: mm: Always update TCR_EL1 from __cpu_set_tcr_t0sz()
  arm64: trans_pgd: hibernate: idmap the single page that holds the copy
    page routines

Pavel Tatashin (16):
  arm64: kexec: make dtb_mem always enabled
  arm64: hibernate: variable pudp is used instead of pd4dp
  arm64: hibernate: move page handling function to new trans_pgd.c
  arm64: trans_pgd: make trans_pgd_map_page generic
  arm64: trans_pgd: pass allocator trans_pgd_create_copy
  arm64: trans_pgd: pass NULL instead of init_mm to *_populate functions
  arm64: kexec: move relocation function setup
  arm64: kexec: call kexec_image_info only once
  arm64: kexec: arm64_relocate_new_kernel clean-ups and optimizations
  arm64: kexec: arm64_relocate_new_kernel don't use x0 as temp
  arm64: kexec: add expandable argument to relocation function
  arm64: kexec: use ld script for relocation function
  arm64: kexec: kexec may require EL2 vectors
  arm64: kexec: configure trans_pgd page table for kexec
  arm64: kexec: enable MMU during kexec relocation
  arm64: kexec: remove head from relocation argument

 arch/arm64/Kconfig                   |   4 +
 arch/arm64/include/asm/kexec.h       |  42 +++-
 arch/arm64/include/asm/mmu_context.h |   7 +-
 arch/arm64/include/asm/sections.h    |   1 +
 arch/arm64/include/asm/trans_pgd.h   |  39 ++++
 arch/arm64/kernel/asm-offsets.c      |  15 ++
 arch/arm64/kernel/cpu-reset.S        |  11 +-
 arch/arm64/kernel/cpu-reset.h        |   8 +-
 arch/arm64/kernel/hibernate.c        | 271 +++-------------------
 arch/arm64/kernel/machine_kexec.c    | 182 +++++++++++----
 arch/arm64/kernel/relocate_kernel.S  | 218 ++++++++++--------
 arch/arm64/kernel/vmlinux.lds.S      |  19 ++
 arch/arm64/mm/Makefile               |   1 +
 arch/arm64/mm/trans_pgd.c            | 324 +++++++++++++++++++++++++++
 14 files changed, 749 insertions(+), 393 deletions(-)
 create mode 100644 arch/arm64/include/asm/trans_pgd.h
 create mode 100644 arch/arm64/mm/trans_pgd.c

-- 
2.25.1

