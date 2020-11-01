Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9B02A2119
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 20:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgKAT1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 14:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgKAT1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 14:27:03 -0500
Subject: Re: [GIT pull] timers/urgent for v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604258822;
        bh=psGzaAgri6MbLLs2emRuMNmk4Q2gOD2iewReLwbyA/I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L9w19bZZf42Lf+TPviQxvw2XRG6Iv/E8YReZDweGhomWRMJfiiNCr0HvYIiUapN0v
         J1RoF0AZaivhCnqDPDy9bFIigVXYslG5v4GYpZgZ7HNBNjCt0/ZbROLo4PU6pgd9Sw
         XAqYnhKUm0iwwPVC6xYu15MVdpE3kKJsZcYJtOtU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160423896377.5667.2321676473760468647.tglx@nanos>
References: <160423896136.5667.9743580255833470691.tglx@nanos> <160423896377.5667.2321676473760468647.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160423896377.5667.2321676473760468647.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-11-01
X-PR-Tracked-Commit-Id: cb47755725da7b90fecbb2aa82ac3b24a7adb89b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4312e0e8d3eab027d9506db091eb10e6a9ff25d3
Message-Id: <160425882277.14673.15872369069228780782.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Nov 2020 19:27:02 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 01 Nov 2020 13:56:03 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-11-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4312e0e8d3eab027d9506db091eb10e6a9ff25d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
