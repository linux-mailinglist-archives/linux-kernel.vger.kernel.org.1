Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D033E245353
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 00:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgHOWAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 18:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbgHOWA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:00:28 -0400
Subject: Re: [GIT PULL] perf tool changes for v5.9: 2nd batch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597515739;
        bh=vEljPOThfSbnJn88gHs4Smd9TmldHaunZhuNavYVFW4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Vze+ZvfKm0DVLiQx6F9jCuGC4zZ42/3sh6vUSprrhTTNyiAv1Jc1QBk9w4mQI+AuA
         yC/ELqfDzeJAecrZG57q2hgPetCH3noKhRHpDHuiq9TomeZvRWLZ7rnvUTivfGyF3D
         2Hn02yE1OIpS65IiaU0THazwa0GUMzHgPRMEoPMM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200814174917.2591425-1-acme@kernel.org>
References: <20200814174917.2591425-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200814174917.2591425-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-2020-08-14
X-PR-Tracked-Commit-Id: 492e4edba6e2fc0620a69266d33f29c4a1f9ac1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 713eee84720e6525bc5b65954c5087604a15f5e8
Message-Id: <159751573947.22808.8285651134325842958.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Aug 2020 18:22:19 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Changbin Du <changbin.du@gmail.com>,
        Colin King <colin.king@canonical.com>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        David Ahern <dsahern@kernel.org>,
        "Frank Ch . Eigler" <fche@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Paul Clarke <pc@us.ibm.com>, Peng Fan <fanpeng@loongson.cn>,
        Rob Herring <robh@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Aug 2020 14:49:17 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-2020-08-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/713eee84720e6525bc5b65954c5087604a15f5e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
