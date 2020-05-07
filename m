Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EB01C9ED8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 01:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgEGXAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 19:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgEGXAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:00:05 -0400
Subject: Re: [GIT PULL] tracing: Fixes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588892405;
        bh=ZdjUl/8vOVqBj74i9PqvOXCF671anVwcGLh8JVQaRhU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dmOVZlKkEaUtFEGuIIxpKQMVeVrjB/9P+5oHVvjl3ycUFiigg/kqNe1Mre5KfD33O
         mvIv4bCy94KFI+tg0yfFruMB45a8kmYcPVAlbl6dI8UheWVwv41oPLxk0OoOso43rU
         I9c3yEEWE0545fXOPsuwfKI6y26jGIBIuG9dI1KQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200507143353.3f92a389@gandalf.local.home>
References: <20200507143353.3f92a389@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200507143353.3f92a389@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.7-rc3
X-PR-Tracked-Commit-Id: 8842604446d1f005abcbf8c63c12eabdb5695094
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 192ffb7515839b1cc8457e0a8c1e09783de019d3
Message-Id: <158889240519.3631.764704828333907477.pr-tracker-bot@kernel.org>
Date:   Thu, 07 May 2020 23:00:05 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 May 2020 14:33:53 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/192ffb7515839b1cc8457e0a8c1e09783de019d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
