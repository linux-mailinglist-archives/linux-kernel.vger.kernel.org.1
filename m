Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2445C28FB74
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 01:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgJOXIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 19:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732508AbgJOXIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 19:08:36 -0400
Subject: Re: [GIT PULL] tracing: Updates for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602803315;
        bh=rkjtMyhkY9hCjTlX/al28VHnYuhLNMYVjuzXnPgUJ1w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NWpnWvE55x1Tpqd1OwCatxeDtUE4MaGpfNsfPedqqaCLM1+AUexZqd5ZqSVIZr5Da
         CmvfgjI33kb6F4UGaEjQd+Inwk5jiEPPIj7TOrhw7PkTpcZdcXlG8mWfqO72mvBkni
         cWs8VcisP0h1yggQGetQeyhMLTZBzi9g3T7VnU/M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201015135345.6b29e8c0@gandalf.local.home>
References: <20201015135345.6b29e8c0@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201015135345.6b29e8c0@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.10
X-PR-Tracked-Commit-Id: 6107742d15832011cd0396d821f3225b52551f1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fefa636d815975b34afc45f50852a2810fb23ba9
Message-Id: <160280331568.7173.12412024522883437119.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 23:08:35 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 13:53:45 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fefa636d815975b34afc45f50852a2810fb23ba9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
