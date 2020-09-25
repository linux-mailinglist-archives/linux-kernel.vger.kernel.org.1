Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE02279432
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgIYW1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgIYW1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:27:47 -0400
Subject: Re: [GIT PULL] regulator fixes for v5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601072866;
        bh=UOXJCve2nA4k057B/7BrjOS4n0fOjR+l+ljK4K0bfBs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q3Z9bfP623gCxIa/KZWln4Ykeyw/R/2DZpGYozbKK0cZY+HNAjEJsvKCpbI4U/ito
         +EvLUrXLTYQoqAOz/rz4G+HHiFWWV6PyD3fdhzSYHqD1YsQ/gc/EjlH1wwxWSUtnrM
         tldeBchXQAPAX1NjIoCqLbjbQ6jF+WVI2ThwbPiA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200925201729.7E2962399C@mail.kernel.org>
References: <20200925201729.7E2962399C@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200925201729.7E2962399C@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.9-rc6
X-PR-Tracked-Commit-Id: fbb5a79d2fe7b01c6424fbbc04368373b1672d61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 814324b5938147b659706d859a12db4bd77f0136
Message-Id: <160107286683.23838.14826741895094232123.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Sep 2020 22:27:46 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Sep 2020 21:16:21 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/814324b5938147b659706d859a12db4bd77f0136

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
