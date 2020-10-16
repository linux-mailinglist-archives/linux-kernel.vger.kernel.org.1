Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10506290DF9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 01:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407660AbgJPXJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 19:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407010AbgJPXJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 19:09:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9064CC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:09:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so4637339wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 16:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jTe2yM9MxVhTrRdmKwL9Wwkl5X/2QK8pL2bJ3R7EOUI=;
        b=Xm1tybRYP076OiQR+/pHfTWF1G+ibHMTo4J+kOVzkkLTFFwHVvKepGLA7Tqum0TilH
         Le9ss7vtK3Gy6C1mpCA2Ypfp2Bu7K2/3FKf6MT5b01WXADL/QnsjPiIN+3FzAFh2T73e
         OrSCGyetLSK+1mjRKcXHRd8xZf6Eoe2JVuvBSqUHx7ZN4sTWSmkPUNAp1grXXPlSrq9+
         bOeORmET7UNEhsfUwmhAxZa8UC1gujD0bKWgc7gR55cL/b9x9oDJI0COrUMxq3cGaixY
         2hWJZTqnaq15Z88hUuyIKKe9xkukjrJl8TEJJsTGSNdvO/AJMACjzpF2YRutg1jUaL5G
         JQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jTe2yM9MxVhTrRdmKwL9Wwkl5X/2QK8pL2bJ3R7EOUI=;
        b=nPauN0CBeAIwc197i+OMBj3G8tNnMbzEJMdHsfyYHDIAg+BNr/w/jFGZJRhnHEmRLx
         Na1uiREH+YFr/aFrv442xvqPVX/vrnU8Udcc+l9zm3Vyf5KOwz2SbDRBXpsZV7nxkHvq
         J6Gp4t4yocC2oJkUKEqmbHfspD6OqgoAEXFpwq4lRy55G3Gc3ITfFAyQZWmEgTZWTiOr
         015JOnkxFlqDXLl61U0Xj9PDoTV6uuR5LqIvpKywg5Vmwg6KDve1giPcN5ylRWRwHjBG
         Dr22yQhqGn6HfH0Yr9wARghxFD3txcMN//aSjcL9qA+ubHHZ7+3d8g4Gu/D7KLZXcI6w
         9ClA==
X-Gm-Message-State: AOAM530piieR3q5UhNW9acoPTij0djCMAkr7EwmH1wC6O14rYK8sZCBM
        /bug85Z0d1EhxxSuDo2L5NncmQ==
X-Google-Smtp-Source: ABdhPJyHb3io1WzS7Ad+62Dhh+ev7B30uujM+fePi4lCBeDT31mPCbn8zrbgi/huCJBRUvhDMIxiow==
X-Received: by 2002:a1c:152:: with SMTP id 79mr5954225wmb.60.1602889775091;
        Fri, 16 Oct 2020 16:09:35 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id v4sm4504518wmg.35.2020.10.16.16.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:09:33 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH resend 0/6] mm and ptrace: Track dumpability until task is freed
Date:   Sat, 17 Oct 2020 01:09:09 +0200
Message-Id: <20201016230915.1972840-1-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry, had to resend - it was pointed out to me that when I sent
this series the first time, DKIM got broken by the kvack list
rewriting 8-bit into quoted-printable]

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
--=20
2.29.0.rc1.297.gfa9743e501-goog

