Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EB228BF9A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390959AbgJLSVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390898AbgJLSVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:06 -0400
Subject: Re: [GIT PULL] x86/fsgsbase updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526865;
        bh=Y5Li0V+rFU5AIprxwP/0oBhl//cTfMmxxjok8sScuzA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aMUxSSH+OzMndRUXRENrBbPjM9wQE+EC6ed89Ef3QYHMuvHO1DJtu4jqMlyKbnSfS
         KpW+y/P6ogAfm5X3/NFAoINRGGVE85h7fav8w7vNclqP5UfCTCQIG5ojRhHiGZ3EkX
         icr85lmqdDZ6FOEmylbq0HibKIao+a55XMbS5O+U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012104327.GG25311@zn.tnic>
References: <20201012104327.GG25311@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012104327.GG25311@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fsgsbase_for_v5.10
X-PR-Tracked-Commit-Id: 1b9abd1755ad947d7c9913e92e7837b533124c90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87194efe7ecdf8d145c7cef130fda9652bf77fd7
Message-Id: <160252686528.3643.555057502900087424.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 12:43:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fsgsbase_for_v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87194efe7ecdf8d145c7cef130fda9652bf77fd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
