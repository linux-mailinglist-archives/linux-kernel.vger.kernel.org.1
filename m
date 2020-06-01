Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7631EB151
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 23:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgFAVzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 17:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbgFAVzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:14 -0400
Subject: Re: [GIT PULL] x86/platform updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048513;
        bh=MNfSQYkjP7Di5EJYjsrvZI8Hp+0dwfqDmkUWYIe3jm4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dF2aiiOGCdiQDXkeeu7hmUnCus2HwifEQGukCXLqQYdza1E7fjowr0h0n0BtziF+T
         npOlV5r/47XwM8B3wjaWxJ0cYtNA2rnAulCvAm5OI2Eidk6BAMO3If1dmTQ18lT2aP
         3m7dIkyBq9YwAGdr0Ropgq6Ef6e655I8etdnrFF8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601170500.GA1392237@gmail.com>
References: <20200601170500.GA1392237@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601170500.GA1392237@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-platform-2020-06-01
X-PR-Tracked-Commit-Id: 33649bf4494c1feaf1956a84895fcc0621aafd90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88bc1de11cf5b5fa14dbeff7c613ce62fdfae7f6
Message-Id: <159104851371.21074.1770085638139458881.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:13 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 19:05:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88bc1de11cf5b5fa14dbeff7c613ce62fdfae7f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
