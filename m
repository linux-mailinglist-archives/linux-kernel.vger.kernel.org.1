Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129BE2A20B8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 19:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgKASJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 13:09:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbgKASI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 13:08:59 -0500
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604254139;
        bh=VdeRuhj90482BTttclCdIHtmbORwLLNHZZ7+uUn78N0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z5PZscRdCLtjJHNGMmp5FVkkQedcINYJzAdm1lIopmKzU2/i2RN3U5SCNaHdz/C8D
         Xv8+YxS1/ZUrAsaDH7vHemmnTj/cjcDa95G/IozEffIUgfv1Cflm4Xd9lkgV7El9Sy
         vWwsyDO8nYEhWWLv+WrUnUHqmpDn77k22obk3ahI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201101130854.GA4114977@kroah.com>
References: <20201101130854.GA4114977@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201101130854.GA4114977@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc2
X-PR-Tracked-Commit-Id: d54654790302ccaa72589380dce060d376ef8716
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2754a42e0dccc8db89426901bb54ca6c34969c01
Message-Id: <160425413943.10555.255026369400231422.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Nov 2020 18:08:59 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Nov 2020 14:08:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2754a42e0dccc8db89426901bb54ca6c34969c01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
