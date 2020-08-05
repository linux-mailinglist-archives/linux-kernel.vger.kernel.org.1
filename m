Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F2923D028
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 21:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHETap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 15:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgHETa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:30:27 -0400
Subject: Re: [GIT PULL] Char/Misc driver patches for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596655822;
        bh=5M+gIJ19P44QYs1U1XmTj6x/vB8UeMrW40QQKXTx5Sc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MjPe0Azd0PxoY3kChPDCfsRjTV1dUUTmTUj+CuysvOJukhu8VjJI6z/b826IxSib7
         E4d0HmxgpxMROKzEko46bJ1QmApV935Lwdf9xoNnxwh7zaAGkRsGWnFkKUl9IhfoPq
         y0kVHX1y5r2GE/6AV9wkvrNoXvRPywJBz6Lm44EE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200804173711.GA513530@kroah.com>
References: <20200804173711.GA513530@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200804173711.GA513530@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.9-rc1
X-PR-Tracked-Commit-Id: 22362aa30bad6f03b5bcbbeee3cdc61950d40086
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1785d116124fc33f2c265243f3f59da3dc2a2576
Message-Id: <159665582289.8842.575082694115488573.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 19:30:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Aug 2020 19:37:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1785d116124fc33f2c265243f3f59da3dc2a2576

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
