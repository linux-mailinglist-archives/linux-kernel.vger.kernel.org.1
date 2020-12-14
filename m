Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D84F2DA316
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440244AbgLNWO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:14:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407277AbgLNWEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:04:08 -0500
Subject: Re: [GIT PULL] x86/platform for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607983364;
        bh=Me7IxE57L/kun2IQChiLPYFtAEiiy85FTC1GOg8dhC0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N5AF2ELoujD5qBtNonAYedLwDRwl2cfGgGaH3QNE1bcsq+Gs8gV+4dzqEK8L3CIT2
         mt92iIxyDLLSSG2N6m36I+nOZ+TeKLXOC4c/ob1ygX2YAR4FG4Pmshbno9O4WKC40t
         Iqa2MmxP9VAt/U+t3lgnQGJnN+lWJm4wAVVJzsDD70wdYMdqwDjuL6jgVD2nejzEY9
         gj6vl+OFNbNLgc+eVe06vczqWHl8+ulul2cm9Bt7uboGIF40+zTWgXrfnyqmD92wLm
         6DCBiK86Ig3ecu1TTMpu7g+ICl4xVuazWbThvPZJTnp1b4nvmtjYX6jXM8Dmig4+QT
         lZUU49n3+HaxQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214122340.GH26358@zn.tnic>
References: <20201214122340.GH26358@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214122340.GH26358@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.11
X-PR-Tracked-Commit-Id: c9624cb7db1c418cbdc8fd2cde6835f83cd0f8a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae1c1a8fd9c3f504b390df26b4af8ef6bfde005e
Message-Id: <160798336472.30284.9583791558428029015.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 22:02:44 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 13:23:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae1c1a8fd9c3f504b390df26b4af8ef6bfde005e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
