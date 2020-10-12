Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF6028BF0D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404097AbgJLRaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389613AbgJLRaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:30:52 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E3DC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:30:50 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id c22so24368111ejx.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rpi7yMZAvKxwOxV6+e0Kq5wCetiKDzYZYDjwEKW7NmI=;
        b=NOW7hSloI1z09+FX2NxxSP09sPXamQ0RPeCoDqNNDcKSbC84yYRcVUfRO13aY83wvU
         CAITi1co6QjjwGIfuzUnpSmfxU8ykYbOHDHdhWE2Kfn7gN/2OfsZtQWzFh3x8vfo460L
         c49L+pj17knF28d1arebzVO0AOdu7KGkPBrtDC49+XtiDoPwBkZW+QnGHHCo4aXiA7wq
         lVfmbrKQcYdKM3AHC08NdcDsMTf1HAIlkSRXqqN9qsEtO3wWDvZbGkMmRqb8swSeKO+f
         0vnaNVUpcIj46UZ39gx/WUT/C4OM2Sjrg2sn1M7GibQq+nrCuORZqVNrAqtHCFFRsY/L
         M/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=rpi7yMZAvKxwOxV6+e0Kq5wCetiKDzYZYDjwEKW7NmI=;
        b=jR7b5T0I86Jt5w7I7QCQTnpC4aTo0MBdr0i0Uj/qoT1qxlOB2++C8OO+L6Yss8RMxc
         AHtNek7qCdWsYKVhfZ5i6j4w9cMaAOjsTWBWe0REwQHnZCq/Zv1lLUvj8LNHTKD4LTK8
         OGw6sU2Txm0S2+JvLHyrxbRdMqF2X6VqNl1IUcyuT5NsVcu1TFYCS/idQmDXK2cyvviI
         b9xSJ0/R33pbcAyS4qIQEV+sIFZSvRSzMooT1VdcA6OU91yvBZswoqIJX1TigWZV39uy
         AEcrAxG9fmta78/oNRaPGkCHfNXcinmaNaPzSNV99PLZXvsKeGQheRWFPd3NtY9xsxBQ
         Rlyg==
X-Gm-Message-State: AOAM5324YPNDxGLZ86gPsQXCH7YdHUK1vS76oyT5f896sI+v/blVbGHS
        O+zpsvihMOL+ceANjfNdc5g=
X-Google-Smtp-Source: ABdhPJxAB6C4vCyREw1s2xEkJ8GvH3tYng+Wcumgp6MhF3Rmlv0uRrjaRCx1m6ZOHwpiFIEY+/bVMg==
X-Received: by 2002:a17:906:a4e:: with SMTP id x14mr28819033ejf.112.1602523849092;
        Mon, 12 Oct 2020 10:30:49 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id y11sm10956126edu.85.2020.10.12.10.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 10:30:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 19:30:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [GIT PULL] x86/paravirt changes for v5.10
Message-ID: <20201012173046.GA2992944@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/paravirt git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-paravirt-2020-10-12

   # HEAD: 7c9f80cb76ec9f14c3b25509168b1a2f7942e418 x86/paravirt: Avoid needless paravirt step clearing page table entries

Clean up the paravirt code after the removal of 32-bit Xen PV support.

 Thanks,

	Ingo

------------------>
Juergen Gross (6):
      x86/paravirt: Remove 32-bit support from CONFIG_PARAVIRT_XXL
      x86/paravirt: Clean up paravirt macros
      x86/paravirt: Use CONFIG_PARAVIRT_XXL instead of CONFIG_PARAVIRT
      x86/entry/32: Simplify CONFIG_XEN_PV build dependency
      x86/paravirt: Remove set_pte_at() pv-op
      x86/paravirt: Avoid needless paravirt step clearing page table entries


 arch/x86/entry/entry_64.S                   |   4 +-
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |   1 +
 arch/x86/include/asm/fixmap.h               |   2 +-
 arch/x86/include/asm/idtentry.h             |   4 +-
 arch/x86/include/asm/paravirt.h             | 151 ++++------------------------
 arch/x86/include/asm/paravirt_types.h       |  23 -----
 arch/x86/include/asm/pgtable-3level_types.h |   5 -
 arch/x86/include/asm/pgtable.h              |   7 +-
 arch/x86/include/asm/required-features.h    |   2 +-
 arch/x86/include/asm/segment.h              |   4 -
 arch/x86/kernel/cpu/common.c                |   8 --
 arch/x86/kernel/kprobes/core.c              |   1 -
 arch/x86/kernel/kprobes/opt.c               |   1 -
 arch/x86/kernel/paravirt.c                  |  19 ----
 arch/x86/kernel/paravirt_patch.c            |  17 ----
 arch/x86/xen/enlighten_pv.c                 |   6 --
 arch/x86/xen/mmu_pv.c                       |   8 --
 include/trace/events/xen.h                  |  20 ----
 18 files changed, 27 insertions(+), 256 deletions(-)
