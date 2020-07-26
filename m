Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1D22E276
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 22:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgGZUPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 16:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgGZUPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 16:15:02 -0400
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595794502;
        bh=ZmtYLLixjHaFkDHn4/u1RpI2k7yLqaz7EoMJtIM8nRY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hYHpSq+oFWWT4AgYKqMaH2zQo7KyYqsTgBq3y/O0n64aSnxt/miMUbMQdPw3jRDKD
         XaQYlp2IPojggBePxHTAHKWhHBOKQoEpUJE+5RlrcWuBX3uXY6pr5jJIyD04pG1XyG
         Y/xQ/vZceYQ4aZ+J9tU+gjogH6Y4F6gO5jPzz8Dk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200726191404.GA10491@ls3530.fritz.box>
References: <20200726191404.GA10491@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200726191404.GA10491@ls3530.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.8-2
X-PR-Tracked-Commit-Id: be6577af0cef934ccb036445314072e8cb9217b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40c60ac32174f0c0c090cd31d0d1712f2478e689
Message-Id: <159579450195.23540.8523708864715554170.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jul 2020 20:15:01 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jul 2020 21:14:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40c60ac32174f0c0c090cd31d0d1712f2478e689

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
