Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7ED1A3A9B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 21:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgDITf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 15:35:59 -0400
Received: from mail.efficios.com ([167.114.26.124]:47080 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDITf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:35:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D4BC0280E4A;
        Thu,  9 Apr 2020 15:35:57 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Z3bz5x_ThC_U; Thu,  9 Apr 2020 15:35:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8C4A2280F9F;
        Thu,  9 Apr 2020 15:35:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8C4A2280F9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1586460957;
        bh=bFhrhpt5ayVzAtr+tHRZxRzvaCMpTrddBYhYmZJwKh8=;
        h=From:To:Date:Message-Id;
        b=I4TsXVgueNcO87QkVwS+xuOyaPnhPSoWCz2NIuSXPKbKIEy01I8/k69y9iJ0Vc3et
         CSPVZ8BZSSAW42UTyOFsquOHTsg/S/w4kXhMZBkvhjP6Rgoak7hIBhIn8kxX0GTy9U
         sXhV0p3Q7vT4L3JUhiMhC9VCAA9hWmWq2ecnLRZdKtcwWpRwz1m0FhT3/UWnhZrDBJ
         SvMhQS8MIcnmUR6bwXsz69fj2zpHTIIFDgELOVXtAuzqiBKkO/FzCSGNbqbmkU449J
         746cI//nRsDurw0B9wtY4z3HIu75tsLWYb64QJb51OiCVIc84N7NAJD8xfYk/1a3uD
         SB0pm5ieeptrw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id h5vuHugWsql6; Thu,  9 Apr 2020 15:35:57 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 3B04A280D67;
        Thu,  9 Apr 2020 15:35:57 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 0/9] Export information needed by the LTTng kernel tracer
Date:   Thu,  9 Apr 2020 15:35:34 -0400
Message-Id: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently commit 0bd476e6c6 "kallsyms: unexport kallsyms_lookup_name()
and kallsyms_on_each_symbol()" was merged upstream. As discussed
previously [1], LTTng-modules (a GPL kernel tracer module) currently
uses kallsyms to lookup some missing symbols.

This patch set integrates the required changes to the kernel code
wherever those changes are generally useful, and adds a few GPL-exports
targeting the information currently missing so LTTng modules can be
entirely free of kallsyms.

Feedback is welcome,

Thanks,

Mathieu

[1] https://lore.kernel.org/r/20200302192811.n6o5645rsib44vco@localhost

Mathieu Desnoyers (9):
  tracepoint: call vmalloc_sync_mappings() on registration
  bpf: allow up to 13 arguments for tracepoints
  writeback: tracing: pass global_wb_domain as tracepoint parameter
  stacktrace: export-GPL stack_trace_save_user
  sched: export-GPL task_prio
  mm: export-GPL get_pageblock_migratetype
  block: genhd: export-GPL gendisk_name
  block: genhd: export-GPL generic disk device type
  block: genhd: export-GPL generic disk block class

 block/bio.c                      |  2 +-
 block/blk-settings.c             |  2 +-
 block/blk.h                      |  2 +-
 block/genhd.c                    | 38 ++++++++++++++++++++++++--------
 block/partitions/core.c          |  4 ++--
 drivers/base/class.c             |  2 +-
 drivers/base/core.c              | 15 +++++++------
 drivers/base/devtmpfs.c          |  2 +-
 include/linux/genhd.h            |  4 +++-
 include/linux/kernel.h           |  6 ++---
 include/linux/trace_events.h     |  3 +++
 include/trace/bpf_probe.h        |  3 ++-
 include/trace/events/writeback.h | 17 ++++++++------
 init/do_mounts.c                 |  4 ++--
 kernel/sched/core.c              |  1 +
 kernel/stacktrace.c              |  1 +
 kernel/trace/bpf_trace.c         |  8 ++++---
 kernel/tracepoint.c              |  2 ++
 mm/page-writeback.c              |  9 ++++----
 mm/page_alloc.c                  |  1 +
 20 files changed, 82 insertions(+), 44 deletions(-)

-- 
2.17.1

