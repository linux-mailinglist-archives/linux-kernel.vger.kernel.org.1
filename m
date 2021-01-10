Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B352F09D8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 22:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbhAJVV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 16:21:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbhAJVV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 16:21:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 52E9422B47;
        Sun, 10 Jan 2021 21:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610313677;
        bh=Yynw92XGOHGqFxGA4U01QNO6kixrjgz/VdEoOkWjkM4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vHe4m8lKYyVE/tdPBW8kycKBJaq+mKlN95O6D03R4xoQmSbp4mnfm7kcCDH8YC2xi
         BR+hQSjZQ19AjTbCPnu9UNDf0jGx8tjWRLEaeUwtcCtEWeurmLQ9aZMFgFXNm7lMUO
         h3G7MW40rqX7qqiNxYmEdDFA5tsucL6tKDaHgvoEpPd+DJa/Pc6jIJ7OUUbhKZu8CR
         kdyA875XSapkWG+qnYI+qkZJ9wzaigdBCL3hQnJUBJbp/JMtwnN03J9R5jZt0OBcgm
         4gfb+/hVHaqtJLWkci9xdyGnkp+XtDLP8vnQDxz9ovUL3kPzIlfL1q0KCEVZiLaAIi
         beUaVagUi1+2g==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 3BE3A60140;
        Sun, 10 Jan 2021 21:21:17 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X/sKmuNK82RLz8jR@kroah.com>
References: <X/sKmuNK82RLz8jR@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X/sKmuNK82RLz8jR@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.11-rc3
X-PR-Tracked-Commit-Id: 384b77fd48fd683a82760bc88bef8611cba997fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e07cd2f3e7e525fa8df334d11beceb4c1bdcc74e
Message-Id: <161031367717.28318.7131920247359252347.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Jan 2021 21:21:17 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Jan 2021 15:09:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e07cd2f3e7e525fa8df334d11beceb4c1bdcc74e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
