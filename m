Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922F428BF95
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgJLSVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:21:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390868AbgJLSVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:06 -0400
Subject: Re: [GIT PULL] x86/misc updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526865;
        bh=OMc3F/abMaLCcjWinoB41ky4NF448J6T4FeQEVfH0/I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BJLEH9PnouLHb029Ze73ZNgvSCQqRPbZhMqRjAB05WbtP1QlIFlOj0fVlwvP7ob0Z
         ODZnXndl0iIhRUL/2ZOXjiHpKDhz2UB2O6jKeUC4EVfy1EVJUQgdN+MJyQRFkPZxrI
         QV4fgJoUeQUY9shfgGGF92zaICF7yIw1zii7eEMI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012102229.GF25311@zn.tnic>
References: <20201012102229.GF25311@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012102229.GF25311@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.10
X-PR-Tracked-Commit-Id: f94c91f7ba3ba7de2bc8aa31be28e1abb22f849e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e536c817960c698c23feed6f9bff6d192805543
Message-Id: <160252686507.3643.11777714603404430632.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 12:22:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e536c817960c698c23feed6f9bff6d192805543

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
