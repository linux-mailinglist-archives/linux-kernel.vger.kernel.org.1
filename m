Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46F12913A5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 20:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438883AbgJQSWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 14:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438860AbgJQSWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 14:22:43 -0400
Subject: Re: [GIT PULL] i3c: Changes for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602958963;
        bh=Gv/bkIYAhOGl1ujTnQXPN0P4o3jZrQsS2S6rGbjH6l8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bQ8PqnN6tgNBmGWgbMR6S7YC1IcP9G1N0Uxd6CpPtZC9Ik+5MAuq6p9J1v+r/NP9j
         BxtCYyffE8kIJOHWvvE7q73uLHQD3mlvkyixzjRZiXJyvkhESLyEbqhemdcJ/59F12
         m9gLYKukYC2sbtAICOqo7ONxtNPdLuQMUXK7yNnI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201017100247.475552a8@collabora.com>
References: <20201017100247.475552a8@collabora.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201017100247.475552a8@collabora.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.10
X-PR-Tracked-Commit-Id: abea14bfdebbe9bd02f2ad24a1f3a878ed21c8f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a934b38c066ff221b08a9c703314a2a1c885dbd
Message-Id: <160295896308.15185.7603097111391328499.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Oct 2020 18:22:43 +0000
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 17 Oct 2020 10:02:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a934b38c066ff221b08a9c703314a2a1c885dbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
