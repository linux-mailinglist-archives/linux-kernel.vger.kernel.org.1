Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8522299860
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 22:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgJZVA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 17:00:59 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:54953 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbgJZVA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:00:58 -0400
Received: by mail-pg1-f201.google.com with SMTP id c21so6146285pgi.21
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=8XFAGaMnZpaYT0ztE4+ED+zm8jGUSJs5c4zzKttTIPI=;
        b=Pxi/eqHudvziXWScDyXkpvDK2QiIuvHS43rBVL+Xc70/Q5dzLbbxPT40atX3PLqd6o
         dt9KJrBnICKVwr2NPng1LbI91rutUvaFzl1aozHG4HWDaRt7KhMYDAMmF6aDpxi7XDOk
         QT2H3OusQXLTq3dTB30XF2gqpXpXBdHCpNyaj577OVJMu9CSNnnppB2U1z1+o6lHcOvZ
         hWqD7IR8U14Mb86Cp4dMZKfsJ6/lDq6Ysaa7GKnVsTghUKku11fCzFnBpox4cDb6ReLG
         Q6NUHNqunaSvXXK+IKxly7q+I5MTyAjJHGABlKn21sCz5g4Sn/TxGU86GcXbDF26gmpN
         eHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=8XFAGaMnZpaYT0ztE4+ED+zm8jGUSJs5c4zzKttTIPI=;
        b=ag85yxSaeJqp8YLVjPR8+AFkQwaI3OrQ2rng4l3sd6Ptyl/NsYDSF9iNbVnYji0QHD
         hfvAMnNhwsbvdm64yiKKEWmEWICj+rZv6qLnkaY8ucdEgV+dhnJ2gce98+0T+yxe+P1A
         ygqP0Og3pJoZcoYyT9AZ7AIbDsmOCf0FfY4SjTQLSjYsywh3kcksW5MKsftiA3XYtG8p
         k7FgwKHqg+XJ6RPgCMPa+5ks8UyuI8ICdAv8GonhgG0ktHHV1kRmQ49Vhbwv+m91XjFr
         8tmMwEywybsK+CuDNi+5p+KM6ZHaU1UwrAyJ0ajWJtJdhRmXNrIFfcBM73WLk/KKWu3l
         5clg==
X-Gm-Message-State: AOAM530zSfc4RWFsAkw/4YD6KNJma8NVrYi4HOYYxF+/tTb2TTqPJhDq
        ux+dft5VgAGlrE0hpYAQ6XtGcudb+QMTMSA6Cw==
X-Google-Smtp-Source: ABdhPJzoCc1eQDlxMsW2Ajct/JrdoHj+uuvNDeZHvYEyQxfSbIe9/4p6t0jstELt4ujFjAMh69PODMXwUc1F7f+XtA==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a17:90a:2e05:: with SMTP id
 q5mr1854369pjd.0.1603746056083; Mon, 26 Oct 2020 14:00:56 -0700 (PDT)
Date:   Mon, 26 Oct 2020 14:00:50 -0700
Message-Id: <20201026210052.3775167-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v6 0/2] Control over userfaultfd kernel-fault handling
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

Changes since v5:

  - Added printk_once when unprivileged_userfaultfd is set to 0 and
    userfaultfd syscall is called without UFFD_USER_MODE_ONLY in the
    absence of CAP_SYS_PTRACE capability.

Changes since v4:

  - Added warning when bailing out from handling kernel fault.

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
 fs/userfaultfd.c                        | 20 +++++++++++++++++---
 include/uapi/linux/userfaultfd.h        |  9 +++++++++
 3 files changed, 36 insertions(+), 8 deletions(-)

-- 
2.29.0.rc1.297.gfa9743e501-goog

