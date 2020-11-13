Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA32B22FF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgKMRtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgKMRtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:49:07 -0500
Subject: Re: [GIT PULL] bootconfig: Extend the magic check range to the
 preceding 3 bytes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605289746;
        bh=KDZL7fZ79Hq08mBlqlctRvT7KKEGJQy1f5HnIGKwKO0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oiKnOu+dP9DSQQ9ZqlEVKfWnIBOD0d4e5jO/aq633vEetc/VExuDH9XMoeLBlm0Vb
         ffinAxvkD4nE64aSe0JEenYHOa/1WFbOGVGIIdgx4wH/ClMwzvy0Kz3FXnB36fP34z
         4B9Hiu1QTkSYnQVSD7VzWpZmU6aNLu7CHsRqzE7Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201113082930.27da4612@oasis.local.home>
References: <20201113082930.27da4612@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201113082930.27da4612@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.10-rc3
X-PR-Tracked-Commit-Id: 50b8a742850fce7293bed45753152c425f7e931b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6186313d06dfadbfd0cda5e36e485877d6600179
Message-Id: <160528974682.4613.14707428417393182332.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Nov 2020 17:49:06 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chen Yu <yu.chen.surf@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Nov 2020 08:29:30 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6186313d06dfadbfd0cda5e36e485877d6600179

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
