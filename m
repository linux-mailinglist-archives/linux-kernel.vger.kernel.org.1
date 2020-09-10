Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F33826513D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 22:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgIJUtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 16:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgIJUtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:49:25 -0400
Subject: Re: [f2fs-dev] [GIT PULL] small bug fixes for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599770965;
        bh=sh4tYz2XGeutw14hUnEZiKhsUeX5DqUcMULH8ctetks=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JY7fUognR2ZFz9rVvYpGYJNeWvf1+MwdG+ehsq1b7I1hAJ3E+SrW6btfy+jf+jEqx
         t8kzceY5y+vW0LGsVFhax/rRhwqM1oxDbx7e/uzW1Bdd/T9gYX/W7f02VPuVQK2i3Y
         VwZTEQXL/UFxYs7XdDo+zcyDnMDQCSFKyTuFcbac=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200910140241.GA487602@google.com>
References: <20200910140241.GA487602@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <20200910140241.GA487602@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.9-rc5
X-PR-Tracked-Commit-Id: 20d0a107fb35f37578b919f62bd474d6d358d579
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 581cb3a26baf846ee9636214afaa5333919875b1
Message-Id: <159977096501.3136.1605508877327581662.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Sep 2020 20:49:25 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Sep 2020 07:02:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/581cb3a26baf846ee9636214afaa5333919875b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
