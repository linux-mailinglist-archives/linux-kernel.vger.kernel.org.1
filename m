Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDD12A20B9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 19:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgKASJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 13:09:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727284AbgKASJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 13:09:01 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes/removals for 5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604254141;
        bh=5At32y1uCVqL9YIsE5rBbhJLPAhyNjdqTjuWtZUy1zs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0KoNmdCP2g336o17ZmyD5ngSGq2bUXDXjwm3zcQLS/e5HJ6WqwpuVknmbYp9PdSzo
         wIKHX8KClARr99K9Umet+g75mCeHcZfldRyfyckoJAh4pRM2KWDKfDJL+tF+NgUkKs
         ijkRd0tyEwGxSYILYG5MVLitlGK0mgyC/9UG1+ys=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201101131153.GA31235@kroah.com>
References: <20201101131153.GA31235@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201101131153.GA31235@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc2
X-PR-Tracked-Commit-Id: d1b35d66f48f926062dc81134ebd8ab93d71e61d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31f020064f9d4da5686f8dda91787f825537ad29
Message-Id: <160425414099.10555.12286180933682496850.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Nov 2020 18:09:00 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Nov 2020 14:11:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31f020064f9d4da5686f8dda91787f825537ad29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
