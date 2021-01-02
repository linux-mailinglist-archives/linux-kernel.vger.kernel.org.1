Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D02F2E887F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 21:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbhABU1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 15:27:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbhABU1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 15:27:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9CFCE207A1;
        Sat,  2 Jan 2021 20:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609619186;
        bh=0LU8XV/UztxUfquSETa/AAMDq7X5LlTWzqHXnstp+aE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z2ZExL8yGNsbg+MnVoH9V6RRh8K4kczOE9wP4EA5TXs9BC+6Don2sJmOvXbpG+CWx
         YTqvVTx5FzjL282gkhMM7sm+jdQ3Rcs30NalYusZ/Z+L1rreLeXFyVa/IZnh/eWgLT
         1qrhZqCcEIQ/tHYmpHgVanpPLaUdqM7UzpQjYXD8q5pgl10FQrkjaKmz5A5nS4mauk
         CssCiL0L/ACQpCsiu5q30uH2bILw8KtrM6tVA320b/Z2PzSomQVC/Gvu/ndFNiJ1N5
         Ze8uv07LoBv2c0Uaq84UWuoomSpXepGvyPbVX+X9vigd1/8lh54kpv5jG77OfGublu
         FWoQ1pd/TIfbg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 90A9F6010F;
        Sat,  2 Jan 2021 20:26:26 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.11-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01609600444-ext-3658@work.hours>
References: <your-ad-here.call-01609600444-ext-3658@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01609600444-ext-3658@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.11-3
X-PR-Tracked-Commit-Id: 129975e75b9a2ba528d7f58be2e338cd644f6ed8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3516bd729358a2a9b090c1905bd2a3fa926e24c6
Message-Id: <160961918658.18509.15372417470607880149.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Jan 2021 20:26:26 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 2 Jan 2021 16:14:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.11-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3516bd729358a2a9b090c1905bd2a3fa926e24c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
