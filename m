Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC71F0D95
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jun 2020 20:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgFGSKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 14:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbgFGSKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 14:10:21 -0400
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591553420;
        bh=AVSnVdn8QYqs2IJcyNcQPKgcRUvjXNi49B21zfNuAsQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iBpUlEZWoFxVXFytOBR5h0pAXgKlEGU85iVtOdT2+oqb+aVOWs06MNg2eDWSShsTq
         3IiRV2jNJRpKFuH4TyK7MDIuoSdhLYpbnz/JhF864+Mhf6gND1qtaccSljEWFzf0lF
         vnG1DFRVsPfFZQwYk2PELLTUxMwhf8ulnIXurLaA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200607132747.GA168291@kroah.com>
References: <20200607132747.GA168291@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200607132747.GA168291@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.8-rc1
X-PR-Tracked-Commit-Id: 77f55d1305c11fb729b88f2c3f7881ba0831fa6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80ef846e9909f22ccdc2a4a6d931266cecce8b2c
Message-Id: <159155342087.28494.163613726871312579.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Jun 2020 18:10:20 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Jun 2020 15:27:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80ef846e9909f22ccdc2a4a6d931266cecce8b2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
