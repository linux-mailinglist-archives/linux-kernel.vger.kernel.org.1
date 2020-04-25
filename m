Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF7E1B88F3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 21:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgDYTaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 15:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgDYTaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:30:16 -0400
Subject: Re: [GIT PULL] objtool fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587843016;
        bh=/mYIjZ89W5YXi1INz8d7QCwa3gj/WdEdZxwb0Sj+M9U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tXBjpqXUfjMoRCj7cve2FXgB03XqYLKPIliesn6VnlCj+d42MrDvFCiSoz0hC4Vpv
         jV8qh7sOmfdKxggvlHyTXlVj+N7URnaAOq59751b3uiSiBCxdMkAKFNBi4jx45xtws
         jtKg19dGl4uK8gYPTRM1pv1CPpE1wY9YsytJz+Xo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200425090440.GA108057@gmail.com>
References: <20200425090440.GA108057@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200425090440.GA108057@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 objtool-urgent-2020-04-25
X-PR-Tracked-Commit-Id: 7f9b34f36cf6b2099f19e679a9e8315c955ef2ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b3e59e3deccef70afece5e6484a324cbc126bcd
Message-Id: <158784301664.5802.373355487004183751.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Apr 2020 19:30:16 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Apr 2020 11:04:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2020-04-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b3e59e3deccef70afece5e6484a324cbc126bcd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
