Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB7320CAE0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 00:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgF1WFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 18:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbgF1WFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 18:05:16 -0400
Subject: Re: [GIT PULL 2/2] ARM: OMAP fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593381916;
        bh=Fnc9QOsASMf5/SbTLhYqgQ7Pg4bsdcxa7sFpscgc3o4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RXOxG6AGk1NM9DHi5wOl5XFdKUBF2eAun0qn7RUcJhimDs30G5YNzc5VEUXEpynqy
         HJXCrEYPq1mN+YsRbzCsz2vdT0nqPWCcuWhSPgTUADm1JaWbbXPDoPNd9ZAQ8jQmDo
         EjHGc4vRxNu1zWzSgFOT0aMcuFGcv4npyatRQf88=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1v63iuCqs66kik7UiojjCDAr157MsU9_4+2iP-ZCiUvw@mail.gmail.com>
References: <CAK8P3a1rUGkoHanEGfc+o8bjgZO=T-40-e-wy+ECLxuU_pT97A@mail.gmail.com>
 <CAK8P3a1pbjKE7EX5+UYZbzWMAZ9kjftodURZ+vgrCQ3Cn2vj+A@mail.gmail.com>
 <CAK8P3a1v63iuCqs66kik7UiojjCDAr157MsU9_4+2iP-ZCiUvw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1v63iuCqs66kik7UiojjCDAr157MsU9_4+2iP-ZCiUvw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
 tags/arm-omap-fixes-5.8-1
X-PR-Tracked-Commit-Id: d528945d7762be94beca4c111bb95dcc9a9f39c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7db192b2d71ea42627a32349d59a5f99f2aafcc
Message-Id: <159338191611.4690.8999204724559676442.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jun 2020 22:05:16 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Jun 2020 22:01:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-omap-fixes-5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7db192b2d71ea42627a32349d59a5f99f2aafcc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
