Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D6419E6E3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Apr 2020 19:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgDDRui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 13:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgDDRuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:50:25 -0400
Subject: Re: [GIT PULL] thread changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586022625;
        bh=6Sp2RW5CMAyCNcVsTHa/ppjJwGkTlFk1A7tHKSmndvQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vM2uWH/CrbCu07X8ANokgw/XC5x5K6VyOAa6AbeeEieBhdWnQrWrHY/BlWtPLTtdC
         +Hzu2CJJ5++z7v76t/nxTHUyT815TgsxvlgxbA4yKA/gdgIcNdgR2VtNULDl0wGJlZ
         RM3i28Sr5VdTWWlbk/FIddwGd/GzmumqAJNJHNUk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200404114357.1359783-1-christian.brauner@ubuntu.com>
References: <20200404114357.1359783-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200404114357.1359783-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/threads-v5.7
X-PR-Tracked-Commit-Id: 6952a4f646446fde9e190b62c5e45f84c6cf91aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e396a5d171d61aa00d49389d92f8afb21568635
Message-Id: <158602262524.31764.16904505521685076936.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Apr 2020 17:50:25 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  4 Apr 2020 13:43:57 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/threads-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e396a5d171d61aa00d49389d92f8afb21568635

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
