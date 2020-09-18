Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B6F26F793
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgIRIBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgIRIBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:01:25 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B60121481;
        Fri, 18 Sep 2020 08:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600416085;
        bh=c6ijB4BvIwzi7vJzyQ2v957duak7/yv+gqofCzrmM+M=;
        h=From:To:Cc:Subject:Date:From;
        b=qK3a9XQhW2pIfjCjXEv1P14tqj1JUrLGPfSf2O7MqokTWnEEDp2GmmFdyiTXnPh/n
         WfTlXl4FwbECEmsPAlISUaDrABQLVFRaUYYoZc0vcwC11SA5B6r2zyCIUUdTKmJTCv
         AYDw2TgUuzIAOQL73aYaeG45Au2EVpe7wr/hA41o=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     "Frank Ch . Eigler" <fche@redhat.com>,
        Aaron Merey <amerey@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] perf probe: Support debuginfod client
Date:   Fri, 18 Sep 2020 17:01:20 +0900
Message-Id: <160041608027.912668.13169810485938551658.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the 2nd version of a series to enable debuginfod support on
perf probe command. This allows users to access debuginfo binary
from remote device. 

In this version I fixed a build error when libdebuginfod is not
installed ([2/2]).


Since the perf-probe heavily depends on the debuginfo, debuginfod
gives us many benefits on the perf probe command on remote
machine, especially for the embedded devices.

Here is an example (copied from [2/2])

1. at first you need to start debuginfod on the host machine.
   -F option scans local debuginfo binary. (You don't need to pass
   the source tree, but you must keep the source tree untouched)

  (host) $ cd PATH/TO/KBUILD/DIR/
  (host) $ debuginfod -F .
  ...

2. In the remote machine, you need to set DEBUGINFOD_URLS.
   debuginfod uses 8002 tcp port.

  (remote) # export DEBUGINFOD_URLS="http://$HOST_IP:8002/"

3. Then you can use the perf probe (it can refer the source code)

  (remote) # perf probe -L vfs_read
  <vfs_read@...>
        0  ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
           {
        2         ssize_t ret;

                  if (!(file->f_mode & FMODE_READ))
                          return -EBADF;
        6         if (!(file->f_mode & FMODE_CAN_READ))
                          return -EINVAL;
        8         if (unlikely(!access_ok(buf, count)))
                          return -EFAULT;

       11         ret = rw_verify_area(READ, file, pos, count);
       12         if (ret)
                          return ret;
                  if (count > MAX_RW_COUNT)
  ...

  (remote) # perf probe -a "vfs_read count"
  Added new event:
    probe:vfs_read       (on vfs_read with count)

  (remote) # perf probe -l
    probe:vfs_read       (on vfs_read@ksrc/linux/fs/read_write.c with count)



Thank you,

---

Masami Hiramatsu (2):
      perf probe: Fix to adjust symbol address with correct reloc_sym address
      perf probe: Fall back to debuginfod query if debuginfo and source not found


 tools/perf/util/probe-event.c  |   66 ++++++++++++++++++++++++++++++++++++++--
 tools/perf/util/probe-finder.c |   61 ++++++++++++++++++++++++++++++++++---
 tools/perf/util/probe-finder.h |    7 +++-
 3 files changed, 123 insertions(+), 11 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
