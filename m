Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0954028C3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbgJLVZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732142AbgJLVZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:25:07 -0400
Subject: Re: [GIT PULL] performance events updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602537907;
        bh=jzj2nCTpEjcN5E3dn88o8icoC87IWE7cYHeHikpF4hk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pVtE3ecFL/YZoUgQfPSt0hBD2lyGAYYE31Z5yxChvos+OcFX+l18AN3Oa3MWFkYS6
         HEpqDpxRpPcRABcz8cFHeGa5iG0VTaW/qlLkZLZr40P1YHmzFE3g9o0pCHOw1ru03N
         CftuRiDuSoKbNkRpXl6fL3VtnfH1JXklGNIJbzVo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012161049.GA3624146@gmail.com>
References: <20201012161049.GA3624146@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012161049.GA3624146@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2020-10-12
X-PR-Tracked-Commit-Id: f91072ed1b7283b13ca57fcfbece5a3b92726143
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bff6112c80cecb76af5fe485506f96e8adb6122
Message-Id: <160253790737.926.12176237518039826507.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 21:25:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 18:10:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bff6112c80cecb76af5fe485506f96e8adb6122

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
