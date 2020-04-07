Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A761A1722
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 23:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDGVF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 17:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgDGVF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:05:26 -0400
Subject: Re: [GIT PULL] f2fs-5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586293525;
        bh=zBaVdXuF23Lbox7ppFoyyZrhIO05fnK41HYaosVg2e0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YaWLTCeV/nJSRzDEejEsg9nPQlz3Op4DS8dePlgv2dq7OPqra11xmDl/EV+eFMXtV
         9V71pdVRPu0E6T942r0pTgDa4zwTZcnvuxTZ+6JEk4AA078/osAr4brNJCt/UhATRr
         l/TdXn5BQcMabRdgMHKrOOALayv8HjIt1vHkaAyk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200407030242.GA139449@google.com>
References: <20200407030242.GA139449@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200407030242.GA139449@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.7-rc1
X-PR-Tracked-Commit-Id: 531dfae52e8c386f72fc4935b97486409291fdb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f40f31cadc0ea5dcdd224c8b324add26469c2379
Message-Id: <158629352584.19531.9084064391563587572.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Apr 2020 21:05:25 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>, kernel-team@android.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Apr 2020 20:02:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f40f31cadc0ea5dcdd224c8b324add26469c2379

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
