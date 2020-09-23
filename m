Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17A3275933
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgIWN4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:56:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:49094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgIWN4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:56:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600869397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KBx+gik6NBNzI5P+pAz4fybhKo40AHUvEejBWLTvCVg=;
        b=JUDBeM1BuLX57DzG2o7IYxSrOR9dLJ+1hVyxGOR9RuJKyWnFpMnggp0yXTFkxahayOREOL
        fHU3ytWzKkmWH3qIMwseDbMEkRoaDf1PSsJQcm4D7GokSlcNxozE8aLLmj+p1fsUF9LgvD
        B4VeW4eYb/vECDKEQLHvjAZTZyTjzog=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D081AC26;
        Wed, 23 Sep 2020 13:57:14 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Changki Kim <changki.kim@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [RFC 0/2] printk: Add more metadata for each record
Date:   Wed, 23 Sep 2020 15:56:15 +0200
Message-Id: <20200923135617.27149-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been repeated requests to store and print more metadata
for each line, see the two patches for more details.

This patchset handles the storing part so that we could do it together
with the other changes of the ring buffer structure. It would be nice
to get it into the same kernel release to reduce pain on the crash
tools side.

My proposal is to make this information available via /dev/kmsg as
dictionary values. The console output would probably need to be configurable.

I would ignore syslog syscall that is hard to extend and is basically
obsoleted by /dev/kmsg.


The patchset applies on top of the current printk/linux.git,
branch printk-rework (after the dict ring removal).

You also need to merge "timekeeping-for-printk-2020-08-23" tag
from tip.git. It provides "struct ktime_timestamps" and
ktime_get_fast_timestamps().

I still need to add the gdb-related changes if there is not a strong
opposition to these changes. I just wanted to send what I had before
starting review of the logbuf_lock removal patchset.


Petr Mladek (2):
  printk: Store all three timestamps
  printk: Add more information about the printk caller

 kernel/printk/printk.c            | 129 ++++++++++++++++++++----------
 kernel/printk/printk_ringbuffer.c |  43 +++++-----
 kernel/printk/printk_ringbuffer.h |  42 +++++++++-
 3 files changed, 148 insertions(+), 66 deletions(-)

-- 
2.26.2

