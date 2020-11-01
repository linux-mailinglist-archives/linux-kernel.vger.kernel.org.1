Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1222A211A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 20:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgKAT1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 14:27:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgKAT1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 14:27:03 -0500
Subject: Re: [GIT pull] locking/urgent for v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604258823;
        bh=kLN9+SF1mOqU6smfm4/D5RTQMnJDqIsq3Ojqn4+eR9A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u765RxMCHpvMehF7AhaH23Wh+Bh+xFkY7pcDfel+d296F1cNFHmcLl3wyU/8jDLUQ
         Ullkk+e7rxiyI3yXSmg777GN5vairuH9anlxtTtkx6yuYL6+ya9ODK3oQF2o8mFKR9
         7iaJ7kH7K4vpbHJcX/m27r0Kze1EArqGwAdYA2JU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160423896136.5667.9743580255833470691.tglx@nanos>
References: <160423896136.5667.9743580255833470691.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160423896136.5667.9743580255833470691.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-11-01
X-PR-Tracked-Commit-Id: 1a39340865ce505a029b37aeb47a3e4c8db5f6c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d99084efcc21bb4e2bc4d818f41a27768d48f6e
Message-Id: <160425882321.14673.12199765685697650855.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Nov 2020 19:27:03 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 01 Nov 2020 13:56:01 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-11-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d99084efcc21bb4e2bc4d818f41a27768d48f6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
