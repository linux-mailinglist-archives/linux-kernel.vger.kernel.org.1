Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3311C28DC2B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgJNI7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgJNI7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:59:15 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C54A420878;
        Wed, 14 Oct 2020 08:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602665953;
        bh=HRkeYV89S6vzgW2I9CGluA/AgIgzo3jKwHMfFBQqVew=;
        h=From:To:Cc:Subject:Date:From;
        b=kVXRyrROitdzaPGJdivgQuJfCw/BAoSgrEdJ83ONNJgugUOSgwkUY3CimMrS66n8d
         SbMudONVf1AyralFzK54obrg5K3FWcRAWEMcE1hQSbnvJZXhU+9osfGo0zqyXFOMQj
         G003BmT5opHLVqnwWT5uCuFPZByFNMrT7j+2ujDQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH 0/1] tracepoints: Use %px instead of %p in trace event definitions
Date:   Wed, 14 Oct 2020 17:59:10 +0900
Message-Id: <160266594977.74973.9883936722540767319.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently I faced this "hashed pointer value" issue while tracing
percpu events.

https://lore.kernel.org/lkml/20201008172806.1591ebb538946c5ee93d372a@kernel.org/

In the mail, I explained why the base_addr and ptr was not actual value as below;

>           <idle>-0     [000] ....     0.543208: percpu_create_chunk: base_addr=000000005d5ad71c
>  [...]
>          systemd-1     [000] ....     0.568931: percpu_alloc_percpu: reserved=0 is_atomic=0 size=48 align=8 base_addr=00000000fa92a086 off=32672 ptr=000000008da0b73d
>          systemd-1     [000] ....     0.568938: xen_guest_init: Xen: alloc xen_vcpu_info ffff800011003fa0 id=000000008da0b73d
>          systemd-1     [000] ....     0.586635: xen_starting_cpu: Xen: xen_vcpu_info ffff800011003fa0, vcpup ffff00092f4ebfa0 per_cpu_offset[0] ffff80091e4e8000
> 
> (NOTE: base_addr and ptr are encoded to the ids, not actual address
>  because of "%p" printk format)

Since trace_seq_printf() use in-kernel vsprintf() at last, the %p is always
converted to the hash value instead of real address.
For the user log it maybe secure, but for the ftrace, I think it is
meaningless because

- tracefs is used by root user, so no need to hide it.
- tracefs user can access percpu/cpu*/trace_pipe_raw which stores real
  address on the trace buffer.
- external commands like perf doesn't convert to the hash value.

And when debugging kernel, we would like to know real address which tells
us the address is in which area in the kernel by comparing with kernel
memory mapping.

So I would like to replace %p with %px to print out the raw address
value on tracefs/trace file. There is %pK which can control output format,
but from above reasons, I think %px is enough.


BTW, since this is an independent reason (of printk() security conversion)
apart from each subsystems, I made it a single commit. If I should better
break it into 44 individual patches, please tell me.

Thank you,

---

Masami Hiramatsu (1):
      tracepoints: tree-wide: Replace %p with %px


 include/trace/events/afs.h           |    6 ++---
 include/trace/events/alarmtimer.h    |    2 +-
 include/trace/events/btrfs.h         |   14 ++++++-----
 include/trace/events/cachefiles.h    |   20 ++++++++--------
 include/trace/events/cma.h           |    4 ++-
 include/trace/events/filelock.h      |   10 ++++----
 include/trace/events/filemap.h       |    4 ++-
 include/trace/events/fs_dax.h        |    2 +-
 include/trace/events/fscache.h       |   28 +++++++++++------------
 include/trace/events/host1x.h        |    4 ++-
 include/trace/events/huge_memory.h   |    6 ++---
 include/trace/events/ib_mad.h        |    4 ++-
 include/trace/events/io_uring.h      |   28 +++++++++++------------
 include/trace/events/kmem.h          |   18 +++++++--------
 include/trace/events/lock.h          |    4 ++-
 include/trace/events/mlxsw.h         |   10 ++++----
 include/trace/events/mmc.h           |    4 ++-
 include/trace/events/napi.h          |    2 +-
 include/trace/events/nbd.h           |    4 ++-
 include/trace/events/net.h           |    8 +++---
 include/trace/events/nilfs2.h        |   14 ++++++-----
 include/trace/events/objagg.h        |   20 ++++++++--------
 include/trace/events/page_pool.h     |    8 +++---
 include/trace/events/page_ref.h      |    4 ++-
 include/trace/events/pagemap.h       |    4 ++-
 include/trace/events/percpu.h        |    8 +++---
 include/trace/events/pwc.h           |    4 ++-
 include/trace/events/pwm.h           |    2 +-
 include/trace/events/qdisc.h         |    2 +-
 include/trace/events/rcu.h           |   12 +++++-----
 include/trace/events/rpcgss.h        |    4 ++-
 include/trace/events/rpcrdma.h       |   42 +++++++++++++++++-----------------
 include/trace/events/rtc.h           |    2 +-
 include/trace/events/rxrpc.h         |    6 ++---
 include/trace/events/skb.h           |    6 ++---
 include/trace/events/spi.h           |    6 ++---
 include/trace/events/sunrpc.h        |   12 +++++-----
 include/trace/events/tegra_apb_dma.h |    2 +-
 include/trace/events/timer.h         |   14 ++++++-----
 include/trace/events/vb2.h           |    2 +-
 include/trace/events/vmscan.h        |    6 ++---
 include/trace/events/workqueue.h     |    8 +++---
 include/trace/events/xdp.h           |    6 ++---
 include/trace/events/xen.h           |   34 ++++++++++++++--------------
 44 files changed, 205 insertions(+), 205 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
