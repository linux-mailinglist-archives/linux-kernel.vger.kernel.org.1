Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8300B2EFCAD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 02:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbhAIBVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 20:21:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbhAIBVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 20:21:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EA10D23AAC;
        Sat,  9 Jan 2021 01:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610155267;
        bh=Kb/8aAXs0PFLWbmp9okBHZ2C+p6Ry7yev34Q/VcU3RM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Bn3RhelCCIEazEf7U/CybLjkyeJclxRfecvIoASMtDLe6yYCeUbISnovobOdED3T+
         QFgBtdmdus4uKk0ApNQKUigiPnOAvv2C5mcKWkb4GMFrd8lhzlqpyIEhPiFBljVO74
         5BvqNe93YJ/WeQrxTeH8mFGBZHi+g50RQzisx96qUIYdc53RlynJ4JbZoBdbiXJF+Z
         A3cUSdotXvYQNiyur+/CTpBQusxVQfYQdGzN4U5bxY9HQ9PyqzTUiJh6x6b5Gjd/cD
         9JUxBFQwHC4lsRSwPxxH+1IFYWH9pFE8oRNHO2z30UFroJRFM6hRvzayprqDPJ8Qjf
         m2bptzyUxdw6Q==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id E5A646013F;
        Sat,  9 Jan 2021 01:21:06 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210108103120.73a35ba6@lwn.net>
References: <20210108103120.73a35ba6@lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210108103120.73a35ba6@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.11-3
X-PR-Tracked-Commit-Id: 9d54ee78aef62c29b15ae2f58a70b1d1cd63a8f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50dbd96e4f31e28fc2fcc80abaabab4fb277227c
Message-Id: <161015526693.8938.891628517679729678.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Jan 2021 01:21:06 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Jan 2021 10:31:20 -0700:

> git://git.lwn.net/linux.git tags/docs-5.11-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50dbd96e4f31e28fc2fcc80abaabab4fb277227c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
