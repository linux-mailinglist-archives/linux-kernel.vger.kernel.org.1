Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C730F2D622D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403872AbgLJQCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:02:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:49472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391090AbgLJQBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:01:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607616057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/RDK+90f4BiI39cPxQWNZJU2UwVBYdblMM4zAXfF7m8=;
        b=FlOCJfTPnddM+GdQnUCJsIU8isd5lZWD01QVLUjhwI4dyQXnHR9CwaBUr6tIzFiqsNpYNU
        BkoN4t72W3Mp3CSDNd1Vq+vIJmBBS70wMtbWeHtzC0I0hnpECfUseEgC8lqqff1hWDN6vM
        t5BzW6zsr0SxP1RAicx0aOSys8pfQOk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1805FAE95;
        Thu, 10 Dec 2020 16:00:57 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 0/7] watchdog/softlockup: Report overall time and some cleanup
Date:   Thu, 10 Dec 2020 17:00:31 +0100
Message-Id: <20201210160038.31441-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I dug deep into the softlockup watchdog history when time permitted
this year. And reworked the patchset that fixed timestamps and
cleaned up the code[1].

I split it into very small steps and did even more code clean up.
The result looks quite strightforward and I am pretty confident
with the changes.

[*] v1: https://lore.kernel.org/r/20191024114928.15377-1-pmladek@suse.com

Petr Mladek (7):
  watchdog: Rename __touch_watchdog() to a better descriptive name
  watchdog: Explicitly update timestamp when reporting softlockup
  watchdog/softlockup: Report the overall time of softlockups
  watchdog/softlockup: Remove logic that tried to prevent repeated
    reports
  watchdog: Fix barriers when printing backtraces from all CPUs
  watchdog: Cleanup handling of false positives
  Test softlockup

 fs/proc/consoles.c |  5 +++
 fs/proc/version.c  |  7 ++++
 kernel/watchdog.c  | 97 ++++++++++++++++++++++++++--------------------
 3 files changed, 66 insertions(+), 43 deletions(-)

-- 
2.26.2

