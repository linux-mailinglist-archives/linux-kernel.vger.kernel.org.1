Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC3F2AF2A2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgKKNzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:55:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:33754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgKKNzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:55:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605102911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n7osxaBOy/mjei5z0b2nj94AHyccmDW0Rw8P9uQpbXE=;
        b=MmgmHT3+cSWwLQk+pJ4jogk8fV4g+2I7/M4GsUpXzqC2zLVwsNPGzNQ2vgg7yIH2yUwUR4
        YTHPg7n8/JJh9ccHv7RWdrDJY9exww3K4gFiPH2WZtQ8aBE72Z4g0wTXU/X84a7myGad6U
        igRxRY0wiPrRo8djcyI1kf85aixw5Bk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B93EABD1;
        Wed, 11 Nov 2020 13:55:11 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/2] printk/console: Use ttynull when no console is available or wanted
Date:   Wed, 11 Nov 2020 14:54:48 +0100
Message-Id: <20201111135450.11214-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another attempt to solve regression caused by the commit
48021f98130880dd74 ("printk: handle blank console arguments passed in.").

It prevented a crash caused by empty console= parameter. But it caused
performance problems on Chromebooks because they use it to disable
all consoles, see
see https://lore.kernel.org/r/20201006025935.GA597@jagdpanzerIV.localdomain

Solve both problems by using ttynull console driver that was crated
exactly for this purpose.

The 1st patch should prevent the crash for any invalid console name.

The 2nd patch allows to used the ttynull driver also with the widely
used console= and console=null parameters.

Best Regards,
Petr

Petr Mladek (2):
  init/console: Use ttynull as a fallback when there is no console
  printk/console: Allow to disable console output by using console="" or
    console=null

 drivers/tty/Kconfig     | 14 --------------
 drivers/tty/Makefile    |  3 +--
 drivers/tty/ttynull.c   | 18 ++++++++++++++++++
 include/linux/console.h |  3 +++
 init/main.c             | 10 ++++++++--
 kernel/printk/printk.c  |  9 ++++++++-
 6 files changed, 38 insertions(+), 19 deletions(-)

-- 
2.26.2

