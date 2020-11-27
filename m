Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5792C6729
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgK0NrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:47:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:46348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729402AbgK0NrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:47:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606484836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=iPJZ+oxo6wyUCDbnhCw+WjBHREPkcPEiiGbWc9Ftde4=;
        b=l4dvDTUMJbxHeZrIG2D1DF2ODWSrLZ5c01SxydG4vuhWpBn4lfIOmdYkGVq3Ae4bKguQQU
        eJzxlbAENsRr/KQ/SYHyZbOBN0suJGzHVJSUA+BppfGhCyvg6ubp94Dz+o4RDJPXHBUPOb
        yitTJEk+68Gz/QmPjIg2htufwZh7A2o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DAD6CAC23;
        Fri, 27 Nov 2020 13:47:15 +0000 (UTC)
Date:   Fri, 27 Nov 2020 14:47:15 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [GIT PULL] printk for 5.10 (includes lockless ringbuffer)
Message-ID: <X8EDY+hYkuyja5vy@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull a printk hotfix from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.10-rc6-fixup

=========================

- Do not lose trailing newline in pr_cont() calls.

- Two trivial fixes: dead-store and a config description.

=========================

PS: I do not have much experience with pushing fixes this late
    in the release cycle.

    I push the important fix even before it has reached linux-next.
    The fix is straightforward and trivial. And it looks better to have
    it in rc6 than in the potentially last one rc7.

    Also I added the two trivial fixes that I queued few weeks ago.
    They were trivial enough to get pushed at any time. And they
    fixed something that was introduced in 5.10-rc1.

    Feel free to postpone this for rc7 or take only the one fix
    of the newlines handling.

----------------------------------------------------------------
John Ogness (1):
      printk: finalize records with trailing newlines

Lukas Bulwahn (1):
      printk: remove unneeded dead-store assignment

Paul Menzel (1):
      init/Kconfig: Fix CPU number in LOG_CPU_MAX_BUF_SHIFT description

Petr Mladek (1):
      Merge branch 'for-5.10-pr_cont-fixup' into for-linus

 init/Kconfig                      | 2 +-
 kernel/printk/printk.c            | 4 ++--
 kernel/printk/printk_ringbuffer.c | 2 --
 3 files changed, 3 insertions(+), 5 deletions(-)
