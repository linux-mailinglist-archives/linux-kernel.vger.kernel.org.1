Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A6728FC73
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404213AbgJPCke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393798AbgJPCke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:40:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04B0C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:40:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d3so1203417wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNg9gdtOimOEmy67mW+pkldAwxnCexLnxFi/MBHN1vk=;
        b=aPhBlVnoxNeangGzBxkmAwQqBlVG1XkorAVly+WceoAu9XKHWE1pUpAeqWbG/mZc3C
         wFz96+1DHR8RaYWLWO+gbTblSAYA4jLfwKqQ7FRXVDQgpuz5b3TGQWi7/GjcQ5q1CneC
         Wz+RCRQSV2AhzyIWNSHH4JA0XIWC8kV8hDnJNUfyqJOEXphkaY3Z07xisXOy0iw8Dmch
         kddGQarACTIWPQ+cFIjXBRsM5Xo7kJrDYT8sLMtEn2Q7NyONlILIFG2QYW58Cc+zFZ2b
         8M/4AaN5EvPrL0R8japtzsoYFrUgHamvic2aq9xbu3b4f5mopT+9288px6NCKsJevxWt
         YEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNg9gdtOimOEmy67mW+pkldAwxnCexLnxFi/MBHN1vk=;
        b=I1sz0VIwBft1TDdzYGuFrNrCgW12Ui779ZJNlpzQ0sIrE2uQvtqp2wzwINJZBG01KL
         s7nLxOtEB1EKjxlMh3IyqK+lb4f4JAgeYo/kI95Dv/4TQY2eEzsmc6CS9db4Pb0QrEgq
         RH2nkCki6VCJkwdunbEAfefAEaD+O60klIQO39OuQrnlVLCre+44LjWHNd18uxKk/P/T
         QdjHPWqmg0pkHcB++zky7jBK2U3pkb7YbLL+CnRw+3Ob/MocSoB5LC1E08YoGnt61GTT
         KE2jf7/Spb4bchEBt4ho4rRqDCFAUlGO29K2oV4UPkMk8OI84Vf4qgPe7Qj5ovgRd4Il
         vU7Q==
X-Gm-Message-State: AOAM530VfEw3/udVJg+ltj+OGSstAH4s8Z9Tju8++bwQTiPNaExOd9yD
        SC2plgpRTPj1MWjzhBqYG6KTMA==
X-Google-Smtp-Source: ABdhPJzD+bOH8x5fO1yOkPLHWHIArFrbRAcn1rQ8FK0AVgEKXfhq3EEN4vCsMHAjfpsAZtqjocIDcg==
X-Received: by 2002:a1c:b78a:: with SMTP id h132mr1408258wmf.172.1602816032498;
        Thu, 15 Oct 2020 19:40:32 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id a17sm1549902wra.29.2020.10.15.19.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 19:40:31 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH 0/6] mm and ptrace: Track dumpability until task is freed
Date:   Fri, 16 Oct 2020 04:40:13 +0200
Message-Id: <20201016024019.1882062-1-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, there is a lifetime issue (no, not the UAF kind) around
__ptrace_may_access():

__ptrace_may_access() wants to check mm->flags and mm->user_ns to figure
out whether the caller should be allowed to access some target task.
__ptrace_may_access() can be called as long as __put_task_struct()
hasn't happened yet; but __put_task_struct() happens when the task is
about to be freed, which is much later than exit_mm() (which happens
pretty early during task exit).
So we can have a situation where we need to consult the mm for a
security check, but we don't have an mm anymore.

At the moment, this is solved by failing open: If the mm is gone, we
pretend that it was dumpable. That's dubious from a security
perspective - as one example, we drop the mm_struct before the file
descriptor table, so someone might be able to steal file descriptors
from an exiting tasks when dumpability was supposed to prevent that.

The easy fix would be to let __ptrace_may_access() instead always refuse
access to tasks that have lost their mm; but then that would e.g. mean
that the ability to inspect dead tasks in procfs would be restricted.
So while that might work in practice, it'd be a bit ugly, too.

Another option would be to move the dumpability information elsewhere -
but that would have to be the task_struct (the signal_struct can be
shared with dead pre-execve threads, so we can't use it here). So we'd
have to keep dumpability information in sync across threads - that'd
probably be pretty ugly.


So I think the proper fix is to let the task_struct hold a reference on
the mm_struct until the task goes away completely. This is implemented
in patch 1/6, which is also the only patch in this series that I
actually care about (and the only one with a stable backport marking);
the rest of the series are some tweaks in case people dislike the idea
of constantly freeing mm_structs from workqueue context.
Those tweaks should also reduce the memory usage of dead tasks, by
ensuring that they don't keep their PGDs alive.


Patch 1/6 is not particularly pretty, but I can't think of any better
way to do it.

So: Does this series (and in particular patch 1/6) look vaguely sane?
And if not, does anyone have a better approach?


Jann Horn (6):
  ptrace: Keep mm around after exit_mm() for __ptrace_may_access()
  refcount: Move refcount_t definition into linux/types.h
  mm: Add refcount for preserving mm_struct without pgd
  mm, oom: Use mm_ref()/mm_unref() and avoid mmdrop_async()
  ptrace: Use mm_ref() for ->exit_mm
  mm: remove now-unused mmdrop_async()

 arch/x86/kernel/tboot.c    |  2 +
 drivers/firmware/efi/efi.c |  2 +
 include/linux/mm_types.h   | 15 ++++++-
 include/linux/refcount.h   | 13 +-----
 include/linux/sched.h      |  8 ++++
 include/linux/sched/mm.h   | 13 ++++++
 include/linux/types.h      | 12 +++++
 kernel/exit.c              |  2 +
 kernel/fork.c              | 90 +++++++++++++++++---------------------
 kernel/ptrace.c            | 10 +++++
 mm/init-mm.c               |  2 +
 mm/oom_kill.c              |  2 +-
 12 files changed, 105 insertions(+), 66 deletions(-)


base-commit: bbf5c979011a099af5dc76498918ed7df445635b
-- 
2.29.0.rc1.297.gfa9743e501-goog

