Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F381B92C6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 20:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgDZSZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 14:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgDZSZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:25:16 -0400
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587925516;
        bh=eEJsBl8MzyjMo9IFqxWtu6Dz5EiPFRx76TAO8Yh2VBc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HBoA4mW5s4KKg1BPbyxQKqlwRrdnjb7R+bzuaPDU5kQobSGlAc7BcBPKBwNobdL1B
         A89xLbkfZej9pEiUqcJoHBm+yrDWmGX8l53csPJAlrBGVHF/n1Lc1g+wvgG/gc5P3C
         +7auITuxAhzmmnNX5PQIacnAGDHNOAuqEvnGvPKA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200426104842.GA2121011@kroah.com>
References: <20200426104842.GA2121011@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200426104842.GA2121011@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc3
X-PR-Tracked-Commit-Id: 9a9fc42b86c06120744555fea43fdcabe297c656
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5f33785719596047b0bb9df98d39fab9d1c51da
Message-Id: <158792551598.16875.6467921451635160771.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Apr 2020 18:25:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Apr 2020 12:48:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5f33785719596047b0bb9df98d39fab9d1c51da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
