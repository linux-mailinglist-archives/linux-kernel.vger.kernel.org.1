Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60372C7440
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbgK1WPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 17:15:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbgK1WPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 17:15:44 -0500
Subject: Re: [GIT PULL] perf tools fixes for v5.10: 4th batch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606601704;
        bh=Iu3Gz+9ibTHVllcRCCZ+Ot4Tzcs3nSVbmicYhZj1sYg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZmKD8qGwI7atg5C+SivPxuVnyY4DZssxI6W7rOGspIH0TOTMwNFqB5xuCkhSPnDUK
         wFU7zDzPXYeQgK8Eocs1VHfVL5CU/S4WT12PcfxdZF2uMYb8mzkU1AMdqGeFdElLVJ
         tIAq41XRCF6KKSZoKsb/oTww1HOs/lq+reQ9x+NE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201128153005.21172-1-acme@kernel.org>
References: <20201128153005.21172-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201128153005.21172-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.10-2020-11-28
X-PR-Tracked-Commit-Id: a9ffd0484eb4426e6befd07e7be6c01108716302
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca579827c9a7ec1b6fbfd2f8b157acaf138be838
Message-Id: <160660170411.2772.13335334859704327171.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Nov 2020 22:15:04 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hulk Robot <hulkci@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sam Xi <xyzsam@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Nov 2020 12:30:05 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.10-2020-11-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca579827c9a7ec1b6fbfd2f8b157acaf138be838

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
