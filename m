Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBE4221A81
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 05:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgGPDFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 23:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgGPDFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:05:03 -0400
Subject: Re: [GIT PULL] clk fixes for v5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594868703;
        bh=y+xTj8vCUp7ZPxPNeTUclSzLv4VwPgxHMV0iB8/ctB8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cxJKxBddXfwjDIwakIHvXiXTNBWMS2X5RSgCCNdvAAhuHHMoWsq1a+KYr5vvrrwgc
         XNZFvbGxi8IYs0UQoE75AfXTK30QzLZVKsGEahRd80A99pksDb2cnrwRnWSiNNqMXo
         yQgG2M4EmPR+algVoMkye1JkR9s/IEjTtBLVNTtk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200716012221.2640243-1-sboyd@kernel.org>
References: <20200716012221.2640243-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200716012221.2640243-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
 tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 1e7468bd9d30a21e059af477106dc5588ae52dff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8456690ba8eb18ea4714e68554e242a04f65cff
Message-Id: <159486870344.19183.9720520100761121739.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Jul 2020 03:05:03 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 Jul 2020 18:22:21 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8456690ba8eb18ea4714e68554e242a04f65cff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
