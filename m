Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064F71EAFAD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 21:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgFATfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 15:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729597AbgFATfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:09 -0400
Subject: Re: [GIT PULL] x86/microcode for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591040109;
        bh=7bMaE1BmVXH0C5ALZi4PP2JLkyi4q3XnWCx+197tjbU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y1FadWCYXrwK95X4jszcO9NyuZJUKEnVYK0UNhP1MSkjpE9R2B6XvUXqR70AhDxLt
         VdhVN1N+LeTamuJzXOj+kMLetkC3jeeaGY3I8our3X7aSbWcX3/dn2Gax1JSGPYOGc
         zIXL2kxyjuexeFIO3EaLw9CLqIqdrbbbRyur8QH4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601093113.GA30795@zn.tnic>
References: <20200601093113.GA30795@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601093113.GA30795@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 tags/x86_microcode_for_5.8
X-PR-Tracked-Commit-Id: 9adbf3c609af92a57a73000a3cb8f4c2d307dfa3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef34ba6d36af9e6f5918f7f7e287be4b70a358b4
Message-Id: <159104010914.18844.11094578066329972974.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 19:35:09 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 11:31:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef34ba6d36af9e6f5918f7f7e287be4b70a358b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
