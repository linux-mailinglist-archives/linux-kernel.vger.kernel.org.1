Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9909229CC92
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 00:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832919AbgJ0XHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 19:07:18 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:33762 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832911AbgJ0XHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 19:07:17 -0400
Received: by mail-yb1-f201.google.com with SMTP id c196so3182905ybf.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 16:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=I/LBifM/+WVHaRpaxKjR0QAKC1O3x8QI4e1T4nSFr0M=;
        b=KbVPBhA9IiQ+iud7lnAC/gSuu6WvRf9aYf5QWO+OJgEdMx92YhzKAbart8/hS+gKnN
         qaWsNPtp5BCWJbEn3RH2tFaOmOM1NMqaPTaSCMX7zmcCXI5hF3JNxRNIJe88AWPQIzux
         3sTiZbTGZeTBqw4f3UwdQP8qOsY4EM/27qldD8WxxcpZ9++cKDzFfQndMXW2EWc+65cx
         Hopb9gepeI7m5/mlFNBO6BjKizn/IncT1qXMdGECSc9r5oL6ntZ7xr7B/mFNXqLug+7J
         HyjpRjJUj9QklUKDUy+byNGFAOzEDHuj8KT68tp8ON8gzR0KRX9UI5B5iokTW/HzrCD4
         FazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=I/LBifM/+WVHaRpaxKjR0QAKC1O3x8QI4e1T4nSFr0M=;
        b=kwaBqPSu8CIfKLJoEV3lm9mo3f7pZwU3cejD6qJiuIxLKDtsE0wCtoetAIUE9Ne9K3
         kbXVbn4Lse4Eiju22bnylS4H12hzehTbvG99xB0B784GRB1rh6Icp21ADdvjpwcfdDPo
         IwLVnpJzkTPHEDWkr+u2ebkGOzuClBihVGIP5XLqlGeN8WrbFQmqzigNorJuUi2chWs0
         gPZ2r1pYlE4EJ1hdP0+T7sZlx9LLTzbbEOh+qOKbJTM2ffoE3apJZDN+XriK7O9EwzAL
         GuLu1t71DaVyEKmG0F4JpsSnNoZfVCrS4PJs/RkuimZMq6hMBGT1WgtQ41oH8rni7Lhv
         ik0g==
X-Gm-Message-State: AOAM531nZKRgcsP9usjVEoG5s/fd/JUjIMkpt7Nty0qDBsLsrcwwCO/X
        uRiRSxOmNg08vDMstxqppMXaTrTb1V0a5N2Wdgc8
X-Google-Smtp-Source: ABdhPJwSnCSOzg2YHYNimogzE/KLllYmDLWuCJeCvRlDF7bWaV1OVkBfKGXl63pROwxs+ucCBvoczfPuZfJD/QkyMHmw
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a25:8091:: with SMTP id
 n17mr6600207ybk.291.1603840034996; Tue, 27 Oct 2020 16:07:14 -0700 (PDT)
Date:   Tue, 27 Oct 2020 16:07:10 -0700
Message-Id: <20201027230711.2180435-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH v5 0/1] mmap_lock: add tracepoints around lock acquisition
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

This version is based upon linux-next (since it depends on some recently-merged
patches [1] [2]).

I removed the existing {Reviewed,Acked}-by: lines from v4, since I think the
patch has changed significantly enough to warrant another look (and I figure
it's better to err in this direction in any case :) ).

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

 include/linux/mmap_lock.h        |  95 +++++++++++++++-
 include/trace/events/mmap_lock.h | 107 ++++++++++++++++++
 mm/Makefile                      |   2 +-
 mm/mmap_lock.c                   | 187 +++++++++++++++++++++++++++++++
 4 files changed, 385 insertions(+), 6 deletions(-)
 create mode 100644 include/trace/events/mmap_lock.h
 create mode 100644 mm/mmap_lock.c

--
2.29.0.rc2.309.g374f81d7ae-goog

