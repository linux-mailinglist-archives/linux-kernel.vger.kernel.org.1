Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCA6301E2C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 19:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbhAXSgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 13:36:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbhAXSgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 13:36:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 796C222DBF;
        Sun, 24 Jan 2021 18:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611513293;
        bh=X+wuD6Oc8850mtdki70iJnXVmcefVwDHUMTE+M+g4bM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hs64jHUNd+LCwW1ZcLw94MaO+jW7ANAhwEgZHj6spBHN4XITrtsqCPmzwNtJGscMT
         Se1/PDZrVbpK6MdWjWPJQB6czsa2+/eLlh2pI4Ghnzn3YslyyYOke8GU3VeE0+cgft
         RjbIQ2vdy5XUw71anTLnaq5Por3BCdvTxeHWwAEiPTcpoSY5YBvOXoZk+sT4rvqNMb
         ThE4Tk3zweYp/NMiW9HFpRkoHegpbZYLLLGNXTORcJsiRP5u9ebAaEdrbat7bv0/xp
         TtetWCT8AL6vl9UFoSuv8qSZZvpYneiHLJacci3XCIO5vpoueFBIABXgZJhSiIU8nC
         eb3sftVb0bNvg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 737AB652E1;
        Sun, 24 Jan 2021 18:34:53 +0000 (UTC)
Subject: Re: [GIT PULL] objtool/urgent for v5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210124121539.GD2493@zn.tnic>
References: <20210124121539.GD2493@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210124121539.GD2493@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.11_rc5
X-PR-Tracked-Commit-Id: 1d489151e9f9d1647110277ff77282fe4d96d09b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32d43270ca0bbb6240369a3cdecc3f3d43acbd29
Message-Id: <161151329346.2223.14089534895195357179.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 18:34:53 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Jan 2021 13:15:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.11_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32d43270ca0bbb6240369a3cdecc3f3d43acbd29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
