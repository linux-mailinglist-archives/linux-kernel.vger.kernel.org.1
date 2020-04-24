Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A321B8125
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 22:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDXUuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 16:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgDXUuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:50:18 -0400
Subject: Re: [GIT PULL] tracing: A few fixes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587761418;
        bh=HbNKcDi6v5A/gxvtQSTrLnnCxO7K/nkCEpQAvnA7nwE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OFZJ0iNT9IsYuwA3SL3gcbwsgBbOd95R0WYcLP/wRIbuBRKbgkYaWjJrYubaD2h4T
         YKh933g2fnQBnfmC9evhv9J2y4VQx4KH5e6wyIn486m0JV8PDRmrU+t5CpNKJXLfh5
         tGoXiwa80ZL7R8k+b4kMmnvGv8c7CYoGAT3AuInI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200423193109.26721533@oasis.local.home>
References: <20200423193109.26721533@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200423193109.26721533@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.7-rc2
X-PR-Tracked-Commit-Id: d013496f99c5608e0f80afd67acb1ba93c4144ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da5de55d1747a2ac1739005b1d81183a8c557639
Message-Id: <158776141815.11860.2870542095435332354.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Apr 2020 20:50:18 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Apr 2020 19:31:09 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da5de55d1747a2ac1739005b1d81183a8c557639

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
