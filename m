Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE63D2F250D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbhALAps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730302AbhALAnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:43:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3790D224F9;
        Tue, 12 Jan 2021 00:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610412179;
        bh=V1ISx3UpwubAVP3VrthvSzNceUsLdgzNuhLnw1EVqSA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UiOEFGMbKJCr0ufmgdT4VLfbaOFtlkK0CF7PO1CYxUFLM7ueRo0GD7Q+QoqpjTa8X
         uLLKLdi3YMGIUZXIvzeL/6POZcL/4eO7btbuBoYkGsmsyNdAf9NgBEC9h/4ryqyrtb
         08qiO3S19sGxORYNCZx0oOMlLJCNjyPKseCYfJLhV7a87PwONkkGOD2moEwEa/qyvV
         RN+56GPd0cFbkQYcIJWk7VNmOv1pDy2irQctAmj9JqLzbQowr4uu0WuVQjcxGz7XNQ
         FYGOmEPT0VOzG0RuclSj9KV4Y8oTcYzqSVaXd7mxd4P/ga9q9Zcam5OAkIjcAWWnrW
         aao14W/mhwfrA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F222B3522A7B; Mon, 11 Jan 2021 16:42:58 -0800 (PST)
Date:   Mon, 11 Jan 2021 16:42:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        kernel-team@fb.com, neeraju@codeaurora.org
Subject: [PATCH v2 clocksource] Do not mark clocks unstable due to delays
Message-ID: <20210112004258.GA23158@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106004013.GA11179@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106004013.GA11179@paulmck-ThinkPad-P72>
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

Changes since v1:

o	Applied feedback from Rik van Riel.

o	Rebased to v5.11-rc3.

o	Stripped "RFC" from the subject lines.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |   31 ++++
 arch/x86/kernel/kvmclock.c                      |    2 
 arch/x86/kernel/tsc.c                           |    3 
 include/linux/clocksource.h                     |    2 
 kernel/time/clocksource.c                       |  174 +++++++++++++++++++++---
 5 files changed, 188 insertions(+), 24 deletions(-)
