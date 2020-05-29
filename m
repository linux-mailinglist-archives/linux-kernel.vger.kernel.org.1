Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD31E8990
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 23:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgE2VKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 17:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbgE2VKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:10:06 -0400
Subject: Re: [GIT PULL] GFS2 fix for v5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786605;
        bh=bc8wIUt8a4wMIp7OWkd0NWWttBsIK+rLxxFxaj4xGE4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EYEDydEq2n8NcKd6MViS9U1F4DBYrNpppk0gcz0zRfuiZpeuZjXDvkOtd3eXzZGX9
         /p/p2TfFj7LfnFlS/inrv7vif1MpcjWU04DumVMV7bptH9yQsJiujUd7rh3UOHRuHt
         DYU0zxVYUH3JDbL5idX8OoGeYCL0JdiULZ6r3XnY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHc6FU6RofgpBz0t_DxGMKDbHJrVMcwHVBh63Pa6Tu2Wbiuaww@mail.gmail.com>
References: <CAHc6FU6RofgpBz0t_DxGMKDbHJrVMcwHVBh63Pa6Tu2Wbiuaww@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHc6FU6RofgpBz0t_DxGMKDbHJrVMcwHVBh63Pa6Tu2Wbiuaww@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
 tags/gfs2-v5.7-rc7.fixes
X-PR-Tracked-Commit-Id: 20be493b787cd581c9fffad7fcd6bfbe6af1050c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 835e36b1197a4f066d0254c897f2c8b455cbb581
Message-Id: <159078660565.32003.9740215447484581952.pr-tracker-bot@kernel.org>
Date:   Fri, 29 May 2020 21:10:05 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 May 2020 17:11:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.7-rc7.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/835e36b1197a4f066d0254c897f2c8b455cbb581

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
