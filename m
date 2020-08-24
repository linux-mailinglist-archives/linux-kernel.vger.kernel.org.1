Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883DE25092A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 21:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHXTWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 15:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgHXTV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:21:58 -0400
Subject: Re: [GIT PULL] fallthrough pseudo-keyword macro conversions for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296918;
        bh=COupIEk61+4T4DjyfKwXZdkrCvi7S2vcD0S2s5/NhTE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=a4505DOONMHrDQhzRJr83aOVlgKJkiZeCe3J3ZaZ1mu+hXD5Rh5tr8NtK4zlka2Bg
         vDOuDVwssVI7p0JOkEEiOSGrymI0Yp3b6xYtw33wd3GRvQb3J4SWEdt8MNnmNIxgZh
         framtiFNFWstzPv1uQCBH8qI5ObeJ4kb28rZtZtk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200824034841.GA29995@embeddedor>
References: <20200824034841.GA29995@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200824034841.GA29995@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-pseudo-keyword-5.9-rc3
X-PR-Tracked-Commit-Id: df561f6688fef775baa341a0f5d960becd248b11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bf74771ca5610b10c3ac4cd17aacc389e6927ca
Message-Id: <159829691816.31349.245632158352966440.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Aug 2020 19:21:58 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Aug 2020 22:48:41 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-pseudo-keyword-5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bf74771ca5610b10c3ac4cd17aacc389e6927ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
