Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B322DB678
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 23:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgLOWWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 17:22:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729912AbgLOWWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:22:34 -0500
Subject: Re: [GIT PULL] Driver core changes for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608070939;
        bh=oraKA7VC7PH0JAbWvVoMqoKIRBGsXW7CJQtpcF6oHbs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DT9g7v0Rjz5+hqRl/rGdQxPHzmZ3RuUeyypnuHFtsSqrqaXnqyf+pC3x5tcfz/f/g
         rtcI5ZV+AatG6xllVEvr2/jzNRfs3fQ2zouWlOV225G7Kprj3tXxuULAndjOkTTvrg
         sjUYelIbOGDN/f0zX3xSJvMNxhEeEvq5D4sawSKAGkfYAs8hQtawAW1vL8FAV7LmR1
         rwbgCVdKVboIK5/4BEqBgyoMOhrG3b2Q1d+BBubePncecnogXoq1bZX75dbjakN4Lk
         bq6twvBfoterBh633wES93sM2NgIcfFgRQo3PLXQSjYZQ4qKheCEykteFJvemvfD77
         DZXO1MO0KUPTw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X9iN6g0YmMt5pQ+F@kroah.com>
References: <X9iN6g0YmMt5pQ+F@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X9iN6g0YmMt5pQ+F@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.11-rc1
X-PR-Tracked-Commit-Id: 46e85af0cc53f35584e00bb5db7db6893d0e16e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7240153a9bdb77217b99b76fd73105bce12770be
Message-Id: <160807093904.3012.6492164764372032834.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 22:22:19 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 11:20:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7240153a9bdb77217b99b76fd73105bce12770be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
