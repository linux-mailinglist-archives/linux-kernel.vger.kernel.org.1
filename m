Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7E127A2CA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgI0TeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgI0TeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:34:01 -0400
Subject: Re: [GIT pull] timers/urgent for for
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601235241;
        bh=RlhY+7NPfk0VccYK858cYJtnK+U6TX8fm2dX+DbCjaI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aFKNwRdtuMncJjY5cFQLsFMw6JLDKL2WJCDvy1/S4whBXQDmBTHnIGMoMzNew/Wyi
         AW5IT7w1m+1GQ+OhXjHxU1e47x9+I52Qc/05ywDVfvIeuvioJSQ7ShpFb/+4BlgRG3
         VdH+3CTChEK/J0M9KLRgw0FyaM+38HEwkhkBNV5o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160121921194.23623.5568205948074131939.tglx@nanos>
References: <160121921194.23623.5568205948074131939.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160121921194.23623.5568205948074131939.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-09-27
X-PR-Tracked-Commit-Id: a7b6c0feda15c9881cac83102cdbc82e39889995
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba25f0570b53267e8b9dc1f2e185caa3d3bc7633
Message-Id: <160123524116.14460.8107148574749877754.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Sep 2020 19:34:01 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Sep 2020 15:06:51 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-09-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba25f0570b53267e8b9dc1f2e185caa3d3bc7633

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
