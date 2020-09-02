Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0ED25A321
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 04:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIBCpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 22:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgIBCpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:45:21 -0400
Subject: Re: [GIT PULL] perf tools fixes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599014721;
        bh=5SaoNQyBaWmhwg893HCYqQAM/mdr9/N/GIIv6v/gqaY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZO0GMjwmNshbsY57t/PtucesBxtSpbpu01rsqRglxZA611GW402xSKvEwETtEvXeX
         vafNuyuZ1hvB/2WQe7+HF5kbUXl3liqyY1EX5NJDtROJ/Zhi5Gw3S4ddbx+6s6HGp2
         p+ILYmjoV1rMq3WJIXgxneUwGLBnWQ3Et3W+IV5Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200901224154.3436175-1-acme@kernel.org>
References: <20200901224154.3436175-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200901224154.3436175-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.9-2020-09-01
X-PR-Tracked-Commit-Id: 977f739b7126bf98b5202e243f60cbc0a1ec2c3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c7d619be5a002ea29c172df5e3c1227c22cbb41
Message-Id: <159901472136.4624.16783161865001951925.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Sep 2020 02:45:21 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <al.grant@arm.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Ahern <dsahern@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Like Xu <like.xu@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  1 Sep 2020 19:41:54 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.9-2020-09-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c7d619be5a002ea29c172df5e3c1227c22cbb41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
