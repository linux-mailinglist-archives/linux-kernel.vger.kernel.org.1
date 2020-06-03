Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDCB1ED5F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 20:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFCSPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 14:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgFCSPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:15:07 -0400
Subject: Re: [GIT pull] timers/core for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591208107;
        bh=02pqoZykiifWL1b6oyPMYilD1lartPOVGvhcROhCklE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Fhm7A04Kuqa7gFr9nOJ148fjdVoANW/8k7CD8dOEoSuXnoBvONfDrnVQZ0INrR9pQ
         nDNKRVjkNwxUWjck3bEYe61HjWoe1HPR8hgwb6UTzuWnuF9EV1acclzuXgSz43GJ1M
         N6e+nGnGct49kiZJ8Ayg+tA9PNFPPkc+zjlRCumI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159109969095.14228.4958990874220284812.tglx@nanos.tec.linutronix.de>
References: <159109968973.14228.6780339995273133401.tglx@nanos.tec.linutronix.de>
 <159109969095.14228.4958990874220284812.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159109969095.14228.4958990874220284812.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-core-2020-06-02
X-PR-Tracked-Commit-Id: 809eb4e9bf9d84eb5b703358afd0d564d514f6d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dabc4df27c628866ede130a09121f255ca894d8c
Message-Id: <159120810743.18635.8817489340384282886.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 18:15:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 02 Jun 2020 12:08:10 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dabc4df27c628866ede130a09121f255ca894d8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
