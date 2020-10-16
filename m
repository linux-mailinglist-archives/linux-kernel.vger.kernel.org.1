Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05E9290D9E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390524AbgJPWOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390059AbgJPWOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:14:33 -0400
Subject: Re: [GIT PULL] tracing: Fix of mismatch section
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602886473;
        bh=RLd88td1CvCfpE7JO1uI4AIkHU6e0yBTtsuRGK7FOjU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Jlt3YwMwtuKT7GBf5ipEdPxNQE3at33JUEGnB6kzlCy7lHXRNEUBhQnvLtAK3qxq9
         6+FVMBtW8+CjLdjgy+UJMwYT/BJWNdHTl3wWiOoUfCiI4T0YyBReMqtGY1fQUK5Dm+
         zimeJ9C4OdLqmoyz9LJjGh2+nZHEmcrmZ3SRIblw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201016162242.16434e2b@oasis.local.home>
References: <20201016162242.16434e2b@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201016162242.16434e2b@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.10-2
X-PR-Tracked-Commit-Id: ce66f6136460a51acfc32de4481fe8fd69dfd50b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93f3d8f54a22eaa5ae4ec269615729c4f9b1cf1e
Message-Id: <160288647304.19132.6119458499088406726.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Oct 2020 22:14:33 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Oct 2020 16:22:42 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93f3d8f54a22eaa5ae4ec269615729c4f9b1cf1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
