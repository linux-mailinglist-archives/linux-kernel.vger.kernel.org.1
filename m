Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853E02A5870
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbgKCVvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:51:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbgKCVvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:51:12 -0500
Subject: Re: [GIT PULL] perf tools changes for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604440271;
        bh=byth35o/wDC1q1AJlM0t7cJuiLDUWAfo8aBXJwH2RCo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jGP6tlFkoyyRZ9YOKjw3bsvNlMWRE+u6jim3MUoDtALE+ltAb/mzS7QLRqyRLi+3s
         kTIgamFjGHQlHTG67f427nBUxy6T0p+SFjeK9nHwbOGP98NgUYLiscwJ5GxivRqnRB
         lI49nnKK0Nh/gC1wqk1YtHP4qKZGTp0KTMYY/M1I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201103194441.197821-1-acme@kernel.org>
References: <20201103194441.197821-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201103194441.197821-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.10-2020-11-03
X-PR-Tracked-Commit-Id: 5d020cbd86204e51da05628623a6f9729d4b04c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ef8451b332662d004df269d4cdeb7d9f31419b5
Message-Id: <160444027158.10573.9293757010281158003.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Nov 2020 21:51:11 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Ivanichkin <sivanichkin@yandex-team.ru>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  3 Nov 2020 16:44:41 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.10-2020-11-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ef8451b332662d004df269d4cdeb7d9f31419b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
