Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF14A28D39E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 20:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgJMSYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 14:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgJMSYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:24:07 -0400
Subject: Re: [GIT PULL] regulator updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602613446;
        bh=ouRuQY/DhxftgEO+KB2nE2Tz5fMx9tU12Fcm+1v5MNQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G5wU/CFIJ3h4vJXiEYw8g0V/U3+6m7mGdugASZ008mXsAuyVaIzc9P+Be+3G171r1
         s2L63zpQsfhXRFZbyxHKIwU/3RR41POW+Zx273HxmJtaixvN6C+biTgsjuLftz1loH
         hzMWxjMsVwDuRqknw63D71lSbB5UaUzt3tZ6Ex2Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012130923.6CE282076C@mail.kernel.org>
References: <20201012130923.6CE282076C@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012130923.6CE282076C@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.10
X-PR-Tracked-Commit-Id: c6e70a6fd5ceff381059e600156d78c1b94b7c60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1724e02e024adf5a17da12fad6819e30d304da7d
Message-Id: <160261344658.11865.6365522852366321438.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 18:24:06 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 14:09:08 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1724e02e024adf5a17da12fad6819e30d304da7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
