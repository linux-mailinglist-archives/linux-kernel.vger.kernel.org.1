Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C35291425
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 21:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439438AbgJQTgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 15:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439393AbgJQTgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 15:36:41 -0400
Subject: Re: [GIT PULL] perf tools changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602963400;
        bh=0yLURO9Drp3e3aW02u/SjK9VxZpeDDJDvTEjqF+d8PA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zNcDgayNbzCg4c20ifGAgNyb6eU+Ou+TBAP3qgNgkr9Je0YJPKO8iOdfKI7q/brnS
         mEgeblXlED4lQhbRjHgwz6hpSOCYlQfG2PcDUcxMuXEHF55+seOzZ3wuR40g4T9A63
         K2WQokUDmkjGDGect3q7jND5Jkc3uagkhuFZxZJk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201015202640.2165631-1-acme@kernel.org>
References: <20201015202640.2165631-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201015202640.2165631-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.10-2020-10-15
X-PR-Tracked-Commit-Id: 744aec4df2c5b4d12af26a57d8858af2f59ef3d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d9af1007bc08971953ae915d88dc9bb21344b53
Message-Id: <160296340082.20436.11067255084314882940.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Oct 2020 19:36:40 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Changbin Du <changbin.du@gmail.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Remi Bernon <rbernon@codeweavers.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Wei Li <liwei391@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zejiang Tang <tangzejiang@loongson.cn>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 17:26:40 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.10-2020-10-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d9af1007bc08971953ae915d88dc9bb21344b53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
