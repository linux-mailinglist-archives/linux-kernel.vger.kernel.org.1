Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2942DA0EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 20:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502817AbgLNTwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 14:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387981AbgLNTwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 14:52:07 -0500
Subject: Re: [GIT PULL] auxdisplay for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607975487;
        bh=zbu/xJU8vAoLFc8ITBJFvL1RBRSng0rNP0g0sB4vQKA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rSThr1aAG9LE3ND/eqIZIoqypPxHAL+BlXFczmRtBX74Sqg5PKNtiDfb7cEDn/Cph
         lL/5AgSRSDKatwm2zZnO69u5H3pmJezEMQLM7GY7oYI7i2xnQLCD1zZ1FvcIqGsMyB
         bHGs5ScH9+yJ/WKvXX2U5D29n9yptOcEu2x/PKeEP/r4amqe0Q4qYCDm+HMJidmyoJ
         sP/1mIO8fr0cKaHCLcvPNSz0v3sGne/g3NMpHywg3tDGlsNyb3/JM+kzrt0YB0zWeP
         /4Qyn40QQfcGIKEJblFWGR4EXt2RjiLeYchFBa2halFt3iqvBbO5vQhx1DqkUiGRHR
         UFTcXcFa6kGvA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201213042450.GA26048@kernel.org>
References: <20201213042450.GA26048@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201213042450.GA26048@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.11
X-PR-Tracked-Commit-Id: 351dcacc6d774258be9fec6f51c14f8ff38243f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bcc68bd8161261ceeb1a4ab02b5265758944f90d
Message-Id: <160797548696.21325.11054507534913941993.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 19:51:26 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Dec 2020 05:24:50 +0100:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bcc68bd8161261ceeb1a4ab02b5265758944f90d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
