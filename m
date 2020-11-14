Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A2A2B30C0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 21:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKNUvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 15:51:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgKNUvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 15:51:11 -0500
Subject: Re: [GIT PULL] clk fixes for v5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605387071;
        bh=ng932+sMmoLWETM7EetcAe2BvZK160C/+eUt73vGsLI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WevQ520gjMSeiqZ2a4sWPCH9BtJ2f8PJkOBRtSglKhu3r1BStEsEVCackyoGkfyQN
         pnnicL3XI13BAZNjmrW2Eo/8NR1aQBpDnF/nsNUiqH2CTPya0EuWMbq83t7SgSgDUu
         poaBHYIHThHzfgiGVkR1qjys3oU2cJQIxO8GgQK0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201114193934.785014-1-sboyd@kernel.org>
References: <20201114193934.785014-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201114193934.785014-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: c277ca155d2f0028a5c79708426d3f79b54a5fc1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31908a604ced3c047022c2cc9f178d3287f06dfe
Message-Id: <160538707119.24878.5958352246888446896.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Nov 2020 20:51:11 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Nov 2020 11:39:34 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31908a604ced3c047022c2cc9f178d3287f06dfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
