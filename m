Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A788286799
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgJGSoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgJGSoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:44:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3523DC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 11:44:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n13so3038741ybk.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=zaTrRhcNQbiBSpttX9+h0ylDutyOhlEu02pPakoZbW0=;
        b=YQmXL1IZZfWvBoigW7dnIOCgKdPdKbs1IAN19ARXkt7TgYzwNcEC2yEsvc5FjOWAkp
         CKmwEH6f+lh1SbFEMeLVJoaJe7M/SwbpvDvHfXA5cRclXz5oME2rL7DascOisCpTzalG
         I0D4L1Jf5J93lTvfG6HnetmqyGHn0zb0qWXtMlZO9xkHCXMG/tHP7KGQTct4c6QcmJii
         aA4u0rbJ59m5ayhtR+gDpMF3cbIBH+OVAncil2i0XVTAvswL5a2sD+BetVSR6TJHFfYK
         e15+Ng5AWijdmur7mDmiydhceia3L1KdV2R+/BSlqL5GEILZ5ZpF2edZUee0Sna7J48w
         RlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=zaTrRhcNQbiBSpttX9+h0ylDutyOhlEu02pPakoZbW0=;
        b=aK8WMZstMnJh+npKbRhGb93BLiyU4+GcTJ/MRQqVC2CQM3WZoUAnLP54r1I+OA047e
         MRzQwow53PgEuWIeOr7L42QMYVHbD+vOG4xrwsfGXAfFM3xhwAHiqIoden4yDkktfnc7
         H/v+WoayC0Df0UfZEkb4BQo40wgXTKx5mzi5zPLkaks4gSyYs9QmlNUqc/honM7aWra+
         VxzK5Kl7l5Yl1Iyjeusz8Bk6+uEFjKIk+Z20GdihPpWQND7STfJKUnCnkfKgZ5ZUnW3X
         cWzrLBL7VCZKUWs8nB6tZFPPh9lbyAII+r6LczdbZ3VI3E2DTGGBgmWRvcOUEy7lMpZO
         cq2A==
X-Gm-Message-State: AOAM531vwHWpbruZE60XDhN50XbXPstKxB2vjPXBrpC99d5bkjQPPDMr
        0rtmzFQ9/ioGJgv/m9rkgqQ7DD04ygbaBl1FNl0/
X-Google-Smtp-Source: ABdhPJyAOvITISF0mCmeqoWdYBJRP5GPqkaRIfi/Wq6RwIQm9LoTCHtGG3kUbh6S6DCeTSQ8dqoqRMpGoRWyqTPxreXV
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a25:6811:: with SMTP id
 d17mr5719921ybc.62.1602096249437; Wed, 07 Oct 2020 11:44:09 -0700 (PDT)
Date:   Wed,  7 Oct 2020 11:44:01 -0700
Message-Id: <20201007184403.1902111-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v2 0/2] Add tracepoints around mmap_lock acquisition
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds tracepoints around mmap_lock acquisition. This is useful so
we can measure the latency of lock acquisition, in order to detect contention.

This version is based upon linux-next (since it depends on some recently-merged
patches [1] [2]), and incorporates feedback from the review of the previous
version:

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

Axel Rasmussen (2):
  tracing: support "bool" type in synthetic trace events
  mmap_lock: add tracepoints around lock acquisition

 include/linux/mmap_lock.h         | 112 +++++++++++++++++++++++++++---
 include/trace/events/mmap_lock.h  |  70 +++++++++++++++++++
 kernel/trace/trace_events_synth.c |   4 ++
 mm/Makefile                       |   2 +-
 mm/mmap_lock.c                    |  87 +++++++++++++++++++++++
 5 files changed, 265 insertions(+), 10 deletions(-)
 create mode 100644 include/trace/events/mmap_lock.h
 create mode 100644 mm/mmap_lock.c

--
2.28.0.806.g8561365e88-goog

