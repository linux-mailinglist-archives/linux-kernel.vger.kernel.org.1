Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23319DFC9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 22:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgDCUuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 16:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgDCUuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:50:21 -0400
Subject: Re: [GIT PULL] workqueue changes for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585947020;
        bh=pRuAgwTsIkGEwy8h1/lQGcj1leblHUjyKN6mkoBMm8Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iBq5u+6QWs+4xpLS9C+zL/fHe4iEl2OYMTAl5+TWr7wLkiRwHG/0ovPD7qk6tj/2I
         HTAREGNeVVH31oawx2LRoUok0dH1h++tB7RUB6+e+RBSTxbJD0dfIt+ZhnNt5mLmx4
         51mZEIjKllWNj2E89fTgfE3WaJP2Ymox/LybpPE8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200403155504.GG162390@mtj.duckdns.org>
References: <20200403155504.GG162390@mtj.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200403155504.GG162390@mtj.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
 for-5.7
X-PR-Tracked-Commit-Id: 00d5d15b0641f4ae463253eba06c836d56c2ce42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0adb8bc0391f1fa7820529c0200fb0c4912fe365
Message-Id: <158594702062.4594.15086244935083690308.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 20:50:20 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Apr 2020 11:55:04 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0adb8bc0391f1fa7820529c0200fb0c4912fe365

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
