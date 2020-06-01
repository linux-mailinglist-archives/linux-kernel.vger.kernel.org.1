Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD101EAFB5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 21:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgFATfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 15:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729562AbgFATfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:08 -0400
Subject: Re: [GIT PULL] pstore updates for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591040107;
        bh=Rbv7hBnW3EpHxDajbLG3Ri22FPL/dqP1vTr1TzMT6/o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UhjooikbsIzCMB1OUGUvHrQbqVHb3BL044F9t6SN4Fjm+oKLOIFOIqvlDjkSrkYVl
         jGToHeWS2WY1QObBueK6vo89pPDBYaSKtzYAVLLujJDCPklvcG38slJcWJPujw280p
         srH0jnEmp3cLAc3J3ywqgLjn5K3h8pz7xHDFc4WQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202005311953.13A77CF20@keescook>
References: <202005311953.13A77CF20@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202005311953.13A77CF20@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/pstore-v5.8-rc1
X-PR-Tracked-Commit-Id: 78c08247b9d3e03192f8b359aa079024e805a948
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 829f3b9401fe7cc3c1f3642bb2520751a42a87df
Message-Id: <159104010768.18844.17146340652119367602.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 19:35:07 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Luis Henriques <lhenriques@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 May 2020 19:57:25 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/829f3b9401fe7cc3c1f3642bb2520751a42a87df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
