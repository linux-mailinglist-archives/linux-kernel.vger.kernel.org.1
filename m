Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796332AA30D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 08:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgKGHlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 02:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgKGHlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 02:41:11 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03D2C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 23:41:09 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id x23so2032118plr.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 23:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=Aj52fNi+6qkhS7kowQN13Bo7Tv7SK9o+ZxNTLM9lCXM=;
        b=AJYIQmr+DjHlfx85x8SwEqe9jZibSh8Q4nTZ2gU2RisyBQzJCtfaUCSEGrsE6YXF+T
         Li1apuSs+Pyg+Y8pjyNCvUgUTXckI9QjmiCnrhc0Lkk4EKQ08FufNLRecan+nUBsuLpO
         AapxciKiwfPXBUnW7kirqen7sm5S8LR2aaSjn+wc0Febdg2iI9kuO3R78r8Y9udvB9f/
         +ahCAyQiE5R2MkGAyE9fT+BxbTh9kPAxuMwq2HnSK2ZpmvQ/81ogWpjahCxs9g0IkxOK
         +HxOTqaWS+GXHalZp8en/BiOtueK5WTU5E2qxwe/M+jBDKcnOwBZ3WKEZLnQ80cBmbT+
         RLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=Aj52fNi+6qkhS7kowQN13Bo7Tv7SK9o+ZxNTLM9lCXM=;
        b=OduiFBZqWtFAxQieFIhn9f5tNqk45YLfTfYTL7T2c2XOL4LYF0R3gya5sqOaq6w8yi
         eRdIjH9sXv0mQO6mGTtfQrMT3RvamFHBpYdEXLodPdktGNJLvgnXHDJRcRZvF1h6QhcN
         fcbhYSugLcV4cwGTZ9WBsXgbDJoxUw9nCo/ivFIfhQ6nwDaYY3O152Suj5cUaL3TZswy
         wcLGwRu0KgQt1u6l+OkES9tifiLE1b7W+sJheJ5jp0N7GmXIrHD53uzywj3FhKEuKBLQ
         9XSlmws/Xai5q5/ay5BTCkJu07clXicnL+IEey8ZP25HLL6PaqUS+ZFVmklGTXQzZx/U
         GW2g==
X-Gm-Message-State: AOAM532lOESB2fEOVTHj9L1fpsYblkmn14bhLTmXPqKH+m0P/7JRjoME
        y0PCtpCdKA+0FUCCmLfhuX5BYyMYWEj/SQ==
X-Google-Smtp-Source: ABdhPJyO7FhNpvfOl8UtSFGhcRQbIwhjpnT16iiwvxMvOsq87oRipgIWzN6N8NJlf41nOC4LHNbVXQ==
X-Received: by 2002:a17:90a:ca91:: with SMTP id y17mr3154280pjt.205.1604734869258;
        Fri, 06 Nov 2020 23:41:09 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v24sm4739929pjh.19.2020.11.06.23.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 23:41:08 -0800 (PST)
Date:   Fri, 06 Nov 2020 23:41:08 -0800 (PST)
X-Google-Original-Date: Fri, 06 Nov 2020 23:41:04 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.10-rc3
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-3492671f-a069-445d-a6d8-89363714a1fb@palmerdabbelt-glaptop1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.10-rc3

for you to fetch changes up to c2c81bb2f69138f902e1a58d3bef6ad97fb8a92c:

  RISC-V: Fix the VDSO symbol generaton for binutils-2.35+ (2020-11-06 00:03:48 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.10-rc3

* An SPDX comment style fix.
* A fix to ignore memory that is unusable.
* A fix to avoid setting a kernel text offset for the !MMU kernels, where
  skipping the first page of memory is both unnecessary and costly.
* A fix to avoid passing the flag bits in satp to pfn_to_virt().
* A fix to __put_kernel_nofault, where we had the arguments to
  __put_user_nocheck reversed.
* A workaround for a bug in the FU540 to avoid triggering PMP issues during
  early boot.
* A change to how we pull symbols out of the vDSO.  The old mechanism was
  removed from binutils-2.35 (and has been backported to Debian's 2.34).

----------------------------------------------------------------
Anup Patel (1):
      RISC-V: Use non-PGD mappings for early DTB access

Atish Patra (1):
      RISC-V: Remove any memblock representing unusable memory area

Changbin Du (1):
      riscv: uaccess: fix __put_kernel_nofault()

Liu Shaohua (1):
      riscv: fix pfn_to_virt err in do_page_fault().

Palmer Dabbelt (1):
      RISC-V: Fix the VDSO symbol generaton for binutils-2.35+

Ryan Kosta (1):
      risc-v: kernel: ftrace: Fixes improper SPDX comment style

Sean Anderson (1):
      riscv: Set text_offset correctly for M-Mode

 arch/riscv/include/asm/uaccess.h  |  2 +-
 arch/riscv/kernel/ftrace.c        |  2 +-
 arch/riscv/kernel/head.S          |  5 +++++
 arch/riscv/kernel/vdso/.gitignore |  1 +
 arch/riscv/kernel/vdso/Makefile   | 18 +++++++++---------
 arch/riscv/kernel/vdso/so2s.sh    |  6 ++++++
 arch/riscv/mm/fault.c             |  4 +++-
 arch/riscv/mm/init.c              | 32 +++++++++++++++++++++-----------
 8 files changed, 47 insertions(+), 23 deletions(-)
 create mode 100755 arch/riscv/kernel/vdso/so2s.sh
