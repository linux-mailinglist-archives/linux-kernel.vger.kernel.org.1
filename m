Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2C2EB6F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbhAFAkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:40:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbhAFAkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:40:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7C5022DBF;
        Wed,  6 Jan 2021 00:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609893613;
        bh=o/Odw78msT0StJls/xB0nS8V8jACSRLTTjf45X2F+cI=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=H5S5UouHm5wtIldLVNmzfbTuEdp8lhfkdMkRR58GvcT9Y5AjjIJnEL6D8xrl9Y/kK
         YEd9aeDFQhfqbkM7ONbLq5NueS2zkH+Q/VYrO9zBhHtpLfhZbmy+voOSfckgPZBNHn
         q7hGq3M/b43refE+biuwe51MBgxDlk56ylUVfNojzumltr5/oxKKWpiTDctHXyYbjm
         v4MHjXTJlXzsiOa067U/cyfGjyduG5jAgdhPYEurffM6R138glWVTffS53HGmpFHcA
         ctYfbKnE1DCfdLkcYWD6+T4DpeJBuQdl4OFZ1t/iuzw96wzZmyGTLCQlXqF8AcWAH1
         OvXsmqL1hzxXg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AE3FD35228C6; Tue,  5 Jan 2021 16:40:13 -0800 (PST)
Date:   Tue, 5 Jan 2021 16:40:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        kernel-team@fb.com, neeraju@codeaurora.org
Subject: [PATCH RFC clocksource] Do not mark clocks unstable due to delays
Message-ID: <20210106004013.GA11179@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

If there is a sufficient delay between reading the watchdog clock and the
clock under test, the clock under test will be marked unstable through no
fault of its own.  This series checks for this, doing limited retries
to get a good set of clock reads.  If the clock is marked unstable
and is marked as being per-CPU, cross-CPU synchronization is checked.
This series also provides delay injection, which may be enabled via
kernel boot parameters to test the checking for delays.

1.	Provide module parameters to inject delays in watchdog.

2.	Retry clock read if long delays detected.

3.	Check per-CPU clock synchronization when marked unstable.

4.	Provide a module parameter to fuzz per-CPU clock checking.

5.	Do pairwise clock-desynchronization checking.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |   31 ++++
 arch/x86/kernel/kvmclock.c                      |    2 
 arch/x86/kernel/tsc.c                           |    3 
 include/linux/clocksource.h                     |    2 
 kernel/time/clocksource.c                       |  176 +++++++++++++++++++++---
 5 files changed, 189 insertions(+), 25 deletions(-)
