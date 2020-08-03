Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CEB23AFFA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 00:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgHCWKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 18:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbgHCWKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:10:05 -0400
Subject: Re: [GIT PULL] locking changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596492605;
        bh=kw++V67pKvlOeKIaTTcBk5TcTq0CDUCM5FxLCN9bmYE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kKnMfnyIEVDTs1e7z+O7kJK8572w653FA4I7RHZ9cNtFWTAo1ro8+3h1f1/GTp6LJ
         mAUZ2hD7fS/xEXjmOoj0mK+zTHdZ/rUM+HTOzMYzQJusGVj6EKLa42JZjArzfIgwr2
         ixzg0p8mmnJKxSjOek5uU+ULfli6mjbnK7t6JPi0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803115416.GA506583@gmail.com>
References: <20200803115416.GA506583@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803115416.GA506583@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-core-2020-08-03
X-PR-Tracked-Commit-Id: 992414a18cd4de05fa3f8ff7e1c29af758bdee1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ba19ccd2d283a79dd29e8130819c59beca80f62
Message-Id: <159649260551.26696.10611045426011868498.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 22:10:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 13:54:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ba19ccd2d283a79dd29e8130819c59beca80f62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
