Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7EF2D06E6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 20:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgLFTb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 14:31:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbgLFTbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 14:31:24 -0500
Subject: Re: [GIT pull] irq/urgent for v5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607283044;
        bh=BIeIAOP1AvYTznjGHQw485+63l+5DPGkb0HiYeas6xQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pObE9W15LThotUaiNSUUdvupCKiApJQWBjUFO40ymRIc+rkqBqGQaEK7ms34GMX/r
         eHgmrLxsYgwT+7AYsScTk3R/VAqrdvrkvnHNeodcGrkUJs3137rqwa4f2ChU41NACX
         pjLWwV2ZS/YztpPeG17FSWrRwQ6hWv3j54jkXeEvzMv1acl4s7kvPAX6qGXOqUs7Gd
         alUIBQYEgMgkuIUsJHnWVqD+rwAezsCv/DI5kNTyOajKyYBug7AMbtIPNZcoo1EXgu
         Es02bMiASvVSQarWhEG5j+oVsUSW7yGjNJ/7gc6qjM4R47ParCMORvt+W0684kSQud
         5N6rQYSU3fZzg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160726029814.10836.11636935433736940390.tglx@nanos>
References: <160726029814.10836.11636935433736940390.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160726029814.10836.11636935433736940390.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-12-06
X-PR-Tracked-Commit-Id: 9ea69a55b3b9a71cded9726af591949c1138f235
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 592d9a0835c97f54744a7c3ce845c16735c0ab14
Message-Id: <160728304444.10233.5585835343622696951.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Dec 2020 19:30:44 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 06 Dec 2020 13:11:38 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-12-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/592d9a0835c97f54744a7c3ce845c16735c0ab14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
