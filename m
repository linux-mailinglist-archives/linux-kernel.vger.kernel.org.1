Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981F8274642
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIVQMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgIVQMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:12:20 -0400
Subject: Re: [GIT PULL] tracing: Fixes for 5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600791139;
        bh=dKMjzY9dZMJfpuSh5M/DdxkjHHweXIXLDDh1+4B/uYc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yEodJx8PozIg6uPSMmSNO1io0ggy12jEq6Z2yHxJle6fus7ePj31uulyiTJ09jgWL
         EgfJG9OU/2ksbk5EGW9vjJX0GX6MOcZzAbYfwE7G9iGYAGndlv4h8rsalLTq/EcnhK
         D0QdgFXh0caaDIm3vhDU5DALi96zyKiLna3Kvixk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200921205058.3eaf308c@rorschach.local.home>
References: <20200921205058.3eaf308c@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200921205058.3eaf308c@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.9-rc5
X-PR-Tracked-Commit-Id: a27026e95b57acbb8df7182e020b099e7f3b5ac3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eff48ddeab782e35e58ccc8853f7386bbae9dec4
Message-Id: <160079113983.21801.9344769283414997845.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Sep 2020 16:12:19 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Sep 2020 20:50:58 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eff48ddeab782e35e58ccc8853f7386bbae9dec4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
