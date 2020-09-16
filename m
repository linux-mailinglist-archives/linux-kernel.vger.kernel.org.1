Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE5926CCE1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgIPUuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgIPQ4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:56:00 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3985224B0;
        Wed, 16 Sep 2020 16:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600274677;
        bh=kM85Y0UMWPYLMc/eZRLTHLIQVQjZRVrJ6B09E79asG8=;
        h=From:To:Cc:Subject:Date:From;
        b=pm71H5nMZBg/guepkjFO93HRjnSctA1QTh1+KvpvJk46TXnW9qyvj0YjhazKFzq+e
         WzuXk4WfwqJVA/Ub7dlxs7IpGdCsnM83NO1jQgV1stD4vQ5nFM4jhik7XwWwh5cfP2
         sl7IPgTwHaWZiHorXWX3MEQ18Ow6ONkCvS64gEHE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     "Frank Ch . Eigler" <fche@redhat.com>,
        Aaron Merey <amerey@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf probe: Support debuginfod client
Date:   Thu, 17 Sep 2020 01:44:33 +0900
Message-Id: <160027467316.803747.10741549521899847231.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a couple of patches to enable debuginfod support on
perf probe command. This allows users to access debuginfo binary
from remote device. 

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


 tools/perf/util/probe-event.c  |   60 +++++++++++++++++++++++++++++++++++++---
 tools/perf/util/probe-finder.c |   56 ++++++++++++++++++++++++++++++++++---
 tools/perf/util/probe-finder.h |    7 +++--
 3 files changed, 112 insertions(+), 11 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
