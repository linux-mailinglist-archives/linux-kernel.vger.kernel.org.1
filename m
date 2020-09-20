Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8958F27186E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 00:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgITWk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 18:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgITWkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 18:40:22 -0400
Subject: Re: [GIT PULL] core/urgent for v5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600641622;
        bh=bztNO2RkLTfJn1VqQVh1d42b9ZAxGuuGu4/bhADpIbI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Mg+TIhZ0J4lBOSPip6BMnGXwaN8SpcqQ0txxIuUntZS87upkIKYxSPltXEGGGwtMu
         o3HBc2QwmSFN2T4untk8WQFFv9ovv/+pP1ThLZb9cwx0ZMGSSOeaXzYMfUYB0cX8QW
         c160gHYzJxGjOjHm7BWDXtT8gZYnasUSTkbFNPI0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200920200453.GG13044@zn.tnic>
References: <20200920200453.GG13044@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200920200453.GG13044@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_urgent_for_v5.9_rc6
X-PR-Tracked-Commit-Id: b6ec413461034d49f9e586845825adb35ba308f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2bff391caba23fb2780b2c9863b11aa25aaeb6f
Message-Id: <160064162213.32524.9948494129904183055.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Sep 2020 22:40:22 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Sep 2020 22:04:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_urgent_for_v5.9_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2bff391caba23fb2780b2c9863b11aa25aaeb6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
