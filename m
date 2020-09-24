Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B912769C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgIXG4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgIXG4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:56:10 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD42AC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 23:56:10 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r2so1505639pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 23:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=FX0p/GcmPpR3We5nTHUDyc9BUTZhvYJ9+N0VF4ja3D0=;
        b=A6fOq1HOlUuYS2ejjODUD35m8TFnAilniB8q/he/79yXRI6J7NI/5Ni7kHBCvEkC2m
         lcXuePvKeAjjCDD7fCMEPX38aVIXcuUWP+W4OMSy0zBk2sxHJx8ra7LETRsT0HIRDyye
         xSwf61KUpd7wPrXq18JauwkfZwXsMB8awli9ljDrb5XWJlKwH3mlcV56ZLOVPibIG4Ic
         o/eVdv/JTMLjilq0gn9LEnIdeugRCiuR9+nExc8TyYrfq2ju1CexD/xlhgumusLgQp7o
         XRzmYIJmWMncSaLiHbfMQfFKTa0htqvMutDnKpI3x/vLO5QTmvQvgoeB0YAL5ijGpOW3
         0CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=FX0p/GcmPpR3We5nTHUDyc9BUTZhvYJ9+N0VF4ja3D0=;
        b=c0d4XzHie0ch+IQKYwgSTA0ODqsj4HOxsKO8vZktgxX0bSgr+1nMBDwxXhs/WidGSa
         Mv/y37Wpl8BE8209vuWUyLNLAoFz3glFj+98mBflpEVa0/ZUKmWQ3iDvxr1wh+KdJwig
         3d3N6f8pjKgXqPpvOZ7VaeYNcbYbv5ogtzwYdCdSfdL2HUFi5u8Drl/pA6dQxae8RQ+F
         YQFiZglZ1OheOFT8RoaCKY5bY6u2vgcYca+mu9mJXxspGr1WtV+LhVG8AnqOZu6Bzb2K
         qKkyeHJ9dMmlIrnZkRq83S6O/7gjU/469dKcNAnhyTKR+cHlUW30AK/LnVR9hWjW56ZR
         SC1w==
X-Gm-Message-State: AOAM531wvkLNnuPjtbIJQuKmTdurfpAfIRJVCOeMARXjftTYyVo72xAV
        wv4I48rDTskvJtkwzFwMYC5j3YBgYsTN3+kwkg==
X-Google-Smtp-Source: ABdhPJwhRa38PHwfQdB4AKI0fOgdNDJYzEpWP8u7QkJdKT8QhABjPf/lE453ktfsBvnzt0vFPv5CAiF1JPyJRhzdTA==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a17:902:82c2:b029:d1:f36a:ab97 with
 SMTP id u2-20020a17090282c2b02900d1f36aab97mr3356719plz.64.1600930570089;
 Wed, 23 Sep 2020 23:56:10 -0700 (PDT)
Date:   Wed, 23 Sep 2020 23:56:04 -0700
Message-Id: <20200924065606.3351177-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v4 0/2] Control over userfaultfd kernel-fault handling
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kaleshsingh@google.com,
        calin@google.com, surenb@google.com, nnk@google.com,
        jeffv@google.com, kernel-team@android.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is split from [1]. The other series enables SELinux
support for userfaultfd file descriptors so that its creation and
movement can be controlled.

It has been demonstrated on various occasions that suspending kernel
code execution for an arbitrary amount of time at any access to
userspace memory (copy_from_user()/copy_to_user()/...) can be exploited
to change the intended behavior of the kernel. For instance, handling
page faults in kernel-mode using userfaultfd has been exploited in [2, 3].
Likewise, FUSE, which is similar to userfaultfd in this respect, has been
exploited in [4, 5] for similar outcome.

This small patch series adds a new flag to userfaultfd(2) that allows
callers to give up the ability to handle kernel-mode faults with the
resulting UFFD file object. It then adds a 'user-mode only' option to
the unprivileged_userfaultfd sysctl knob to require unprivileged
callers to use this new flag.

The purpose of this new interface is to decrease the chance of an
unprivileged userfaultfd user taking advantage of userfaultfd to
enhance security vulnerabilities by lengthening the race window in
kernel code.

[1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
[2] https://duasynt.com/blog/linux-kernel-heap-spray
[3] https://duasynt.com/blog/cve-2016-6187-heap-off-by-one-exploit
[4] https://googleprojectzero.blogspot.com/2016/06/exploiting-recursion-in-linux-kernel_20.html
[5] https://bugs.chromium.org/p/project-zero/issues/detail?id=808

Changes since v3:

  - Modified the meaning of value '0' of unprivileged_userfaultfd
    sysctl knob. Setting this knob to '0' now allows unprivileged users
    to use userfaultfd, but can handle page faults in user-mode only.
  - The default value of unprivileged_userfaultfd sysctl knob is changed
    to '0'.

Changes since v2:

  - Removed 'uffd_flags' and directly used 'UFFD_USER_MODE_ONLY' in
    userfaultfd().

Changes since v1:

  - Added external references to the threats from allowing unprivileged
    users to handle page faults from kernel-mode.
  - Removed the new sysctl knob restricting handling of page
    faults from kernel-mode, and added an option for the same
    in the existing 'unprivileged_userfaultfd' knob.

Lokesh Gidra (2):
  Add UFFD_USER_MODE_ONLY
  Add user-mode only option to unprivileged_userfaultfd sysctl knob

 Documentation/admin-guide/sysctl/vm.rst | 15 ++++++++++-----
 fs/userfaultfd.c                        | 12 +++++++++---
 include/uapi/linux/userfaultfd.h        |  9 +++++++++
 3 files changed, 28 insertions(+), 8 deletions(-)

-- 
2.28.0.681.g6f77f65b4e-goog

