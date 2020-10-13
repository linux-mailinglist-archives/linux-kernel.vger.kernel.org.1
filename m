Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26D28CBE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgJMKig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgJMKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:38:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E013C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 03:38:35 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ce10so27548108ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mXc/BbvWP3AIjg/haFgyy4BVln9bhjQf0eqYaY7B15o=;
        b=q+FyDFZapM8r18jwPFsDpEnGC7eH5hdQ443Krsk3A7Pl4Z3Prf8mH9hn7UtVif5b8g
         nAMw4bEtapNFEOc2z45erbDEoIFo51sqpiaqay9kpJ5bQCK8Sa56rJRrJKuxUrkTajr0
         ZjpdwMdgsIYoZNDb/0lvS5WRX55WbSF2iH0NhsHB9/df8OEaSZllY3VoHp8WhthOLklF
         StbpEvZZLWdz1jeV+Ayx38l91gPmzzDrEGvL6eZYNB5FHaVE5qPO/YrwClHHiaI63nti
         mxFiwlC/Q1kRtV+ShbNYDef4ABM7NxKI2KkQ16ur0DYlzu8jLFtV5xmsSC3Lu5aR9qxA
         6rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mXc/BbvWP3AIjg/haFgyy4BVln9bhjQf0eqYaY7B15o=;
        b=fexsaN5yZrGNxseT+BoPQBA55vjHzH8iCEDcqiKUIMNQ3/o4ilLY50v4EWPQPzm70+
         W0VRwV7iqfkKMmf+N0iubGKkqvxSYXi0jKqHqMowLpMIf2hv317P7wnHu4iahHeqFFqG
         MBSDSpzHIjYP7/3bvMW+O0CI7Ok376AczpYirPLPfU9blH5Yd+jWwgvyLYDpIgDVVeBb
         uCt7XhughcCpQa+GkDnjKj/rGj7RfeKRJOnZOCnTQIFNLNScqMRFL1faV5g/Qps7O4K+
         K4vylvPwQNi9C12EOn+F++SWuDet9F1MCxyfJbFZPKHg4zLWW1FfozI82Zq85jQV6EbX
         eE+Q==
X-Gm-Message-State: AOAM532LCbD3e/Kipmng7XcOuXEdK0lsRs7WbFHHKdrWrmwBxTMZDevm
        i+2ozkP/w8MX24zlfn1r5bD6dZmDKTk=
X-Google-Smtp-Source: ABdhPJwZygI/XslaD4icMNfsKE2U3uiGTiFX2/3zLzhas8D3VOTFwmhlZbSJ270DMZkyCGim+Jl4gg==
X-Received: by 2002:a17:906:268c:: with SMTP id t12mr31849104ejc.377.1602585514174;
        Tue, 13 Oct 2020 03:38:34 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id g23sm885174edp.33.2020.10.13.03.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 03:38:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 13 Oct 2020 12:38:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
Subject: [GIT PULL v2] objtool changes for v5.10
Message-ID: <20201013103831.GB3933713@gmail.com>
References: <20201013082625.GA775379@gmail.com>
 <20201013204312.6052157d@canb.auug.org.au>
 <20201013101056.GA3933713@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013101056.GA3933713@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > This seems to be missing
> > 
> > https://lore.kernel.org/lkml/patch-1.thread-251403.git-2514037e9477.your-ad-here.call-01602244460-ext-7088@work.hours/
> > 
> > or did that get sent in a previous pull request?
> 
> No, that fix is still missing, thanks for the reminder. I overlooked it 
> thinking that it's a tooling patch - but this needs to be paired with:
> 
>   2486baae2cf6: ("objtool: Allow nested externs to enable BUILD_BUG()")
> 
> I'll send a v2 pull request in an hour or two.

Linus,

Please pull the latest objtool/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2020-10-13

   # HEAD: ab0a40ea88204e1291b56da8128e2845fec8ee88 perf build: Allow nested externs to enable BUILD_BUG() usage

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

Vasily Gorbik (2):
      objtool: Allow nested externs to enable BUILD_BUG()
      perf build: Allow nested externs to enable BUILD_BUG() usage


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
 tools/perf/Makefile.config                    |   2 +-
 38 files changed, 686 insertions(+), 411 deletions(-)
 delete mode 100644 include/linux/frame.h
 create mode 100644 include/linux/objtool.h
 create mode 100644 tools/include/linux/objtool.h
 create mode 100644 tools/objtool/arch/x86/include/arch_special.h
 create mode 100644 tools/objtool/arch/x86/special.c
