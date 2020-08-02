Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944862354AA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 02:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgHBAAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 20:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHBAAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 20:00:04 -0400
Subject: Re: [GIT PULL] Fourth batch of perf tooling fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596326404;
        bh=7K6jS9xjmDRqMhEw7JOuVX/JnfJe7FxXBMu467koF1I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pfdkSo7Jxu3Wd6a0fte0rqk4Qh42c1JLQs1qoM1sM8vB4BPuJ961vNq980wWwFnoy
         Mq4L4Pf41gfwYDFbmAKNcqjsK0kabBlIob1WSvEhJjEUV6C7cmSap2Q3fiWeXOklKC
         oZXKUmpJ3/DvyHbo+ICJufoAjmfwBillvqyvKLoY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200801190618.3311731-1-acme@kernel.org>
References: <20200801190618.3311731-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200801190618.3311731-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
 tags/perf-tools-fixes-2020-08-01
X-PR-Tracked-Commit-Id: 39efdd94e314336f4acbac4c07e0f37bdc3bef71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf121a0bda29daa67a1fcedbdf479f6b03c9f977
Message-Id: <159632640437.16599.15587396153041720392.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Aug 2020 00:00:04 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Philippe Duplessis-Guindon <pduplessis@efficios.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  1 Aug 2020 16:06:18 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2020-08-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf121a0bda29daa67a1fcedbdf479f6b03c9f977

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
