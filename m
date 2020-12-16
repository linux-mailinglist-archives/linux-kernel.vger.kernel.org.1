Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B362DB9C4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 04:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgLPDpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 22:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgLPDpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:45:30 -0500
Subject: Re: [git pull] misc followups to regset work
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608090251;
        bh=5IaOFsYMCF8ZhwzTZynHmQfnf14awWWBpDDdi9oXslk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oVuXrqBBTcj7VI9nBGWM8h1ejIqpbIpuY1+BzNseeOZc6FR+/QkTj8qoZPnDyAUYC
         CW1DId1ltSYL+GjEfdkqTpF9FgSbB3mV2bWpf5oA/ex5fl1kDNloFr2b10gjrfPzj0
         bJ4BcdXUxyahMf9+ICrQlHrRkhrWv8+KDJcDH8w/TiMcSvqBCg1O8trGS0eTN+yRTq
         AU+H0sYpWwK6TBATMIvNJyZLiGRnl1SnsmEwQoizruIQZY+7nxCKJwxDCzT5/oB8YJ
         UwxkpYmjU5c8yZ2hxdcxoptT/IRE8StoFYI420iQubm287+VUOD5qikX2lWH+lh+3W
         d3E7S9XmBfAAQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214225107.GD3579531@ZenIV.linux.org.uk>
References: <20201214225107.GD3579531@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214225107.GD3579531@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git regset.followup
X-PR-Tracked-Commit-Id: d4948d19d47f08f926db55f0fb8cb324e43f1c19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37373d9c37a3401c08f22b61de1726b4f584b2e7
Message-Id: <160809025126.9893.4874457605720855891.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 03:44:11 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 22:51:07 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git regset.followup

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37373d9c37a3401c08f22b61de1726b4f584b2e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
