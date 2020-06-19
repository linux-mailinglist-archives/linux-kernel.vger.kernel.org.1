Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB8201B48
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 21:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388835AbgFSTan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 15:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388591AbgFSTaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:30:23 -0400
Subject: Re: [GIT PULL] arm64 fixes for -rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592595023;
        bh=GbYtQWwyn7CFpkEbNk3qKLdPXqNLZE/UCw4WDDQ3AB8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fvtfLi/jDcs+ImKWK9CSBCYCiMzjLCde9FYJWcQoUtNzQdGXeMcibo8tl699v4n19
         I5FFbbGMQi3EVQPNClRw7+p0G3/1cLviUMvzn3Kb/MGVhUkYaU9sSvq/Bu6qJd4aTp
         S5rWCo0YTnpS6e4rc6cYybEY3CyiPwVrHbwSKk+Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200619124318.GA6925@willie-the-truck>
References: <20200619124318.GA6925@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200619124318.GA6925@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 24ebec25fb270100e252b19c288e21bd7d8cc7f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84bc1993e28b2d3cf6110bab0b625e8119825403
Message-Id: <159259502364.2705.14212792402012859293.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jun 2020 19:30:23 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jun 2020 13:43:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84bc1993e28b2d3cf6110bab0b625e8119825403

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
