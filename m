Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CD822DA3D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 00:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgGYWaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 18:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbgGYWaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 18:30:06 -0400
Subject: Re: [GIT PULL] uprobes fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595716205;
        bh=CcAc2Ei7tOm4PZGS82zHGAajzRideiDeiCkEQORlvpk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PP0eaGg4vuWbO1bOn2Nd84Z+VmbXRjeTzkwQkyrEPHNk70DrsrfQMqD0ijjoIxZTj
         GTpdOn031569t+WWECArJuFOsDROligqtepn8l9HcHoxTZvR+iBJ48DNRjodtpiyBK
         tXyQUmydSAaZYPcGNwi4ChUTh+ckPva8LsGfaC0w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200725120540.GA1010068@gmail.com>
References: <20200725120540.GA1010068@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200725120540.GA1010068@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-2020-07-25
X-PR-Tracked-Commit-Id: fe5ed7ab99c656bd2f5b79b49df0e9ebf2cead8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78b1afe22d51996c1916a332d43b853ff2b10ade
Message-Id: <159571620584.7388.1515003853290933441.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jul 2020 22:30:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Jul 2020 14:05:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-07-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78b1afe22d51996c1916a332d43b853ff2b10ade

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
