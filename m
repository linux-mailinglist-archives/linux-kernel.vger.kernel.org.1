Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598C3289B93
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 00:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389777AbgJIWF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 18:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgJIWF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 18:05:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627BFC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 15:05:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r2so10388249yba.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Oskwxi1g2+xZxPqyNpkhozQHPxUzxe/EfOOI24BudKs=;
        b=sKVTHK+/cJgmnRYH0J5BpycpZImtw2W1PcV/EkLthKq0viMSlKaHqOSTqweSit4mVU
         XfI+7lzYCx1FXDv7DwP/bnYYMy1u2vemzjYq+2Y7wGL0JgeZlnlCib1TUbfMPet3GmcO
         9TOGw2er8Rsn/w5HUER10CTGnAAnOPe0I+h92FRiGO2pUvA6iTM8Co2ZqOf5j/+Dj8XC
         9A1GgcCrr6vQNVO/rWDst5RSlfcRAvLvbeg2XwVX0GgZZaH3zgdUCxZJOlP76Rk7Ljud
         TCfXwqcllEMZAQZfECd+HK9YI7ZMIqeTSts3WZYjj+XK/SsjWklcOxMBO+tbKGdGTXld
         /uIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Oskwxi1g2+xZxPqyNpkhozQHPxUzxe/EfOOI24BudKs=;
        b=bbywTztKvusDoKL/p3WMNIgop5qWdOCi5QjBq5n1qYrfDAuI51q0JtNWtv2jAA5Je/
         J0RErVTycp3OjGcnsfPgG0Rwxj6uu06T/hrKv2z5jsaAgb4nVHVwNhOPiz9rpZRWKL1P
         JSMmuJ8tB0+Dtc/Xqzpaelqyj8OZSnkNDl33jrdNUATK6szy3QKPxGivhXQyheQFSCh+
         a7B7ww6wha3iKVPo/i6fN36P9j34tyHRPg9eAuVWaikzXVXWVr4xuB3H3LkRG/dAt3/8
         fkCpy7i1LGUqExBPCA0o2eSSON/YKCFsUvmAmBV5bQmdO8oVpXAjk0WdTk95Vlh4jJX6
         Z9ng==
X-Gm-Message-State: AOAM531LPNrW94XF2s2K6vPqGg4U6pnCJe7CGEJwx3u2lyuvSfE7z91X
        +6eAkLR/LCu3bWMh844j5bubjPY1fczPjFo9OoA8
X-Google-Smtp-Source: ABdhPJzX+v1XxsBETju7nWZwVjITzY2J5kD46J+3KxJOdrkI3MnlEbcgHrq0Amsd4LL2182+9hCL8q8dHjWHjNdJZt2z
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:a25:eb08:: with SMTP id
 d8mr20071031ybs.23.1602281128551; Fri, 09 Oct 2020 15:05:28 -0700 (PDT)
Date:   Fri,  9 Oct 2020 15:05:22 -0700
Message-Id: <20201009220524.485102-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v3 0/2] Add tracepoints around mmap_lock acquisition
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
patches [1] [2]).

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

Axel Rasmussen (2):
  tracing: support "bool" type in synthetic trace events
  mmap_lock: add tracepoints around lock acquisition

 include/linux/mmap_lock.h         | 93 +++++++++++++++++++++++++++++--
 include/trace/events/mmap_lock.h  | 70 +++++++++++++++++++++++
 kernel/trace/trace_events_synth.c |  4 ++
 mm/Makefile                       |  2 +-
 mm/mmap_lock.c                    | 87 +++++++++++++++++++++++++++++
 5 files changed, 250 insertions(+), 6 deletions(-)
 create mode 100644 include/trace/events/mmap_lock.h
 create mode 100644 mm/mmap_lock.c

--
2.28.0.1011.ga647a8990f-goog

