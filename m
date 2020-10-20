Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1E429426E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437709AbgJTSrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437595AbgJTSry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:47:54 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79216C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:47:54 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id r4so2443299qta.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=hwnYnS0POYRKONpfl5Y/Ys+jEoJH3m03NmNt0RevWsM=;
        b=TP8nBRSJfRaWqME65iqiGRIlVlXhcRSvbMSO86q9MoZTkrF/wWlSA+9upwZFM1gvlR
         CCvfLshAR2LVEvn66ld821KN8/GjNIdQCqQjqHjq7rp2/eDFoFUT2xErzYwV2djd0OVv
         rvI68TGZh4lb6eqBy6N08w+i7aH7duC/sRio3sG8Kro0VcTSEPrQ8HlHXvjy5CZFksLH
         jGxRqK1RRCIpuNvhnDIHdMXXDTcs6v+7ZlZnTqppifOe/VpyWFLbOnzQzYt14NY54I7m
         8ErTbjQGMfcZWqWT08dMBwT7UvMgh8nrdT+Wsr2uSWxOHd5iZPGDW0elfyWozr0YbL/b
         uYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=hwnYnS0POYRKONpfl5Y/Ys+jEoJH3m03NmNt0RevWsM=;
        b=cqoKEh/97fd9++96ioqfzlCusqXpFwPWJdapG/wj78WjkQs26j67OBuNMkftV3+OzL
         u2PIIACxqUg4rXKt9Po5LR1003rI5O1Ad7urL4wrqYNXLXSj3nSEIg0IJ53ArBjzBYTI
         DnHyyvlu5uQbZ+dhBWONneBBpU1OJ4Q5pZ0mU4iXsW7zs43NODRDRyiipkhvJ8xzEPG3
         OTw7CkOrveA0U6r0tCFd3qUYLo1Ae5PUOHlwenDMCoEuj+khG5rBacyeSyd50eilvGG+
         QCqKBMDBuHLh1lDPJ/DccefKbBubEZPuWRKKoA19Cwazqh8rlEQXHYIuHXS4UUcUviab
         Hg+Q==
X-Gm-Message-State: AOAM532cV3R2wzqIso9wbhA4SuR9Wuv0N9MXhCeyXzK8foB1K9Q3s1yx
        +E7CJ4atjI4kuJJFrWFMlk5iVafyqNvWUrFXb00C
X-Google-Smtp-Source: ABdhPJyPGryQh7+sHevmE+5QyU3RZQJX1SAfmqe3elp4FKyFyMr2/mmFVZyf4fMf8ctbiW8Jmw3yeXI2qnquFg1Kuun3
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:f693:9fff:feef:c8f8])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:4e47:: with SMTP id
 eb7mr4932129qvb.34.1603219673444; Tue, 20 Oct 2020 11:47:53 -0700 (PDT)
Date:   Tue, 20 Oct 2020 11:47:45 -0700
Message-Id: <20201020184746.300555-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v4 0/1] Add tracepoints around mmap_lock acquisition
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
        David Rientjes <rientjes@google.com>
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

 include/linux/mmap_lock.h        | 93 ++++++++++++++++++++++++++++--
 include/trace/events/mmap_lock.h | 98 ++++++++++++++++++++++++++++++++
 mm/Makefile                      |  2 +-
 mm/mmap_lock.c                   | 80 ++++++++++++++++++++++++++
 4 files changed, 267 insertions(+), 6 deletions(-)
 create mode 100644 include/trace/events/mmap_lock.h
 create mode 100644 mm/mmap_lock.c

--
2.29.0.rc1.297.gfa9743e501-goog

