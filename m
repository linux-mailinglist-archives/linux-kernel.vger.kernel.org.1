Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46EF2ED49F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbhAGQpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:45:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:35346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbhAGQpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:45:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610037859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wSvk/N4VsMaZmRt/5EtC0lSsod9zly1e3L1YQgG9tsU=;
        b=CHWH7qAy13X86IPtbS3dAIJCL0GjcydL626E4T0HnkuK4vD19rHyhc5LHWICFUKdpV5sp9
        mxoO3UPtyRo4Le2VDlVE8TwZW+wIPi/bD2Z3qvhtzEHVHEWbhsDmG6sL3WOWSH8zPzrOwi
        /u3LZKf2l9BI3IJpZKtUhDMgiAl4BgI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D4C6B771;
        Thu,  7 Jan 2021 16:44:19 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/1] console: Blank console - userspace regression
Date:   Thu,  7 Jan 2021 17:43:59 +0100
Message-Id: <20210107164400.17904-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 757055ae8dedf5333af17b3b ("init/console: Use ttynull as a fallback when
there is no console") caused several regressions. The ttynull console has been
selected by default when no console was configured on the command line and
ttynull_init() was the first initcall calling register_console().

There were few possible workarounds but I was not happy with them.
I worked on a proper solution but it became too complicated to
be used at this stage.

The console registration code is a sad story. There are many hidden catches.
The ordering of registered consoles is not well defined. Any change
in the code tends to break some particular system.

The good news is that I become more and more familiar with it.
I hope that I will be able to clean it up step by step in
the future. But it is definitely not a good idea to do any big
refactoring in rc phase.

Hence I propose to revert the problematic commit as the least
risky solution.

Petr Mladek (1):
  Revert "init/console: Use ttynull as a fallback when there is no
    console"

 drivers/tty/Kconfig     | 14 ++++++++++++++
 drivers/tty/Makefile    |  3 ++-
 drivers/tty/ttynull.c   | 18 ------------------
 include/linux/console.h |  3 ---
 init/main.c             | 10 ++--------
 5 files changed, 18 insertions(+), 30 deletions(-)

-- 
2.26.2

