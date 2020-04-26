Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352F61B92C5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 20:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgDZSZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 14:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgDZSZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:25:15 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587925515;
        bh=6RVDzEs46ID4NZZikQ+pq01YQgzzRzUBB1G8Hgr5Vuk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zLJfKjWySzKY6BRST4WIzwNEIvu6eKizUFiMALI4KS9kxh4UNFQFBA/LzIOjhPdR1
         Jig0KfYxMVcOKeoWvxeHzzd3AWGuBsEVGvLFWhQNaeqv4ymAbtTmKe1ykOFN134XqJ
         T+e/YpYqTDvH55g1DauB6hC2vdyRNX9vmVyWhoqY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200426104758.GA2120856@kroah.com>
References: <20200426104758.GA2120856@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200426104758.GA2120856@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.7-rc3
X-PR-Tracked-Commit-Id: 9c0c54a8daf465e6e6454ffe6fc999e81a22dbf9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6da8bd15202685ed809f1a6d24a0a060ee0954d
Message-Id: <158792551566.16875.2203863115883148773.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Apr 2020 18:25:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Apr 2020 12:47:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6da8bd15202685ed809f1a6d24a0a060ee0954d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
