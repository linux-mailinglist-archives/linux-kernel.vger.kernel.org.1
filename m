Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7FC27048B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIRTEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgIRTEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:04:20 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600455859;
        bh=UZxtWMGND6uRb1uGr4redgVLMMCnPZ5UqlfH19fGyqU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y6sCrfj0ysHjyTwEV2tTUBZHzG71iTOjkJr1nwWCSONkCv2lxMF9NeYkMDp7qNZPZ
         X0GcJNlG3HgzL+GApfEvol+L5Xv0D0oYAzqIATbE07AXYH5xxbslLiWpyVaYk8M9Wi
         1MgCpe/m+MFCRfKEGUozUQe0Zfc54jgFwt8jeJS4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200918161314.GA9698@gaia>
References: <20200918161314.GA9698@gaia>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20200918161314.GA9698@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 75df529bec9110dad43ab30e2d9490242529e8b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69828c475d15290553cb5512108424746baf6225
Message-Id: <160045585979.18461.17805569160623323306.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Sep 2020 19:04:19 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Sep 2020 17:13:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69828c475d15290553cb5512108424746baf6225

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
