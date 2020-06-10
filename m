Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0111F5D20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 22:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgFJU0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 16:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgFJU0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:26:06 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269A4C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:26:06 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jj7IR-006d2U-12; Wed, 10 Jun 2020 20:26:03 +0000
Date:   Wed, 10 Jun 2020 21:26:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: [git pull] sysctl fixes
Message-ID: <20200610202602.GU23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Fixups to regressions in sysctl series.

The following changes since commit 32927393dc1ccd60fb2bdc05b9e8e88753761469:

  sysctl: pass kernel pointers to ->proc_handler (2020-04-27 02:07:40 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sysctl

for you to fetch changes up to ef9d965bc8b6fce5bcc0ae76a4a5b3ed91ee81eb:

  sysctl: reject gigantic reads/write to sysctl files (2020-06-10 14:11:33 -0400)

----------------------------------------------------------------
Christoph Hellwig (6):
      net/sysctl: use cpumask_parse in flow_limit_cpu_sysctl
      net/sysctl: remove leftover __user annotations on neigh_proc_dointvec*
      random: fix an incorrect __user annotation on proc_do_entropy
      trace: fix an incorrect __user annotation on stack_trace_sysctl
      cdrom: fix an incorrect __user annotation on cdrom_sysctl_info
      sysctl: reject gigantic reads/write to sysctl files

 drivers/cdrom/cdrom.c      | 2 +-
 drivers/char/random.c      | 2 +-
 fs/proc/proc_sysctl.c      | 4 ++++
 include/linux/ftrace.h     | 5 ++---
 include/net/neighbour.h    | 7 +++----
 kernel/trace/trace_stack.c | 5 ++---
 net/core/sysctl_net_core.c | 2 +-
 7 files changed, 14 insertions(+), 13 deletions(-)
