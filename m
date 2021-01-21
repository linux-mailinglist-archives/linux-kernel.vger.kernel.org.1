Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443982FEFDD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbhAUQK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:10:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:52454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387588AbhAUQFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:05:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611245042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=DOI+jYAvlBgnxxJTqfKpQC1cXQerHTMceZ6glAqUpA8=;
        b=aiwGivKbWCbQK1C3bNcTApgmxQeiwSIFK+ogbbYAJ+nya2D3s0L1NZZfce5JZIRRNIT8F1
        c7z4wS0ic3DrEKLalohvuLHhX6tZgKFQyU6e0OVbparcZlgrHzkUANoy+QOCKqzT56iau4
        5zG2dwhJYQbjNzW2zcXZ4AIKP9VZcAg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81A45AC63;
        Thu, 21 Jan 2021 16:04:02 +0000 (UTC)
Date:   Thu, 21 Jan 2021 17:04:01 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk regression fixes for 5.11-rc5
Message-ID: <YAml8WLMo3mVSoKR@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull three printk fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.11-printk-rework-fixup

===============================

- Fix line counting and buffer size calculation. Both regressions
  caused that a reader buffer might not get filled as much as possible.

- Restore non-documented behavior of printk() reader API and make it
  official. It did not fill the last byte of the provided buffer before
  5.10. Two architectures, powerpc and um, used it to add
  the trailing '\0'. There might theoretically be more callers
  depending on this behavior in userspace.

===============================

All three regressions were found and fixed by John when
working on another changes.

----------------------------------------------------------------
John Ogness (3):
      printk: ringbuffer: fix line counting
      printk: fix kmsg_dump_get_buffer length calulations
      printk: fix buffer overflow potential for print_text()

Petr Mladek (1):
      Merge branch 'printk-rework' into for-linus

 kernel/printk/printk.c            | 40 ++++++++++++++++++++++++++++-----------
 kernel/printk/printk_ringbuffer.c |  2 +-
 2 files changed, 30 insertions(+), 12 deletions(-)
