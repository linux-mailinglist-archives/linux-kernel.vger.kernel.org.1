Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D909629659D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370546AbgJVUEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370531AbgJVUET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:04:19 -0400
Subject: Re: [GIT PULL] clk changes for the merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603397057;
        bh=NZ84bof7DZ+1YC3U/xJbu2fzkM/XIQU4ubbCEQFhsAw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=q3nrmtor5ENeN7f1yjL0c4S3iMx9+5TA5F7O2uJybO3sk9COZlyLnHHog7T27S1aB
         jJ9aj94lXJ/RUoKEjpsJa8Jeii1R8YlhzsDRNElJVr1Rx7ixi2ykzceXEPteGtdFVb
         3bFZExAdqKk+W5WWOtE/thglii28wj5RcCeD9B50=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201022184833.405787-1-sboyd@kernel.org>
References: <20201022184833.405787-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201022184833.405787-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 5f56888fad46812bab9ecb455d92da675ef4fbd0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fec0eaaf04adf5e23b2704f5490d5943fb8b0b1
Message-Id: <160339705758.15216.3229236098452211879.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Oct 2020 20:04:17 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Oct 2020 11:48:33 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fec0eaaf04adf5e23b2704f5490d5943fb8b0b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
