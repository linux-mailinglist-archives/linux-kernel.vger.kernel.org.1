Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658D125CF4F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 04:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgIDCNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 22:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:32926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbgIDCNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 22:13:08 -0400
Subject: Re: [GIT PULL] perf tools fixes for v5.9: 2nd batch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599185587;
        bh=AA5jBHID0VQimazyUL3taus+z53HQ4kfEtvt0SfesEE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q+zAK/ppWvVL3ic+wrE10Yz6npEhJWWAOw98DXWFJVVKWav+polONw7GfCr3uDLsr
         i4HbE8GVYSL2k8WWQmdtWVpdnYWqe71DOFYvSoHe7hhFYNxbd9ZvC0Juh/OocFX6uY
         3P3s6WubD00f2FFkjnUtxFYSuV06eYUCGSBGr5M0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200904020728.3734002-1-acme@kernel.org>
References: <20200904020728.3734002-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200904020728.3734002-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.9-2020-09-03
X-PR-Tracked-Commit-Id: 830fadfd954c6782b7a8a2461c76a568c7153b9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59126901f200f5fc907153468b03c64e0081b6e6
Message-Id: <159918558786.15567.14911656149995703564.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 02:13:07 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  3 Sep 2020 23:07:28 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.9-2020-09-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59126901f200f5fc907153468b03c64e0081b6e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
