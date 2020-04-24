Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD501B7DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 20:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgDXSkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 14:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbgDXSkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:40:21 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587753621;
        bh=XMHfIkXrfaPqnQ4CRxrw3tUHPN9cUoylQyWVU5X+sc0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hE+octv3R7mBpFsh1sG84qTHjvJ7seFwa0b24D4Or+rImymdJKG74x0qEQolW1rQi
         1Ot/vcss8IeZ7qFyNzKj1rgW2lcBWyrGFX7XC/2o6aUC5bjVbnP1MgkqWB9sHr/Giw
         qe/0uMrGppNKJEa9NXpVN23w7pv9wxPlr4sUL3w8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200424170440.GA29363@gaia>
References: <20200424170440.GA29363@gaia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200424170440.GA29363@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 59bff30ad6cec6b5babc8132eb8dcb48f1c82be0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4544db3f848f1d5d0f48d39c22c9636aecf73cf6
Message-Id: <158775362098.26557.2207011730746868688.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Apr 2020 18:40:20 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Apr 2020 18:04:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4544db3f848f1d5d0f48d39c22c9636aecf73cf6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
