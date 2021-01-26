Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF9303A75
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404209AbhAZKg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbhAZBpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:45:45 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC75AC06121D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:44:54 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id o20so5595399qtx.22
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=RFyynjEhCzTeLq+y8WtSlGf8pxOgQbpPHEh/FpBfP5A=;
        b=iAuLyhDoPPaR+iBfrCsuixnbCKhF9IpHZJ3XvgDP5rCpl/DjpJ0797uJJkHozUi4yr
         4zm1qB6ZVdbv6OpxeFpgxERdlqq2vTIvZd+KT9PPHSqbStWSa1V06EI0BOtGzd6BCjgu
         Uv6VBUUsJs9j7iIPlhZMlK2WjsEgmuE6QpAPczA2ALDETYbI2xLzXoM3KHcBWodjy6u3
         e3hkaWiH8Ozo2/fgOYUt60M/dnBfBdVs05x3ZqlUZ7AR131kMxiyVexNdQTc+TDNQdt4
         cDEDiEi3cWYsNN5vIXXy36CHrNQYmYgvE/kGR8TfsUr2eeSvsLWe+3LSHrhHR8WvyYNR
         4uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=RFyynjEhCzTeLq+y8WtSlGf8pxOgQbpPHEh/FpBfP5A=;
        b=r2RRO92BkZhscNGmZbxmyS14XkIzekWsoGZWLfAnQCbFUY+F2wILRBgpIOa74lxZcQ
         Hw6vSyhQIcwOPXGVOUgOHeQ++L4TXqFVI38gKJBzblzZgPlS3joJzjd9Vz97lxFGWNpN
         DyjvrCzLY5GwmZikKuFH5ug+CxS5mVz7HyIwv7toKrcQ9oQsv3g0nGKqGHQuQyQ38moS
         S7DF8juT9lao2hVwTj+dvmzM0p5rSCA9MrXCtzdomuxN5OEOilnEfL9gVGlKSnYJJ3Qg
         D5rr+Gd4fGTepMWR9ZhNnf6KqC560BClfcx7rXzNyUHhgTSLgwXxpmA36a0Nfj8Oe0UE
         i+AA==
X-Gm-Message-State: AOAM531nQwdGfGv0WmdL+bYxzzGyJwkUf3DvkOYN2gJMc+Uz0bqqPS17
        9bd2yjaWG5jcejFC+UgJ5T5+8ODmTmQV9sHx6A==
X-Google-Smtp-Source: ABdhPJzaBZXmBVJGMCga25pPR6kIF8vsANdIpzt2uKr+xQCEITfXmqdv99wy6fpaIyPSgkyGWTy2vdJpsogBfsdZtg==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a0c:ca8e:: with SMTP id
 a14mr385208qvk.58.1611625494076; Mon, 25 Jan 2021 17:44:54 -0800 (PST)
Date:   Mon, 25 Jan 2021 17:44:50 -0800
Message-Id: <20210126014450.1901335-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v1] userfaultfd.2: Add UFFD_USER_MODE_ONLY flag
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     linux-man@vger.kernel.org
Cc:     Daniel Colascione <dancol@dancol.org>,
        linux-kernel@vger.kernel.org, kaleshsingh@google.com,
        calin@google.com, surenb@google.com, jeffv@google.com,
        kernel-team@android.com, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.kernel.org, Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of UFFD_USER_MODE_ONLY flag to userfaultfd(2) manual
page, which is required after [1]. Also updated the description of
unprivileged_userfaultfd file in proc(5) as per [2].

[1] https://lore.kernel.org/linux-mm/20201215031349.NXimL388W%25akpm@linux-foundation.org/
[2] https://lore.kernel.org/linux-mm/20201215031354.gUsHJUpKo%25akpm@linux-foundation.org/

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 man2/userfaultfd.2 |  5 +++++
 man5/proc.5        | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
index e7dc9f813..792a49d52 100644
--- a/man2/userfaultfd.2
+++ b/man2/userfaultfd.2
@@ -72,6 +72,11 @@ See the description of the
 .BR O_NONBLOCK
 flag in
 .BR open (2).
+.TP
+.BR UFFD_USER_MODE_ONLY " (Since Linux 5.11)"
+Allow handling of user-mode page-faults only. See the description of the
+unprivileged_userfaultfd file in
+.BR proc (5).
 .PP
 When the last file descriptor referring to a userfaultfd object is closed,
 all memory ranges that were registered with the object are unregistered
diff --git a/man5/proc.5 b/man5/proc.5
index f16a29d6e..cb2350c0c 100644
--- a/man5/proc.5
+++ b/man5/proc.5
@@ -5905,6 +5905,18 @@ If this file has the value 0, then only processes that have the
 capability may employ
 .BR userfaultfd (2).
 The default value in this file is 1.
+.IP
+Starting with Linux 5.11,
+.BR userfaultfd (2)
+can be used by all processes, however, if this file has the value 0, then
+.BR UFFD_USER_MODE_ONLY
+flag must be passed to it, which restricts page-fault handling to only
+user-mode faults. This restriction is not applicable for processes with
+.B CAP_SYS_PTRACE
+capability, or if this file has the value 1. Furthermore, the default
+value in this file is changed to 0. For further details see the
+Linux kernel source file
+.I Documentation/admin\-guide/sysctl/vm.rst.
 .TP
 .IR /proc/sysrq\-trigger " (since Linux 2.4.21)"
 Writing a character to this file triggers the same SysRq function as
-- 
2.30.0.280.ga3ce27912f-goog

