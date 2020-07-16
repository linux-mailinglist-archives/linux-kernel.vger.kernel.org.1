Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66792222B77
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 21:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgGPTFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 15:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbgGPTFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:05:04 -0400
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594926304;
        bh=Ui8MvdHcSMIVI9Y+GYo/n8FZ3RdCwTYMUWA1bu+K1cc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2fEvhZ//b2ZLtdSJMhca7GoaeVk+LS3ZAzqyB6E0s2QRUakm50W6x3R+1cbgPkTGy
         FATCBSL8Z9IufKyQIqzwojAsPNumPZj91upwCi3mCfc/cG1BABbzTGfxkVX3/ZPSxt
         eoCpWg4Iv+rlgiYFB67L7ouKzYuMGAdnYW5mKQmQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200716152939.GA2378914@kroah.com>
References: <20200716152939.GA2378914@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200716152939.GA2378914@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tags/staging-5.8-rc6
X-PR-Tracked-Commit-Id: ef75e14a6c935eec82abac07ab68e388514e39bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a058f0be518bbb10aadd3c5d18516f91b1a4a04
Message-Id: <159492630464.21154.1782207197856638176.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Jul 2020 19:05:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Jul 2020 17:29:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a058f0be518bbb10aadd3c5d18516f91b1a4a04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
