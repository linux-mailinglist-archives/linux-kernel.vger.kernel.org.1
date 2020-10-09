Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C3B2882EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgJIGqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 02:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJIGqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:46:03 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DD1C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 23:46:03 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ce10so11530640ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 23:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=70XPomHxMoYYRMOMdOG6A/Tz50BhoxBCD92mGRCZip4=;
        b=fsQxbAzysuwRMJ70jys6+VE3aYqokJ//0jBlx/TtaewIG1ig52JmPl9nXc0IMh+sHh
         /uinw9rQtctYhbPPEE6MkQMpS4mrcVF0AxeR5cSdogdNmgdQ0KImV/350fM7Vv8wZbXC
         HcYUMHjbVQLMdWkhY6MlEyEaPOnPBZI89KDCB8m3HxPdi7von8PcplPkwJjLi4epl+pW
         4jWtHDvCghYjLLrUni4eUS+irEbT+NvaukB7wZW+Jxyzaj52cIP26ciyoXGRyrUzuCpw
         9skuce0tsfsNIWSRL2+faXk/s8wiiGFGkGcywf7R9fU7gKL9XvriOLA8Qi8fqrnvWok3
         nxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=70XPomHxMoYYRMOMdOG6A/Tz50BhoxBCD92mGRCZip4=;
        b=FJj0IchpHNBGnl6cd8KoG6CldmJoCXBOwJA1xxzv47TQys1AA75ji57r1y+7/oPrxA
         azl60LohM+RFlaXfjUfZ/2tK7p1pyLoHxT3V1C9tR3Kj3srciQTuk27I/L4Blvq88O9P
         vJTbr/9lNBhCw1DRTkJqzdeZZ+S8nZ50BpkM4bgzkvpqI2RwCv5/eRpwFTdtPGg+n4oL
         qY+wsph8ggMKWadi1f8wQVdjdxoe2wC7zbj+jreyEIUAg1AVCBC5bij/xzs2d23uShmm
         ENjzUciH4v+qNuI2BPM1u/jViP+QAM4eACYFcoNOxWfblqok+72VT7CiZX2Zk/qsobIJ
         WQIw==
X-Gm-Message-State: AOAM530hTK2idHXehhVeajEOLSgpCEatQsygcVXM2C8D1/Mk+ClTT9H7
        KlE+j7W7+SMpj5asBzc3iZE=
X-Google-Smtp-Source: ABdhPJxcchqLsZGtRgggbK66Z/s+oOIQcwprZ9qZ1/EoCQHvmOEBkcuRgrj5SomXvqGLncY7weUeow==
X-Received: by 2002:a17:906:8295:: with SMTP id h21mr4648133ejx.278.1602225961802;
        Thu, 08 Oct 2020 23:46:01 -0700 (PDT)
Received: from gmail.com (563BAB65.dsl.pool.telekom.hu. [86.59.171.101])
        by smtp.gmail.com with ESMTPSA id o13sm5769383ejr.120.2020.10.08.23.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 23:46:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 9 Oct 2020 08:45:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, elver@google.com,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL kcsan] KCSAN commits for v5.10
Message-ID: <20201009064558.GC9972@gmail.com>
References: <20200914175133.GA14094@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914175133.GA14094@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello, Ingo!
> 
> This pull request contains KCSAN updates for v5.10.  These have been
> subjected to LKML review, most recently here:
> 
> 	https://lore.kernel.org/lkml/20200831181715.GA1530@paulmck-ThinkPad-P72
> 
> All of these have also been subjected to the kbuild test robot and
> -next testing.  The following changes since v5.9-rc1 are available in
> the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git kcsan
> 
> for you to fetch changes up to cd290ec24633f51029dab0d25505fae7da0e1eda:
> 
>   kcsan: Use tracing-safe version of prandom (2020-08-30 21:50:13 -0700)
> 
> ----------------------------------------------------------------
> Marco Elver (19):
>       kcsan: Add support for atomic builtins
>       objtool: Add atomic builtin TSAN instrumentation to uaccess whitelist
>       kcsan: Add atomic builtin test case
>       kcsan: Support compounded read-write instrumentation
>       objtool, kcsan: Add __tsan_read_write to uaccess whitelist
>       kcsan: Skew delay to be longer for certain access types
>       kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
>       kcsan: Test support for compound instrumentation
>       instrumented.h: Introduce read-write instrumentation hooks
>       asm-generic/bitops: Use instrument_read_write() where appropriate
>       locking/atomics: Use read-write instrumentation for atomic RMWs
>       kcsan: Simplify debugfs counter to name mapping
>       kcsan: Simplify constant string handling
>       kcsan: Remove debugfs test command
>       kcsan: Show message if enabled early
>       kcsan: Use pr_fmt for consistency
>       kcsan: Optimize debugfs stats counters
>       bitops, kcsan: Partially revert instrumentation for non-atomic bitops
>       kcsan: Use tracing-safe version of prandom
> 
>  include/asm-generic/atomic-instrumented.h          | 330 ++++++++++-----------
>  include/asm-generic/bitops/instrumented-atomic.h   |   6 +-
>  include/asm-generic/bitops/instrumented-lock.h     |   2 +-
>  .../asm-generic/bitops/instrumented-non-atomic.h   |  30 +-
>  include/linux/instrumented.h                       |  30 ++
>  include/linux/kcsan-checks.h                       |  45 ++-
>  kernel/kcsan/core.c                                | 210 +++++++++++--
>  kernel/kcsan/debugfs.c                             | 130 ++------
>  kernel/kcsan/kcsan-test.c                          | 128 +++++++-
>  kernel/kcsan/kcsan.h                               |  12 +-
>  kernel/kcsan/report.c                              |  10 +-
>  kernel/kcsan/selftest.c                            |   8 +-
>  lib/Kconfig.kcsan                                  |   5 +
>  scripts/Makefile.kcsan                             |   2 +-
>  scripts/atomic/gen-atomic-instrumented.sh          |  21 +-
>  tools/objtool/check.c                              |  55 ++++
>  16 files changed, 677 insertions(+), 347 deletions(-)

Pulled into tip:locking/core, thanks a lot Paul!

	Ingo
