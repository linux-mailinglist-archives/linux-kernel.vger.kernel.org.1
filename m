Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C7023E2A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 21:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHFTzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 15:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgHFTzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:55:07 -0400
Subject: Re: [GIT PULL] sched/fifo changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596743707;
        bh=+AfSdaKBOBbFAmP4HXu0JCCAzcdGuDLiREy2IBErSoE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UPSkeF865WOrJOJAdrSaupajWo3A1QZyDvNBcdDpEvVvV9DiL7QmiKsDPa7jiKcO3
         KUZDgSihI3R00rFDoWz777agOBtgnpfGazEAyaOFb4a7xAawSh8oKYGlV3WmHBe6JV
         Qr6F0kmnITPnBR43xDH+sXy/aL9a/IY4X7RgsDiw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200804111025.GA1556312@gmail.com>
References: <20200804111025.GA1556312@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200804111025.GA1556312@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-fifo-2020-08-04
X-PR-Tracked-Commit-Id: 4fd5750af02ab7bba7c58a073060cc1da8a69173
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d2b84a4e5b954bd2587e06c29577256f59e0030
Message-Id: <159674370684.25191.6981619523818198898.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Aug 2020 19:55:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Aug 2020 13:10:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-fifo-2020-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d2b84a4e5b954bd2587e06c29577256f59e0030

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
