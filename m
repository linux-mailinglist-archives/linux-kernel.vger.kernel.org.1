Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62631E99C4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 20:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgEaSFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 14:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728166AbgEaSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 14:05:03 -0400
Subject: Re: [GIT pull] sched/urgent for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590948303;
        bh=xRCN/W/j5GByo9T44+gg2iYZlA0iJg/BmmWCGmeqY8I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oMtTEJb/WQstlLvpNxfet4mQfXXTE+i51T2b49bHM4AEwoYNlYwIyfk3/nR4HCV63
         fNl3/58JfgmQ9tGthz3bVUInDEOUwSPqDXfSYXby+yUeRshPlKogHRvTTfhCZpjn3o
         op7bHcV1ZhBP1cuzj72Sp/jDqy5883Qja+sBKWBI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159093352092.1582.2279719529823662123.tglx@nanos.tec.linutronix.de>
References: <159093352092.1582.2279719529823662123.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159093352092.1582.2279719529823662123.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-2020-05-31
X-PR-Tracked-Commit-Id: 18f855e574d9799a0e7489f8ae6fd8447d0dd74a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d0428232909d9aa9248c3724f04a333f6f53bb3
Message-Id: <159094830330.9121.15752635711434714589.pr-tracker-bot@kernel.org>
Date:   Sun, 31 May 2020 18:05:03 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 May 2020 13:58:40 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-05-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d0428232909d9aa9248c3724f04a333f6f53bb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
