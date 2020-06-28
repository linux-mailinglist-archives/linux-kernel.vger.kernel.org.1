Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3ED120C9AB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgF1SpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 14:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:32822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgF1SpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:45:13 -0400
Subject: Re: [GIT PULL] x86/entry for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593369912;
        bh=MA9p8+tWjhDfVUN3iLF62r/etpt8NrOsHXzYQmR2lh4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uenz2LZLfS0ocxZP9Ea4aqUJrOL9uLUyigbpt6TjPwx3OkD6kobpWmI9g4ajUL/cg
         h3sMAyKIRObmPCNI02pCQH5Nee4izEbeaUnfpzLL0FK/t0aD8We9EqYq95O6d3yM1Y
         ALbIW6tIryuN7B8q5wgXjcCGT5AH9ueSIxqmUV4c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200628140523.GA18884@zn.tnic>
References: <20200628140523.GA18884@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200628140523.GA18884@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 tags/x86_entry_for_5.8
X-PR-Tracked-Commit-Id: 2c92d787cc9fad57d05c96bd117782183768258a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a358505d8af3ab43763e1b49549619528783d2bf
Message-Id: <159336991270.7125.9425424711003680964.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jun 2020 18:45:12 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jun 2020 16:05:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_entry_for_5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a358505d8af3ab43763e1b49549619528783d2bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
