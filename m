Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A6E300F98
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbhAVWFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:05:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730607AbhAVWBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:01:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9578923B17;
        Fri, 22 Jan 2021 22:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611352839;
        bh=9kwNm4P10i9O3BIphHH/GNZHPJGH0UcwvlCZF5aeO7M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yxyp5Pf3uH/j1W8339zyquj02XsnUnCE+xZ9xE5KRm2hkawy5dslVta/zoqU1F6OU
         BAzO7dx0Wxu8E2qyX/If/sHikpokj/u9Q3qFu8aEGBbtDfmudlwc8hrawiAKvZ7PwR
         0jkSaUwOzAWCbodI9FQSBoXVUtDsGa6sydOxqsbC1QUGjcPYpzkDAyVmXFl5/GrFyl
         BjNpL73xKGMXi2QjbeNGAcPO8QzX/S2ra8XNK3o/bDGHYdx31EBLXjlAJxqWE05DOV
         8gn4fohByPVrwY9m9pAN/L2JdkUmFsx2Hs9thEGyaaDz0U1UOwcNH1pF39qr/iclfL
         /v+5pgob5ESlg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9014C652D0;
        Fri, 22 Jan 2021 22:00:39 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.11, 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210122135156.608434-1-acme@kernel.org>
References: <20210122135156.608434-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210122135156.608434-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-v5.11-2-2021-01-22
X-PR-Tracked-Commit-Id: 8adc0a06d68a2e433b960377e515e7a6b19b429f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: faba877b3bccb5af79f0cd8c6af93392030e6e41
Message-Id: <161135283958.4174.10836254569905042796.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jan 2021 22:00:39 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Jan 2021 10:51:56 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-v5.11-2-2021-01-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/faba877b3bccb5af79f0cd8c6af93392030e6e41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
