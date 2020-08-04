Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E845F23C1E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 00:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgHDWZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 18:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgHDWZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 18:25:09 -0400
Subject: Re: [GIT PULL] fork cleanup for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596579908;
        bh=HVOfTaAAaP4khfjFIW/G923P4veoC+AsRn2xYlWf/XI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kDI9xMZvT613cAcTo/eRaGv2B4m87Jt31ifPeql2//yQlJx4F9/rogIIi3Yw8mIKQ
         0bnPY9krUFJapjhtssj1gDwkHphryTpYSe39wahFxKw/KxSZv7o72WUh3FwOqXFryb
         WSk5zyRgbnda5Ge/UMAE+YBbKxFahxr8Uiip+uQQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200804112801.72380-1-christian.brauner@ubuntu.com>
References: <20200804112801.72380-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200804112801.72380-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fork-v5.9
X-PR-Tracked-Commit-Id: 714acdbd1c94e7e3ab90f6b6938f1ccb27b662f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ba27414f2ec2bfb019d9e9170fd2308aebab63a
Message-Id: <159657990877.8406.3937933315805621282.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 22:25:08 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  4 Aug 2020 13:28:01 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fork-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ba27414f2ec2bfb019d9e9170fd2308aebab63a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
