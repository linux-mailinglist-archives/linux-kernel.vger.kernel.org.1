Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A132E3227
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 18:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgL0R1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 12:27:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbgL0R1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 12:27:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C84A822515;
        Sun, 27 Dec 2020 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609090025;
        bh=75cyGgUo31ySXs0szud5Tb/MHv/ULTKjQHtigV888dU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hUTZYESNNpnRNt5wF4GDObs4TYxO2t8yNUYLX1fboWsIi+y5StKGZvILP3TzqeoFv
         1ztgRqjFjKuYVD0AlJN7XctriSiryECZ1g9OOa32iwPTL9yGkRgmcvBJuCjgMWh4yL
         LqbUfb8aqiH+inL0vt8aebX00+y9QfWYsiHtY2pmaXznQ1sDAbs4HX7lkO5+g/aos0
         8mwD0Hc9Kiv/rd11W+SqwTTkGSsoETJzBO6YNl6HkoE7HbIpzzA9VU8mkF9rnvlPcw
         nBoHbvaMgH1iRNw9zSirNQZblv14nsK6EoGhdXyjIuiyVU6pSIXvp3AurOM7MasKZB
         5qpRJxYHhCp2w==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id C25BC604E4;
        Sun, 27 Dec 2020 17:27:05 +0000 (UTC)
Subject: Re: [GIT PULL] timer fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201227092658.GA1742349@gmail.com>
References: <20201227092658.GA1742349@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201227092658.GA1742349@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-12-27
X-PR-Tracked-Commit-Id: f6f5cd840ae782680c5e94048c72420e4e6857f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2eeefc60ad70ffb7a5daf9f47aef5b1ebd1f39ad
Message-Id: <160909002578.19416.5498828605983833433.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Dec 2020 17:27:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Dec 2020 10:26:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-12-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2eeefc60ad70ffb7a5daf9f47aef5b1ebd1f39ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
