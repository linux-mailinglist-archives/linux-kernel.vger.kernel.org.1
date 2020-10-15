Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE0328EEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbgJOJAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388330AbgJOJAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:00:03 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E1B20BED;
        Thu, 15 Oct 2020 09:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602752402;
        bh=XcRyAvLeF+EOSVdLg+ILgkWmmp8fl295Gchy6mmPH00=;
        h=From:To:Cc:Subject:Date:From;
        b=GTFuFAmrMWkhzbsTuDljjoMldPvBCipGe5YKOrHacXxmOUSMv/Pc5FqHdlrhMf/CN
         X7NgTKM8ywXPyZnkHRP2DVoM8jo+ncx2BkyrjKm5vlA2/VUXtbj31FHjbW3h55GPXP
         CQaSdX2lvwGnnEUbHuIrbe8KKPyeRnBWwnHmjTlw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH v2 0/3] tracing: Show real address instead of hashed pointer
Date:   Thu, 15 Oct 2020 17:59:59 +0900
Message-Id: <160275239876.115066.10891356497426857018.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 2nd series of the real address printing in trace log.
Here is the 1st version, I've changed the implementation according
to Steve's comment.

https://lore.kernel.org/lkml/160266594977.74973.9883936722540767319.stgit@devnote2/

This version has 3 patches, replacing %p to %px online, update trace_event.h
description and add an option to switch hashed ptr and real value on
trace log. Those are all new patches.

Since trace_seq_printf() use in-kernel vsprintf() at last, the %p is always
converted to the hash value instead of real address.

For the dmesg it maybe secure, but for the ftrace, I think it is
meaningless because

- tracefs is used by root user, so no need to hide it.
- tracefs user can access percpu/cpu*/trace_pipe_raw which stores real
  address on the trace buffer.
- external commands like perf doesn't convert to the hash value.

And when debugging kernel, we would like to know real address which tells
us the address is in which area in the kernel by comparing with kernel
memory mapping.
However, to compare the trace log with dmesg, we also need a bridging
information. So 3/3 gives the options/hash-ptr knob which switches
the output format.

Thank you,

---

Masami Hiramatsu (3):
      tracing: Show real address for trace event arguments
      tracing: Update the stage 3 of trace event macro comment
      tracing: Add ptr-hash option to show the hashed pointer value


 Documentation/trace/ftrace.rst |    6 ++++
 include/linux/trace_events.h   |    3 ++
 include/trace/trace_events.h   |   31 ++++++++++++++-------
 kernel/trace/trace.c           |   60 +++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h           |    3 ++
 kernel/trace/trace_output.c    |   12 +++++++-
 6 files changed, 103 insertions(+), 12 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
