Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BA620C2E3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jun 2020 18:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgF0QAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 12:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgF0QAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 12:00:14 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-4 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593273613;
        bh=MbNap/6N+0BX1tTgTQ3TIOSj00gjCxz9iGVf1N8Dx5o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TJ2oXys3tu6oGwsVg+vdudawKeTeVdBi9a4B9a3tnlbVEJbZrRkzACBYQsv5bfGNa
         KPdeyrIJtzCQ1WcWY995cpnRyZUqIE5cOnmVHz5QyiOxqj8mqztO1xe4C+D6hn47gg
         RNes1MLXkA4aAolqM3/jq07bS6vxoLDe9SqPrgCA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87h7uwbtn3.fsf@mpe.ellerman.id.au>
References: <87h7uwbtn3.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87h7uwbtn3.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.8-4
X-PR-Tracked-Commit-Id: 896066aa0685af3434637998b76218c2045142a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21d2f6850c09fdec730c11d35406da1dc541432d
Message-Id: <159327361359.7015.1358851817196158940.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 16:00:13 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, asolokha@kb.kras.ru,
        harish@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, oss@buserror.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jun 2020 22:06:08 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.8-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21d2f6850c09fdec730c11d35406da1dc541432d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
