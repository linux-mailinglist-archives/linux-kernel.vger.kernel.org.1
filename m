Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4677B301E28
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 19:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbhAXSfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 13:35:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbhAXSfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 13:35:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6A6E122D58;
        Sun, 24 Jan 2021 18:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611513293;
        bh=oIXyenTz3mMd67Qs32oTDstWaphLAfHFwjhf67YoOcw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Cpr6xHV+oWhuk6WZ0gTLjAggFS7fuzrn0bONzVc/z/nXuNElRk/P0febQOpGKbZpi
         bEkiF6M0DJ1E702lyPi6xjOcjKFN3JXZmnt1MuZADvncQT5ouXeCWFClMu6b8R4p1i
         aADEh2oGiiasj4rxD6VOjL/2pug/2HyeH0PMx2kNQmTZZaw2EGM09I1Vi7apECfehD
         /J98OYuoxVM7p/m4aJ7cULr8FduYq2e2w0dk2YlnjtEHlMFYZVy85tjQrtjW1VXwZQ
         usTB+XsJOrUEbfuHYam5XhDVGEABvTyY46oXEcRUFN1s/w+F3f4cUVmUsb/DvG7xJM
         D6yoRipEx+spw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5F9DE652F4;
        Sun, 24 Jan 2021 18:34:53 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210124115819.GC2493@zn.tnic>
References: <20210124115819.GC2493@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210124115819.GC2493@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.11_rc5
X-PR-Tracked-Commit-Id: 741ba80f6f9a4702089c122129f22df9774b3e64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24c56ee06c4d4b410ac1d248869c14e391d66b8c
Message-Id: <161151329338.2223.4763220806987433882.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 18:34:53 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Jan 2021 12:58:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.11_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24c56ee06c4d4b410ac1d248869c14e391d66b8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
