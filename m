Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9F3301E2A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 19:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbhAXSfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 13:35:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbhAXSfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 13:35:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 571CE22D57;
        Sun, 24 Jan 2021 18:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611513293;
        bh=UPAnb26haIDHHsptwlGWp/XWCFyjmh/MsUN5r+o8AOk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cvzPYX8JnJwd6uvoZ0x1qw5T+KjVhxlyS/0RYaTwL49EIGxwEaadjx7rsM7sVR6uR
         bL1yXjzmhsDuliVxKE/jRpdI8ndOoNUekdIIl065vZUPDy7P3f38euizUcUUUwSFU3
         hiFnwWIOMJt0DipnK6CIWKCOrb7kRcRl6MMer1vzAkzlKv1QEzAvkgdI8IoFX7gxCU
         D81Mh0M4N83ERsRCxGnU5Jjzz9dXcxgoitzKwTx5UvN6rgaIWYhSrQG3HMJPxU4ZPb
         P4rJ9yE1M4mgsPfUrlAN2wSuTuUP+n9MxqOtSMPMZIOaYjg3XAjL1ZKhX59YWRLgCu
         AeKVC/5JHJUzg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4A657652F2;
        Sun, 24 Jan 2021 18:34:53 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210124111126.GB2493@zn.tnic>
References: <20210124111126.GB2493@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210124111126.GB2493@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.11_rc5
X-PR-Tracked-Commit-Id: e3fab2f3de081e98c50b7b4ace1b040161d95310
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 025929f46813c572d4ef0b379c704bf664e8a7a3
Message-Id: <161151329329.2223.7561635432286494228.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 18:34:53 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Jan 2021 12:11:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.11_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/025929f46813c572d4ef0b379c704bf664e8a7a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
