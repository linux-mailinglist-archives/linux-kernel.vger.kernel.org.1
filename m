Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D3823C1E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 00:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgHDWZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 18:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgHDWZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 18:25:09 -0400
Subject: Re: [GIT PULL] thread changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596579908;
        bh=kusxYU43EZ5r4r3uSHQpemHyx4JJswqloQDOdpqnn6M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Owu65JEuY9jPkfswno34ITq0CY6yPAyefGfyPxAqjbipedSJbRTunJMnb9f60t48l
         sT6KS96Jqz631gqMY62+ePphUmqVqZFWC6YwBtNrLmMvJvlQP8RqL0pZQnHzva96BZ
         XmGG4Z58U0V0KzqXiwlfn5Ha/mNc67Y1O6/u2v4A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200804112445.72138-1-christian.brauner@ubuntu.com>
References: <20200804112445.72138-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200804112445.72138-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/threads-v5.9
X-PR-Tracked-Commit-Id: 55d9ad97e417cc2604654913e902d26f942bde00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a72761b27fe3b10e3f336bf2f2aa22635504cdd
Message-Id: <159657990812.8406.17387508782905344116.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 22:25:08 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  4 Aug 2020 13:24:45 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/threads-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a72761b27fe3b10e3f336bf2f2aa22635504cdd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
