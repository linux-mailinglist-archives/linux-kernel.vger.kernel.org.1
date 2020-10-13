Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068EE28CA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403858AbgJMI03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391435AbgJMI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:26:28 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EB3C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 01:26:28 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id o18so19972057edq.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cWwJh2yOqJGdMufsFyE/SnbuWmJYNdtS39AZoN3aX/8=;
        b=gPuED7goM2Q4OQ3aftdMEf/7XXFs8DBiWQfJy+eAbqVrvxV66aytc0viMR4QbpGj3Y
         mgp8JqCO78JS6Mmnx50AneeMlKmRjkmD6vyIu0pc5h33rCu6GuTOn7GXpfxxRyaj4uL5
         8p2VTqKKMT6GiqshYhONzTGrRlc2d71Az533oGgBWkSrQVLgalnrby5hkGwbr9XNjEC8
         869t3imoYnTUrS77KjUDRMNqSn09p98mQA1MfW235f4okymToHY12ErYhkY0eFdzBdAG
         FYUALLvz6wrlyrdMb7X5GZkb9TBu490f2UjcvwL0UdUGICofx8EluC4jxGZU4gcRncum
         d12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=cWwJh2yOqJGdMufsFyE/SnbuWmJYNdtS39AZoN3aX/8=;
        b=slzgT8fQoeQJIDUItT0boE6sGNcUeMBziNZj/2bEojZIeo+iZTdCb3F4qCsfbesJgH
         SoEr2Q4GXOuRKRnnJAL1qFTK7rYLwPsFmQ7o+UVYUbTlSu37xEB/pbam4/MNrV3MF6JC
         7PCWJSPPX0COxpvGHC4uAVf8VyxK9rshUH4j1fyxWPeUhtaZLCqk14VUrLZ0jQgGA+p0
         SnBbcmHLR8hJRDav4sVmLZXsZNXg08DuPaPvi9wl42IMm4cX26lGCZdZd/wK/HW17zNv
         GCNdDp72egurqAsV1rBMjYVTg1h2b7ECgLnyp7gCQNX5npgiR9LehzwV2RD6XjnrSEE4
         vOHw==
X-Gm-Message-State: AOAM532n0fyI7ERenHYviDh77E1NV5VOpQe1YM4PkhGBSpoVxtz7jT0k
        PtlJ8/T/XWeU8+kqCRbX9TA=
X-Google-Smtp-Source: ABdhPJyKrKFc6JGVc+BOGzMxpZwa3N4HYI6PFmXXFUQXj/a8Ep2B2qTniukvDRF02uQcWjXhoSFO3Q==
X-Received: by 2002:a50:88c6:: with SMTP id d64mr19175179edd.141.1602577587359;
        Tue, 13 Oct 2020 01:26:27 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id q22sm12225242edi.41.2020.10.13.01.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 01:26:26 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 13 Oct 2020 10:26:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool changes for v5.10
Message-ID: <20201013082625.GA775379@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest objtool/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2020-10-13

   # HEAD: 2486baae2cf6df73554144d0a4e40ae8809b54d4 objtool: Allow nested externs to enable BUILD_BUG()

objtool changes for v5.10:

 - Most of the changes are cleanups and reorganization to make the objtool code
   more arch-agnostic. This is in preparation for non-x86 support.

Fixes:

 - KASAN fixes.
 - Handle unreachable trap after call to noreturn functions better.
 - Ignore unreachable fake jumps.
 - Misc smaller fixes & cleanups.

 Thanks,

	Ingo

------------------>
Ilie Halip (1):
      objtool: Ignore unreachable trap after call to noreturn functions

Jann Horn (1):
      objtool: Permit __kasan_check_{read,write} under UACCESS

Julien Thierry (16):
      objtool: Move object file loading out of check()
      objtool: Move ORC logic out of check()
      objtool: Skip ORC entry creation for non-text sections
      objtool: Define 'struct orc_entry' only when needed
      objtool: Group headers to check in a single list
      objtool: Make sync-check consider the target architecture
      objtool: Move macros describing structures to arch-dependent code
      objtool: Abstract alternative special case handling
      objtool: Make relocation in alternative handling arch dependent
      objtool: Rename frame.h -> objtool.h
      objtool: Only include valid definitions depending on source file type
      objtool: Make unwind hint definitions available to other architectures
      objtool: Decode unwind hint register depending on architecture
      objtool: Remove useless tests before save_reg()
      objtool: Ignore unreachable fake jumps
      objtool: Handle calling non-function symbols in other sections

Raphael Gault (1):
      objtool: Refactor jump table code to support other architectures

Vasily Gorbik (1):
      objtool: Allow nested externs to enable BUILD_BUG()


 MAINTAINERS                                   |   1 +
 arch/x86/include/asm/nospec-branch.h          |   2 +-
 arch/x86/include/asm/orc_types.h              |  34 ----
 arch/x86/include/asm/unwind_hints.h           |  56 ++-----
 arch/x86/kernel/kprobes/core.c                |   2 +-
 arch/x86/kernel/kprobes/opt.c                 |   2 +-
 arch/x86/kernel/reboot.c                      |   2 +-
 arch/x86/kernel/unwind_orc.c                  |  11 +-
 arch/x86/kvm/svm/svm.c                        |   2 +-
 arch/x86/kvm/vmx/nested.c                     |   2 +-
 arch/x86/kvm/vmx/vmx.c                        |   2 +-
 arch/x86/xen/enlighten_pv.c                   |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c           |   3 +-
 include/linux/frame.h                         |  35 ----
 include/linux/objtool.h                       | 129 +++++++++++++++
 kernel/bpf/core.c                             |   2 +-
 kernel/kexec_core.c                           |   2 +-
 tools/arch/x86/include/asm/orc_types.h        |  34 ----
 tools/include/linux/objtool.h                 | 129 +++++++++++++++
 tools/objtool/Makefile                        |   6 +-
 tools/objtool/arch.h                          |   4 +
 tools/objtool/arch/x86/Build                  |   1 +
 tools/objtool/arch/x86/decode.c               |  37 +++++
 tools/objtool/arch/x86/include/arch_special.h |  20 +++
 tools/objtool/arch/x86/special.c              | 145 ++++++++++++++++
 tools/objtool/builtin-check.c                 |  15 +-
 tools/objtool/builtin-orc.c                   |  27 ++-
 tools/objtool/check.c                         | 230 ++++++--------------------
 tools/objtool/check.h                         |   9 +-
 tools/objtool/objtool.c                       |  30 ++++
 tools/objtool/objtool.h                       |   6 +-
 tools/objtool/orc_dump.c                      |   9 +-
 tools/objtool/orc_gen.c                       |   8 +-
 tools/objtool/special.c                       |  48 +-----
 tools/objtool/special.h                       |  10 ++
 tools/objtool/sync-check.sh                   |  32 +++-
 tools/objtool/weak.c                          |   6 +-
 37 files changed, 685 insertions(+), 410 deletions(-)
 delete mode 100644 include/linux/frame.h
 create mode 100644 include/linux/objtool.h
 create mode 100644 tools/include/linux/objtool.h
 create mode 100644 tools/objtool/arch/x86/include/arch_special.h
 create mode 100644 tools/objtool/arch/x86/special.c
