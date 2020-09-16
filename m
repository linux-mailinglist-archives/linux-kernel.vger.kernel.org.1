Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A2126C9A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgIPTPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgIPTP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:15:29 -0400
Subject: Re: [GIT PULL] perf tools fixes for v5.9: 3rd batch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600283727;
        bh=kH8gJU+NWl3UTr0ZMWe6puphSNLSl4Fg1E8Y7V09QHo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SKmumrfh/lSplvbNcacJUh1K5MRFoyOajjMKL2GcNw1RKuEHjItULA0QYwLpazBAj
         FHF7J7kpBpDbYGb4zhHzYiPfIo+XbI5fJz9p0pOgUc+TnFcEiWTbkMZgKjjHqmShXQ
         2JlRQLeDWAtJutqcX0ugTDUg36AGD/r96rH3Ok+0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200916174433.1328420-1-acme@kernel.org>
References: <20200916174433.1328420-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200916174433.1328420-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.9-2020-09-16
X-PR-Tracked-Commit-Id: ce9c13f31b10560d4e4d801f9f94895f595756aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5925fa68fe8244651b3f78a88c4af99190a88f0d
Message-Id: <160028372723.18192.3648447354528059926.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Sep 2020 19:15:27 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Sharp <dhsharp@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Ian Rogers <irogers@google.com>, Qi Liu <liuqi115@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Sep 2020 14:44:33 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.9-2020-09-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5925fa68fe8244651b3f78a88c4af99190a88f0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
