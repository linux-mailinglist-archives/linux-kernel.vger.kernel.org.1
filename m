Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423721DED74
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 18:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgEVQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 12:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbgEVQkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:40:04 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590165604;
        bh=HlMsY2TCnZZkKkInPKLHL5tZipWUDQ/YJ0xYqIon3TE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vX4RQiLyOqAvIsM1AJbzkoKKepYyRLzwzpqNJ2H1VW+AzS1gv+2M/dn8WIiKsf0hf
         CjZhBwN6WXqFPF6ffkBs7FB6AIGljE6+F551xsSYUs6BBqi6gj8GOX2Ce9lfMCUSzF
         kKh1vam7/9XgWB8X5gpJ6eHkLKsGktNIci8MgjvA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200522162815.GA20565@gaia>
References: <20200522162815.GA20565@gaia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200522162815.GA20565@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 8cfb347ad0cffdbfc69c82506fb3be9429563211
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4286d192c803571e8ca43b0f1f8ea04d663a278a
Message-Id: <159016560417.11923.8720349875291559683.pr-tracker-bot@kernel.org>
Date:   Fri, 22 May 2020 16:40:04 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 May 2020 17:28:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4286d192c803571e8ca43b0f1f8ea04d663a278a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
