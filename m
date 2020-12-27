Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6776B2E3229
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 18:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgL0R1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 12:27:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgL0R1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 12:27:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9E2D822507;
        Sun, 27 Dec 2020 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609090025;
        bh=ilAn7Rfll0y1NfyGkRYpfnmzaX3Npvc11AfYS8OTXKI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ODaLI94rm/CK2Gr5Z3HfNSnMmZVN8ZbSN38Ew13H62QG2ogiYtB0fKgKr0W0NtGJK
         s9QtfOjCpS2sfBWuBZYt4Gtd9w8R1IEDV+MFSwtexg0MrD/GBX3EnPtFt5gL4X+i6Y
         43YT6qX59wpOGzMLlDn/6/V2oX8GdQS0wDOAOnKg+inGJtO4ilEdgWfWw7ceHYbiU2
         XvtSVzwMhBA4NqE8Tt0oYYGPcfqqf8vKHaNwBlD+KhBzWYMzJs8q6ShD2wTBafzPT9
         HWh24PjhOZrv8127GSpw4/tJesMCuGJHP+srzfmMUr9Z4XSfg9qQ6NuTt5OL4Xy2ws
         0dMeyPBvqc2kg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 8B29C604E4;
        Sun, 27 Dec 2020 17:27:05 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201227091601.GA1564184@gmail.com>
References: <20201227091601.GA1564184@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201227091601.GA1564184@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-12-27
X-PR-Tracked-Commit-Id: ae7927023243dcc7389b2d59b16c09cbbeaecc36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b80dee70eaa5f9a120db058c30cc8e63c443571
Message-Id: <160909002549.19416.3409188698923075918.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Dec 2020 17:27:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Dec 2020 10:16:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-12-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b80dee70eaa5f9a120db058c30cc8e63c443571

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
