Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F532F957E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 22:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbhAQV0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 16:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:52564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbhAQV0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 16:26:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9ADB6222B3;
        Sun, 17 Jan 2021 21:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610918764;
        bh=TZpFDACIdthIK1jhIvweoQ73Jh/kEKuSOOiynbz3Jdc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=roVeJSAesz+QtVGru8kyVIVAJZNC1kLdVbU3WUDqTQT9YtXnxUj4cnRW3Qfrvpthq
         k6s0Umeyc+COkGt0pJdlDnzJPmX57JJ2cQeSKNsQRDejArSh5Z/Di+pYofPmzt9g+m
         V8ImnAOcdhmy32t0WL9ZTAnVD8WbEVPaNrCbjg1U3HtedX3R0A5b0QoBHtWriFUxw8
         FB0NvtAh3YclryRgeAjtqEHDHrUERqLN+ULCRpy8eKs8ci21r7NEaNPEiSOfU2Zs0T
         CEpYCfBcCxuPckHal31E6azonzEcJRHEi9r7lnIeHUjS+hf9KkOF8+wjXnq7KV1aNE
         VO94h30AzoyeA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 7EE36600DA;
        Sun, 17 Jan 2021 21:26:04 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210117210908.13730-1-acme@kernel.org>
References: <20210117210908.13730-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210117210908.13730-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2021-01-17
X-PR-Tracked-Commit-Id: 648b054a4647cd62e13ba79f398b8b97a7c82b19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2da783614bb8930aa89753d3c3cd53d5604665d
Message-Id: <161091876444.12990.3306559208604268867.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Jan 2021 21:26:04 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <al.grant@foss.arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Denis Nikitin <denik@chromium.org>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Jan 2021 18:09:08 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2021-01-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2da783614bb8930aa89753d3c3cd53d5604665d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
