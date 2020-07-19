Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0594C2253E3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 22:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgGSUAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 16:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgGSUAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 16:00:05 -0400
Subject: Re: [GIT pull] sched/urgent for v5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595188805;
        bh=3exAugfass9q1VdicVYK1AzJb0wQfwKghsFh15O7qyw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UoawtQof1EvkBmj3y3OxBSWcsjXXqf+doBSSReeKOlbSPHjj1ZUM/ACg+8i0eqUL9
         NBUKozKBLlbPtE0DvMb4W6XKI8iAfhosdMrx9Qh4Vh3zHkkxHqD1/HGjUejD/3jA7y
         FylTMClCvHQCwvcXVabaFY8UWp6rAsbKYebYya9k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159516469134.4147.3024788666121647415.tglx@nanos.tec.linutronix.de>
References: <159516469014.4147.6471285397574034610.tglx@nanos.tec.linutronix.de>
 <159516469134.4147.3024788666121647415.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159516469134.4147.3024788666121647415.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-2020-07-19
X-PR-Tracked-Commit-Id: 01cfcde9c26d8555f0e6e9aea9d6049f87683998
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43768f7ce0996590cb9588de71f026f30fb35581
Message-Id: <159518880503.26827.3569016276514328614.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jul 2020 20:00:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Jul 2020 13:18:11 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-07-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43768f7ce0996590cb9588de71f026f30fb35581

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
