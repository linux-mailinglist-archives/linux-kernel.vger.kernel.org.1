Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541EC1A1721
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 23:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgDGVFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 17:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgDGVFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:05:10 -0400
Subject: Re: [GIT PULL] f2fs for 5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586293509;
        bh=pvmHCQ2cmTRceXWYDcPbXLhXd1UfxQq9lm0jyvFB9+c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XmX5OVHgRfs3WrWlcGT6y0yy3Pv+vhkGkBfX4Cb7cw9489YdO1WQ9vvxakEXeivL5
         qmHEvUpYkB+u3XrqatEEp7Tt+NNCypN9hX9wBr6MNRyyzCvOYlQT0wEldM85J+slDV
         lr7i2LXwwrQKyZHSqtbeRqKQ8NYd0PrVCkRbz6TI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200311162735.GA152176@google.com>
References: <20200311162735.GA152176@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200311162735.GA152176@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.6-rc6
X-PR-Tracked-Commit-Id: 2536ac6872e5265b4d9d263122cee02e3d5cae1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6d5789bea5187c2716959f8954a1e00b8a7835d
Message-Id: <158629350986.19531.17911572712226508781.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Apr 2020 21:05:09 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Mar 2020 09:27:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6d5789bea5187c2716959f8954a1e00b8a7835d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
