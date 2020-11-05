Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2442A88CB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbgKEVRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:17:47 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F1FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 13:17:47 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id d21so1773129qtp.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 13:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=CWQ9UWAzLNf25Gm+QM5JO9SZkGZbnesBYaj1Ii23SGw=;
        b=ntxuuYSIC//Ipv5nwAlhlbI0u2ggda1uKlvsAZpzhngQvdJ5Euw0QzjPIzMUnqk711
         xPRn/iciXDVVRfKK+PBec4MFO87PHwxvg0uMnVYNNVa3jSMq6YyuRmjhHHglUk1Exnxe
         iB6/5Ctz+2u/X1VxprIqJeLyV/G/968LJ16ay5VUty5Br/gG1FDTWEQUT8xWe2Lgnc21
         9ZOCpcgjpEAjGVQ2g+e5vAO0FCz2eCrdVp/VzKWtTEnaCXxReKaJ7A6kULLy2l3VlUA0
         9jjqv5XxPm4Qp7Ix5Dk7as94TeIo+0G0gIfqTT6nyNB0M5iRtbov7p8qLpcijJzqeGdD
         Nz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=CWQ9UWAzLNf25Gm+QM5JO9SZkGZbnesBYaj1Ii23SGw=;
        b=tT8JMTcVNMZ7wrdq+TNBdCjQyMK4Wz/UJK0PV7V3EG4y5FnH5SnlrHDyOHmaduRoRK
         jCNPvSfT4BgFNuy/hUJh3MkfwT6U5vr4676pqNU1Tp7scMqcTKlaRfPY6egMdhSGObl8
         k4xBb7jsdbpO12R0EiS/cfVA1J1s1rGriuTq3jrTiP1cQrFsfVw7mnadoMfrNygHfG/t
         YS+zsycAA/u8J0TSCvUEu6V8ZH/TrQHH46kECvaLoZPVC3g+TfSZHR0UOxnxbmxtWWmr
         +fRhAFi98wfp02jGAtZonFOp1v/ARDBbXo3HlBmM8L4rZpyiLwZyk1EcdfzTLoozL8DM
         Yl+A==
X-Gm-Message-State: AOAM530OrKWjhWiTY4oSdRj6JsdoQyw58tQyTKyFLI4OeUpzn0gI2XKQ
        GSbHDe5gLwAxxQiNxve5mausCVBA5ITsiDtcQaok
X-Google-Smtp-Source: ABdhPJxpCI0j/7GQ1w8tNdmeM3i5b0/jhF/8/xh2whMjpj6P07qokJapGr3eV5NRC9G5uhsSSWqiOoVRYrNepOwWYpLj
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:4041:: with SMTP id
 r1mr2103637qvp.49.1604611066573; Thu, 05 Nov 2020 13:17:46 -0800 (PST)
Date:   Thu,  5 Nov 2020 13:17:38 -0800
Message-Id: <20201105211739.568279-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 0/1] mmap_lock: add tracepoints around lock acquisition
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        David Rientjes <rientjes@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds tracepoints around mmap_lock acquisition. This is useful so
we can measure the latency of lock acquisition, in order to detect contention.

This version is based on v5.10-rc2.

Changes since v5:

- Michel pointed out that rwsem_release in mmap_read_trylock_non_owner doesn't
  actually release the lock, it just releases lockdep's ownership tracking. So,
  it's incorrect to call __mmap_lock_trace_released there, so the call has been
  removed.

Changes since v4:

- Redesigned buffer allocation to deal with the fact that a trace event might be
  interrupted by e.g. an IRQ, for which a per-cpu buffer is insufficient. Now we
  allocate one buffer per CPU * one buffer per context we might be called in
  (currently 4: normal, irq, softirq, NMI). We have three trace events which can
  potentially all be enabled, and all of which need a buffer; to avoid further
  multiplying the number of buffers by 3, they share the same set of buffers,
  which requires a spinlock + counter setup so we only allocate the buffers
  once, and then free them only when *all* of the trace events are _unreg()-ed.

Changes since v3:

- Switched EXPORT_SYMBOL to EXPORT_TRACEPOINT_SYMBOL, removed comment.

- Removed redundant trace_..._enabled() check.

- Defined the three TRACE_EVENTs separately, instead of sharing an event class.
  The tradeoff is 524 more bytes in .text, but the start_locking and released
  events no longer have a vestigial "success" field, so they're simpler +
  faster.

Changes since v2:

- Refactored tracing helper functions so the helpers are simper, but the locking
  functinos are slightly more verbose. Overall, this decreased the delta to
  mmap_lock.h slightly.

- Fixed a typo in a comment. :)

Changes since v1:

- Functions renamed to reserve the "trace_" prefix for actual tracepoints.

- We no longer measure the duration directly. Instead, users are expected to
  construct a synthetic event which computes the interval between "start
  locking" and "acquire returned".

- The new helper for checking if tracepoints are enabled in a header is used to
  avoid un-inlining any of the lock wrappers. This yields ~zero overhead if the
  tracepoints aren't enabled, and therefore obviates the need for a Kconfig for
  this change.

[1] https://lore.kernel.org/patchwork/patch/1316922/
[2] https://lore.kernel.org/patchwork/patch/1311996/

Axel Rasmussen (1):
  mmap_lock: add tracepoints around lock acquisition

 include/linux/mmap_lock.h        |  94 +++++++++++++++-
 include/trace/events/mmap_lock.h | 107 ++++++++++++++++++
 mm/Makefile                      |   2 +-
 mm/mmap_lock.c                   | 187 +++++++++++++++++++++++++++++++
 4 files changed, 384 insertions(+), 6 deletions(-)
 create mode 100644 include/trace/events/mmap_lock.h
 create mode 100644 mm/mmap_lock.c

--
2.29.1.341.ge80a0c044ae-goog

