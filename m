Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879B1301B5A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 12:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbhAXLMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 06:12:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:44730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbhAXLMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 06:12:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8230B731;
        Sun, 24 Jan 2021 11:11:26 +0000 (UTC)
Date:   Sun, 24 Jan 2021 12:11:26 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v5.11-rc5
Message-ID: <20210124111126.GB2493@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two urgent fixes to the timers machinery, for v5.11.

Thx.

---

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.11_rc5

for you to fetch changes up to e3fab2f3de081e98c50b7b4ace1b040161d95310:

  ntp: Fix RTC synchronization on 32-bit platforms (2021-01-12 21:13:01 +0100)

----------------------------------------------------------------
 - Fix an integer overflow in the NTP RTC synchronization which lead to latter
   happening every 2 seconds instead of the intended every 11 minutes.

 - Get rid of now unused get_seconds().

----------------------------------------------------------------
Chunguang Xu (1):
      timekeeping: Remove unused get_seconds()

Geert Uytterhoeven (1):
      ntp: Fix RTC synchronization on 32-bit platforms

 include/linux/ktime.h         |  1 -
 include/linux/timekeeping32.h | 14 --------------
 kernel/time/ntp.c             |  4 ++--
 kernel/time/timekeeping.c     |  3 +--
 4 files changed, 3 insertions(+), 19 deletions(-)
 delete mode 100644 include/linux/timekeeping32.h

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
