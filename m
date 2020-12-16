Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E102DC7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgLPURR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:17:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbgLPURR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:17:17 -0500
Subject: Re: [GIT PULL] arch/microblaze patches for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608149796;
        bh=kiHk/KDlV8iqTBeIP26YgDcvrsfzhKcYL0m7arQ6yCo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NiJyDGGoxQaSLNDrtbDaOJPExtm2qDa+STBvy5ng9sBHwqae+Q0ktMnnorNgcPObU
         q1B64uPTiRRnEtncOaRUMPT4ELRQjG1ajNovElGFCb4AoQ7HG50GYWj+fz5aLJOKND
         VZqOpMIi1tmKHvi5vRyb95I9bEsv4s8AzevUrsqPYIzDsIZI70xW5YLeYiNIYJ+7ub
         1OATsyi9osI4oh1XbReQu2mjY+1tS5kYQPpb3tRyuQ9gtqxfa7YS04lRoIrENw5KhS
         91z8SwXLbcOaokKdViukDHDwWLU+9xfaoV6NNpavG3tpJa1Gkz5mfNVoWMqUEhKW4w
         o4xph7pmEp+JA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e14ec382-aaa4-b7d4-3134-1d79bcd1e28f@monstr.eu>
References: <e14ec382-aaa4-b7d4-3134-1d79bcd1e28f@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e14ec382-aaa4-b7d4-3134-1d79bcd1e28f@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.11
X-PR-Tracked-Commit-Id: 05cdf457477d6603b207d91873f0a3d4c7f8c1cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66fc6a6254c7a138aef7806bd933c218e1aefcfc
Message-Id: <160814979663.31129.14370093842462210521.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 20:16:36 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Dec 2020 11:21:47 +0100:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66fc6a6254c7a138aef7806bd933c218e1aefcfc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
