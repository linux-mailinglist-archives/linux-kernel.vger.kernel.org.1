Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD6297755
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755137AbgJWSxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755124AbgJWSxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:53:18 -0400
Subject: Re: [GIT PULL] More arm64 updates for -rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603479198;
        bh=wyQOfmcmzLnzDsDrpiUfI+TKiJQTY9lGY8lMrooXQB4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gWy+SbCa/MNxV/jNskBeDzgUoinD71KboGHJqSI9RGnfClMpL9A2zYvNc/V1Z3rYt
         519dZQzktzNc9r7PPH+ZiDtSla9UO83VpIhBk9kAyVLv8tteexNi3By6W97W3UEvAA
         XQ8QsP02mRD23VVhWVQtwR4yH1UpULRvJrGya/k4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201022161948.GA19780@willie-the-truck>
References: <20201022161948.GA19780@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201022161948.GA19780@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
X-PR-Tracked-Commit-Id: 66dd3474702aa98d5844367e1577cdad78ef7c65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 032c7ed958174957a4d6eac61806f66e1123d815
Message-Id: <160347919799.2166.12198363463857720670.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Oct 2020 18:53:17 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Oct 2020 17:19:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/032c7ed958174957a4d6eac61806f66e1123d815

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
