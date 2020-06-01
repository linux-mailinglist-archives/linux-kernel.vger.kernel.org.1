Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436751EA465
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 15:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgFANIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 09:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgFANIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:08:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13969C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 06:08:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l10so11418087wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=T+C7UQ9KgNxjVq8cDPCK1l0QTkomQBpt8SMUpC/z7h8=;
        b=AHHgYHI/ejQkJtjkzr09U7JGjLHgEnXxNV1zcRsXDgbpx6xyBe+fYqAYK0uIvTo7QQ
         9XqifVs59GheQivTZGfd5jJ198PVb4965d8G1e4C4sIe83DNk9rnNJrpBCp5xVNbqHoU
         1ON3G9TdBPGDa3EUr6r4Uh7VzFtEjCN+dvlB7WPZ8oVj5+XWeuF0iLf4UGxftCLUck8R
         8Cu6rbdwUwW1E28MDhYcoEcOtQyD2/4qbZzjwKbvPYn89QyNROJ0zQxQjPASLLBxgza5
         4NFNxl2Wb7GAnirHmMOKjxpz2E1h9EYSnCSLnouZ0FoA0tKOiolNNd9/IgKf23TZCCTS
         i35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=T+C7UQ9KgNxjVq8cDPCK1l0QTkomQBpt8SMUpC/z7h8=;
        b=TZ/gw0k1ZOZ4DmUH/yp/ZZbUeUwf2BaK1C8CI2HXg0gm/pXphF6Lr6tfVMj0j2wMw/
         PRAOlDjiAfiPZtVdNiId4Vh15fvy2MaFnUIfoIecL/0IvghUjiAFX4tiwD0NQcXzBytM
         /pgT4oU8+UTZ1t7EqY3wJSzklp+gWmFc+4rf2DNCVjCXWb7YgVleNjrfZuJasNF2QfT9
         TuJ1oLOQLciEoWsMFyvE7EKqAYbshsapP95yW51E6K4unoPiPDSMQFtrCQoKGVQS0FTc
         an1d7FZiedZDlrNe8trH38VEFpIY55RDLRZTFEBkGvTN804WMoxWnIfC8HSQRlew2AI9
         FtfQ==
X-Gm-Message-State: AOAM532A1w+q9kwyRPtaPTJI5KlNolLQZy2eWvQ1Ptk56xBHIVg3gBKy
        XO6QNrPJZGKasY6TMntGqQfXu+Sf
X-Google-Smtp-Source: ABdhPJxlFR3vmqwJ6MEu85I5DF+XzmpyvQXfPX0ppV0QJpIMO0+dHJaiTPryhYvjdk6iUcgDFuSirQ==
X-Received: by 2002:adf:dec5:: with SMTP id i5mr19043990wrn.16.1591016888827;
        Mon, 01 Jun 2020 06:08:08 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h188sm13283846wmh.2.2020.06.01.06.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 06:08:08 -0700 (PDT)
Date:   Mon, 1 Jun 2020 15:08:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] kprobes updates for v5.8
Message-ID: <20200601130806.GA746506@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core/kprobes git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-kprobes-2020-06-01

   # HEAD: 66e9b0717102507e64f638790eaece88765cc9e5 kprobes: Prevent probes in .noinstr.text section

Various kprobes updates, mostly centered around cleaning up the no-instrumentation
logic, instead of the current per debug facility blacklist, use the more generic
.noinstr.text approach, combined with a 'noinstr' marker for functions.

Also add instrumentation_begin()/end() to better manage the exact place in entry
code where instrumentation may be used.

Also add a kprobes blacklist for modules.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Masami Hiramatsu (4):
      kprobes: Lock kprobe_mutex while showing kprobe_blacklist
      kprobes: Support __kprobes blacklist in modules
      kprobes: Support NOKPROBE_SYMBOL() in modules
      samples/kprobes: Add __kprobes and NOKPROBE_SYMBOL() for handlers.

Thomas Gleixner (2):
      vmlinux.lds.h: Create section for protection against instrumentation
      kprobes: Prevent probes in .noinstr.text section


 arch/powerpc/kernel/vmlinux.lds.S   |  1 +
 include/asm-generic/sections.h      |  3 ++
 include/asm-generic/vmlinux.lds.h   | 10 +++++
 include/linux/compiler.h            | 53 +++++++++++++++++++++++
 include/linux/compiler_types.h      |  4 ++
 include/linux/module.h              |  8 ++++
 kernel/kprobes.c                    | 85 ++++++++++++++++++++++++++++++++++++-
 kernel/module.c                     | 10 +++++
 samples/kprobes/kprobe_example.c    |  6 ++-
 samples/kprobes/kretprobe_example.c |  2 +
 scripts/mod/modpost.c               |  2 +-
 11 files changed, 180 insertions(+), 4 deletions(-)
