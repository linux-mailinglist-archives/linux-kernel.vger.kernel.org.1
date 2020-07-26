Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AABD22E1D5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 20:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGZSFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 14:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgGZSFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:05:06 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.8-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595786706;
        bh=dMRQz/BWwFXUnL6mAiTvc49kLnmiugN9+Hedt0gZris=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cTxdGJpzdBj9k9mjEqCofb2qKW7QWkGoCE/WD9uRaZ2gi8G7hONyS6dN9KEGguWL6
         krTOfL2j9EER35rjj5rg11E04hNfvmqMBoBMKYaJFNN09lDW692dEv54FsQlq3rpnl
         7XEQl4XhOQIE7sEwfSYJYrcDxGOebmJciJd8w3jU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200726111410.GA1283983@kroah.com>
References: <20200726111410.GA1283983@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200726111410.GA1283983@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.8-rc7
X-PR-Tracked-Commit-Id: 92d232d176041db5b033dd7b7f7f2cf343f82237
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ada9010e578150984039a770c98f41799b30bc4
Message-Id: <159578670634.6689.17505451847877366960.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jul 2020 18:05:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jul 2020 13:14:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ada9010e578150984039a770c98f41799b30bc4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
