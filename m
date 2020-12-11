Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93D42D6CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394672AbgLKA6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 19:58:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388572AbgLKA5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 19:57:54 -0500
Subject: Re: [GIT PULL] ktest.pl: Fix incorrect reboot for grub2bls
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607648234;
        bh=xFdoZjrjkAebVxXQZob0SQmpD+X7z9Syzq1L7HwxjM0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I1HM+Sh+7dAEFFXMd0lRiykvpVrQp6XuBITv5s1iXELCy04EROTQlJoZ16VaB2FIn
         seiGYIId2t79sszCmcFlOyNd6MqJnuyqWn69Q68oeEzICKO8kntqHwk/8BwmYPp31O
         il7zwK5LcofBP+Q16jaWNVQ9fWP+iF9bcboRJGRsMjdxwVrzpW82qnm3x+3swwY39L
         Z8r7ivprtleVDuckNjbtDM3vctrffWsN9KBTO9pAi99UYky2dewMoBfny1sz7VYVxc
         s4gijETYWguUPeAELJalj3zcUQj3r9VAsKh1mLT1Gm+jbY9UJRNsBDbyDUD5Q4DEtc
         bhP9EmjhnDxiw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201210195009.2a06b3ef@oasis.local.home>
References: <20201210195009.2a06b3ef@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201210195009.2a06b3ef@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.10-rc6
X-PR-Tracked-Commit-Id: 271e0c9dce1b02a825b3cc1a7aa1fab7c381d44b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33dc9614dc208291d0c4bcdeb5d30d481dcd2c4c
Message-Id: <160764823446.8380.14481283386760228941.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Dec 2020 00:57:14 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Libo Chen <libo.chen@oracle.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Dec 2020 19:50:09 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33dc9614dc208291d0c4bcdeb5d30d481dcd2c4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
