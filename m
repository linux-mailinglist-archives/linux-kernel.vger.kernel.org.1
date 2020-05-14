Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E291D3B83
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 21:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgENTCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 15:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729284AbgENSzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:55:04 -0400
Subject: Re: [GIT PULL] tracing: A few more fixes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482503;
        bh=aN++8TC07okVHtMl0gCHqmTcU3+8Apqm947/cyWFeDQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BbN0JfT433w7lFR9txrhDbKSzvIM1kZuSFv/w2sCo9ai0H/poXUYtytqL1SsJTdtv
         D/jAK4UVmipUCvjpqKGdK3prdtgYMmCT61gGH9reUGG/OnxNyBMAUV7DHIXCpPctih
         m8VkV5lKLA7UhwlMPS57L/rSwS3wpP9wKxUyXmd8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200514103544.3dfb803d@gandalf.local.home>
References: <20200514103544.3dfb803d@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200514103544.3dfb803d@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.7-rc5
X-PR-Tracked-Commit-Id: da4d401a6b8fda7414033f81982f64ade02c0e27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f44d5c489051c2127189abb25d3d1625d9564c2d
Message-Id: <158948250372.25823.13014228019242344728.pr-tracker-bot@kernel.org>
Date:   Thu, 14 May 2020 18:55:03 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 May 2020 10:35:44 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f44d5c489051c2127189abb25d3d1625d9564c2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
