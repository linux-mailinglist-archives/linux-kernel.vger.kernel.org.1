Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A78A25373B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 20:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgHZSeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 14:34:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgHZSeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:34:17 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598466856;
        bh=pFCKkYkRl6Q7QCAzdDuMZrVZN8ZTnPedKYVWXpg2RWo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SjdxneVz7QVsMPZZG4ZoxUqkv/JzFJXe6tFPgx5i+KPtl+Bm2kJ1rdJzEyd3Y2dgh
         OFh0Fpwu/vddoBD/3z4qOy7Vx7Ejm/8EapVqqW68U5XQKJVVvXkqBf19jC9H5EK1CO
         o9A74o2QgxPyS1NvsffJmbqTMsYBdsbctLW8DvkI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200826134211.GA3881983@kroah.com>
References: <20200826134211.GA3881983@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200826134211.GA3881983@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.9-rc3
X-PR-Tracked-Commit-Id: 9c97cecab0d49e40460d9b5230ab4bf036f59491
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27563ab6ef75abc64b7da2c7a321b7edd89dfcf7
Message-Id: <159846685683.8056.6162061380278635629.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Aug 2020 18:34:16 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Aug 2020 15:42:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27563ab6ef75abc64b7da2c7a321b7edd89dfcf7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
