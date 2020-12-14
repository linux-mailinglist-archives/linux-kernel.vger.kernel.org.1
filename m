Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773C12DA310
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408509AbgLNWFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407337AbgLNWEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:04:08 -0500
Subject: Re: [GIT PULL] x86/misc updates for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607983364;
        bh=Mw0W0dsOUp8P7lhcjfrrsWtbNFyoMfrO0Flz2xZEC7k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J7XUyRT2sF4ZgkPX9JJ59gEUBlqXZpsCn7KwWPqLV57R3c0wxWqxkKZyXeb7T7sHE
         MCKdTZxrXkUdn0k06o5RhD55EuPX4AQtGHZ9pFA5yZXDyQsnLQvj/mVUIoRC9rsTc7
         gFV+2pUOEGP0eCps4spd5br/BbZs9uMI7kyyuFKbuldxwjpeDVdh40HQsMY4H4C2yF
         5+2rLiLBvCmOR/gBxpTH/xFUsHtGuFP8nTZ3oasx0BHZRmRjFbjStbqpTCPzA0WE+q
         Vl/5Px1OGg2vvEZVpfVc9qy/7KqUd4lI3nSyW//5/7H+LEfDxkZTxxBrPN+jw0SVOU
         n5XrENB5QgPrw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214120733.GF26358@zn.tnic>
References: <20201214120733.GF26358@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214120733.GF26358@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.11
X-PR-Tracked-Commit-Id: f77f420d34754b8d08ac6ebf094ff7193023196a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c70f046787505127f2f8bb60ad24bb3c8bfc61a
Message-Id: <160798336433.30284.2044224552513336551.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 22:02:44 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 13:07:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c70f046787505127f2f8bb60ad24bb3c8bfc61a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
