Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CC728C4CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389686AbgJLWeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388401AbgJLWeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:34:03 -0400
Subject: Re: [GIT PULL] x86/kaslr changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602542043;
        bh=owW28cC18phQdE3mEFU8uGxOCz6BfbXuI3gANWj0M20=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aGSTb1Qwc8RAvtsYmNWnPM3R5T5V7atqrUUFZOfbBsGrIJW35QHpIPI4xX4z/eRvb
         oY6Q96VyeMnBpeOmL1t2lkpfC207sJ+Im3pWoB/w/LMLPnBRTk6rJHKuba1FJtZMnZ
         esOYSyYagS+OI1OULmrIjtZz8+oWx2hmXRc0d6FY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012171158.GA2831196@gmail.com>
References: <20201012171158.GA2831196@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012171158.GA2831196@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kaslr-2020-10-12
X-PR-Tracked-Commit-Id: 76167e5c5457aee8fba3edc5b8554183696fc94d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b85cac574592b843c4be93c83303feeee0c4dc25
Message-Id: <160254204310.4463.13664038105788200806.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 22:34:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 19:11:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kaslr-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b85cac574592b843c4be93c83303feeee0c4dc25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
