Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603A7298321
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418175AbgJYSf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1418146AbgJYSfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:35:24 -0400
Subject: Re: [GIT pull] sched/urgent for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603650923;
        bh=HOhrBw5h0qu/glQmDB+gLEeK7XrlVl4zCnNjgefuSic=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2YVY0xrFzFuWw1tg7S7J/Thwb1G8je55Nkl0Qf/OdNwLpuA/81RaQaFXdsjsO2l0G
         dBZqCh8djwAP0qfUXyC7L08TOV/xqdfV5OuFa/pkc8yW7KX+HtJYCm5OlnYWZ6hUov
         l35fbUi0911cCj0ytU5sLlgeFdsURphP7cThyntg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160363590706.1234.6760142775707433453.tglx@nanos>
References: <160363590465.1234.11586095980767794789.tglx@nanos> <160363590706.1234.6760142775707433453.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160363590706.1234.6760142775707433453.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-10-25
X-PR-Tracked-Commit-Id: a73f863af4ce9730795eab7097fb2102e6854365
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87702a337f748d19a59a7826aeeffe0f6aeab7d4
Message-Id: <160365092377.20889.17873565817322984744.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Oct 2020 18:35:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Oct 2020 14:25:07 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-10-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87702a337f748d19a59a7826aeeffe0f6aeab7d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
