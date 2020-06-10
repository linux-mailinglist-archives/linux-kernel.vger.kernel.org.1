Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275401F5B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgFJSze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 14:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729692AbgFJSzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:55:24 -0400
Subject: Re: [GIT PULL] clk changes for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591815323;
        bh=LPvGRK27S7D297nZypj5cjXH6UqiCQh2JFo0bg4U0pc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z6wBN9mzGyhTwj0rkiZU7bMC7dpTjtnH1YVLYKLEVOBWzatN6zWbeiYQ5SiGx9b8T
         A7qI8HLmso5ADsNg/T3pH9iD+HWtgjHWjjjTss1/Dx5IYN/yQ0PHmoWcKOghM31sO9
         gPdUby0hiqBqj85+MhVErwrTvPUMC4mC4U/oJQ0s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200609225350.206940-1-sboyd@kernel.org>
References: <20200609225350.206940-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200609225350.206940-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-for-linus
X-PR-Tracked-Commit-Id: 9ac1eafa885a9b2d3becd4f2e622829b1f5b9b86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f630784cc0d92fb58ea326e2bc01aa056279ecb
Message-Id: <159181532369.20525.15031461668384988911.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Jun 2020 18:55:23 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  9 Jun 2020 15:53:50 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f630784cc0d92fb58ea326e2bc01aa056279ecb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
