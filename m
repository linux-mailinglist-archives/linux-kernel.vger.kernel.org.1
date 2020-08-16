Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04715245564
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 03:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgHPBzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 21:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729777AbgHPBzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 21:55:38 -0400
Subject: Re: [GIT PULL] arch/sh updates for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597542938;
        bh=oVOhF3dDqTPihVsVHgODEzdAK7FV916nU53hKcm0dfs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MysnHEXLENdVZ+0V3I7Qak/crMfj1uEPIuTAXYrfSFW6VhM1hg71LY95AS1rKy3tZ
         ZSb5dCZ9JqpuP2oyGyM833d/ajDYp2qGf1ipUToaq+XV6zS+1+o2RKQU4CQc5Lzqii
         ZYy0HEKjDPM+22V/5t2grsHgU5TonzTbOQsrgsfw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200815193255.GA23393@brightrain.aerifal.cx>
References: <20200815193255.GA23393@brightrain.aerifal.cx>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200815193255.GA23393@brightrain.aerifal.cx>
X-PR-Tracked-Remote: git://git.libc.org/linux-sh tags/sh-for-5.9
X-PR-Tracked-Commit-Id: 0c64a0dce51faa9c706fdf1f957d6f19878f4b81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bbec3cfe376ed0014d9456a9be11d5ed75d587b
Message-Id: <159754293825.18953.10322498780181033938.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Aug 2020 01:55:38 +0000
To:     Rich Felker <dalias@libc.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Aug 2020 15:33:04 -0400:

> git://git.libc.org/linux-sh tags/sh-for-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bbec3cfe376ed0014d9456a9be11d5ed75d587b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
