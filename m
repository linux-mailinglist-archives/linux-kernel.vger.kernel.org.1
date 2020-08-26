Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB725373C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 20:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHZSe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 14:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbgHZSeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:34:17 -0400
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598466857;
        bh=nblUIzJcIcS3BMOezZkRUak/FzxeAggb8FWBH0Mhmwk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z7u/sjm1BWrueYz5vSOR4+1rBIsONJo5XtDpDqlFZQM6BRRB8qfck9g7CQt3iUJBr
         HTPATEuIvBBgeyBwZAd4jjSGPjoQ4XkwUuerNw/zFPGjUzo0au4M4M63DiFJnr/pnu
         yLfsEsbEWxtZbBl8lT6KzO5p2ghimGhjY3Z0r1Uc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200826134257.GA3882407@kroah.com>
References: <20200826134257.GA3882407@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200826134257.GA3882407@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.9-rc3
X-PR-Tracked-Commit-Id: ea1fc02e12b647d8dd7515d1dba137847d8e951d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15bc20c6af4ceee97a1f90b43c0e386643c071b4
Message-Id: <159846685722.8056.5881686741048472172.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Aug 2020 18:34:17 +0000
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

The pull request you sent on Wed, 26 Aug 2020 15:42:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15bc20c6af4ceee97a1f90b43c0e386643c071b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
