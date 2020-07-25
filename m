Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89BF22DA3A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 00:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgGYWaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 18:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbgGYWaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 18:30:05 -0400
Subject: Re: [GIT PULL] clocksource driver fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595716205;
        bh=YBBXZ6dWrCX3y1ofbHOYqlFz9dxSYjrScDSs2s+Ckws=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0S09ST9haq6TzCJsWgl8HhY4lyu8dsn0uF+r54UpcNOwV5glovbNaT3Xdbh09c2po
         MeOcrW3k29+dr8SAggESdJRsN6NmRbiUHpReDn2Y8he83/uZ38+VifvxrZqHevpaTl
         IMNZ8mAIA8un/f7SAfYQcqCBjIIqvQZt3kW5Rod8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200725105357.GA883878@gmail.com>
References: <20200725105357.GA883878@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200725105357.GA883878@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-2020-07-25
X-PR-Tracked-Commit-Id: b4a25fb0e62990df467451744b22e0e24960a5e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7b36c2b134f7ca75789d174b97d07acccbf6b93
Message-Id: <159571620520.7388.9410051682652086591.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jul 2020 22:30:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Jul 2020 12:53:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-07-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7b36c2b134f7ca75789d174b97d07acccbf6b93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
