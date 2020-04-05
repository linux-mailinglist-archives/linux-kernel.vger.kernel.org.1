Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0019EDAA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 21:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgDETpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 15:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728256AbgDETpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:45:24 -0400
Subject: Re: [GIT PULL] clk changes for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586115924;
        bh=3IHKwnXpIzo1suvD0zeSMaeRpR8QsPyvBQbAQrXTABA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PokvqVxz0h4sG3UN6lnGAycyAvDVal+gTaDQ6n1qRen8s/9RMgQzTSRl1tSbwfuKk
         Wn0w/+GUiChshC/HRpItcXnTX7V8kI6MucccF+8Mf3j8IcVHwJQWPS7HnWh6uwqkjn
         Ljk3vxUBswIsnoQAV2vXB/8I3mhNYzbarsyQm/ic=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200405025345.156578-1-sboyd@kernel.org>
References: <20200405025345.156578-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200405025345.156578-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-for-linus
X-PR-Tracked-Commit-Id: 28ecaf1c30fe3f616eef5ab2dd5990399957234e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 347619565197ae0e62a755efc4a80904d66fc0a1
Message-Id: <158611592429.11305.10817547674341736093.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Apr 2020 19:45:24 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  4 Apr 2020 19:53:45 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/347619565197ae0e62a755efc4a80904d66fc0a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
