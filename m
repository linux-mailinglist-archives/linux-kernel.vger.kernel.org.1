Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E908E1EE980
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 19:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgFDRfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 13:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730083AbgFDRfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:35:08 -0400
Subject: Re: [GIT PULL] perf tooling changes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591292108;
        bh=4J9+H+4CW5IhNrU/4E0wdwSjqUsm2tSHmRUZ1XC93q4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Iq4cCAzOf5ytL9OWBikFH++upZRX1ig6SdJCDA9NoGoXrfF0O3DTPV7/S3tZbHybm
         hxpz02zRoenHg1DTa9+ha0uQpqGHqbT9T2W3AnXZVZZ4zlCw2t0dq5BYdrr0IEPED7
         pxB2gw72sq7u7ftd8z/l3Ly4J8dlwvcwKmDaacT4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200602182423.2451-1-acme@kernel.org>
References: <20200602182423.2451-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200602182423.2451-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
 perf-tools-2020-06-02
X-PR-Tracked-Commit-Id: 3e9b26dc2268cfbeef85bee095f883264c18425c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38b3a5aaf2fd35e997550b855cfb7460b077236a
Message-Id: <159129210795.22790.14622941457346390218.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 17:35:07 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Anand K Mistry <amistry@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Changbin Du <changbin.du@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Li Bin <huawei.libin@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Gasson <nick.gasson@arm.com>, Paul Clarke <pc@us.ibm.com>,
        Paul Khuong <pvk@pvk.ca>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Travis Downs <travis.downs@gmail.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Yuxuan Shui <yshuiv7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  2 Jun 2020 15:24:23 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-tools-2020-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38b3a5aaf2fd35e997550b855cfb7460b077236a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
