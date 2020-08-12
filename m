Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AE8242FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgHLT6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 15:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgHLT6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:58:10 -0400
Subject: Re: [GIT PULL] More clk changes for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597262290;
        bh=6sM8da5LoKdhSaDEe0PjHdmiWnItuePL6eAY8XKlK7U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YeW11yVXog0J0AQbPneqrB0lC5kwfDw9MlRJeB2YgjjXGJfuzIaJ54jr+Q7Svmq1E
         9CdIx0zj8bVg2fdRHUbwNDWgo52cYIcGeUAU7paC2itzUDjY7IdkZ7ZQg7HSsZdOjf
         FgX74wEzCtWRrxgVVUU4YTfkr8jWlczj23pyyk4w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200812173942.1753107-1-sboyd@kernel.org>
References: <20200812173942.1753107-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200812173942.1753107-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: dd9c697a944a02066877404b01e9fb7dcb3a2218
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05a5b5d8a2cd82e2bf5a01ad064efa396ec7fbef
Message-Id: <159726229004.30367.13323706155878500230.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Aug 2020 19:58:10 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Aug 2020 10:39:42 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05a5b5d8a2cd82e2bf5a01ad064efa396ec7fbef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
