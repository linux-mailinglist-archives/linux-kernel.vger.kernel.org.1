Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8622DB9CA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 04:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgLPDpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 22:45:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:38030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgLPDpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:45:31 -0500
Subject: Re: [GIT PULL] exec-update-lock for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608090253;
        bh=1/Q4eD2GubnygRb5hRQu3SJRBZ29CglRgcUI2qVNxxg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EpJC4mIQXggBUP69lDiGChsZ2lrMWTc3M9IS3fEGBU0Eu7ssKl4JnXfxYlkak1h1q
         NJgWgN+ZrfKNschvLKJ4jMjySMsJTQssQ01SckfQjFM7vVDRwYQ1pko+fiQWJk6fP/
         RErbQNsn/G+jBGyEtkoergjz6yOE+cZmyMnxH7Fu5Yofg1Ky+esGAcyabLhQSwG0nL
         r5I6r0Pcr4LCUmoT+qiQHPJCC8wu2FXnxwJY15wCcIQdiIA/mIoz7KXe/BohtjQOc9
         WPPbXgipRnGHgz54p7/b5EHJ4WhUo4vD86LwIR/JJb3HlB5p8QEXRIX6WHkLs/OZDL
         jLzxlKx1b26rA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <874kkm8s8d.fsf@x220.int.ebiederm.org>
References: <874kkm8s8d.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <874kkm8s8d.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-update-lock-for-v5.11
X-PR-Tracked-Commit-Id: f7cfd871ae0c5008d94b6f66834e7845caa93c15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d01e7f10dae29eba0f9ada82b65d24e035d5b2f9
Message-Id: <160809025389.9893.1709323272760026475.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 03:44:13 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 19:17:06 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-update-lock-for-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d01e7f10dae29eba0f9ada82b65d24e035d5b2f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
