Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27662D9AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408088AbgLNPTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:19:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:42790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgLNPTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:19:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607959113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=A84go2ehAkcLQ3j0JDrXFrCRfpIcDzwXHG8JiDK3vds=;
        b=lzDfyHk+F9g9VL8RyvFo9NQJq8C0+SKmVRG6GT9Vak6mFTkFFOe3LZMAGAtBRyK7JEtSpN
        /E/qMOs6/eREJUO+ujvpgPZbp+fb7PBNUirfhixqxsyJtE/NgyxTcpnaSmpD9s7MszUtDj
        hD4gT9LbzUw1OHb3eb6+JwNgN/RoShc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B062BAE47;
        Mon, 14 Dec 2020 15:18:33 +0000 (UTC)
Date:   Mon, 14 Dec 2020 16:18:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] printk for 5.11
Message-ID: <X9eCSHnMZyJUt3FW@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.11

==============================

- Finally allow parallel writes and reads into/from the lockless
  ringbuffer. But it is not a complete solution. Readers are still
  serialized against each other. And nested writes are still
  prevented by printk_safe per-CPU buffers.

- Use ttynull as the ultimate fallback for /dev/console.

- Officially allow to disable console output by using console="" or
  console=null

- Few code cleanups.

==============================

We believe that the risk of logbuf_lock removal is small.
It is another important step in the printk rework. We are
moving slowly and carefully.

----------------------------------------------------------------
John Ogness (2):
      printk: inline log_output(),log_store() in vprintk_store()
      printk: remove logbuf_lock writer-protection of ringbuffer

Lukas Bulwahn (1):
      printk: remove obsolete dead assignment

Nikolay Borisov (1):
      printk: ringbuffer: Reference text_data_ring directly in callees.

Petr Mladek (4):
      init/console: Use ttynull as a fallback when there is no console
      printk/console: Allow to disable console output by using console="" or console=null
      Merge branch 'for-5.11-null-console' into for-linus
      Merge branch 'for-5.11' into for-linus

 drivers/tty/Kconfig               |  14 ---
 drivers/tty/Makefile              |   3 +-
 drivers/tty/ttynull.c             |  18 +++
 include/linux/console.h           |   3 +
 init/main.c                       |  10 +-
 kernel/printk/printk.c            | 257 +++++++++++++++++++++++---------------
 kernel/printk/printk_ringbuffer.c |  32 +++--
 7 files changed, 200 insertions(+), 137 deletions(-)
