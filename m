Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D609F28E924
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 01:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbgJNXXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 19:23:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387423AbgJNXXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 19:23:18 -0400
Subject: Re: [GIT PULL] TTY/Serial driver patches for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602717798;
        bh=A8GTFdQpKwXpre/RoI3yXxMRtFOvBs8ZvnfrwYMcESQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zmOc6q/HKNrKzDHQ5AyXI+OtvHhYqs5bKZiXHKBwBrSuMIC4MzqCaPv/T9oItEfpJ
         QtvxJU+VyO87FBeFC3+JkQepWIQhJLHytWMufzgbxcgEiqyfHWnddyvPnPq16pUj1R
         sgVyNMpIs41vA3tn/jRi17wdYE3giHo6GHeoGB9A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201014174826.GA3786470@kroah.com>
References: <20201014174826.GA3786470@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201014174826.GA3786470@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc1
X-PR-Tracked-Commit-Id: 4be87603b6dc9e49c2e07151bb51180dc0b6964a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d6c413c92a3e6fc9399141891147d0d826517c9
Message-Id: <160271779841.1444.5958432421590613483.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 23:23:18 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Oct 2020 19:48:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d6c413c92a3e6fc9399141891147d0d826517c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
