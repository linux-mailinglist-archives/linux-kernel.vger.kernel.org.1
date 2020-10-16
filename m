Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE415290C78
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411193AbgJPTyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:54:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411171AbgJPTyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:54:39 -0400
Subject: Re: [GIT PULL] kgdb changes for v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602878079;
        bh=qYWLwn9V2XisClCdGsDsWUTFbjQcOYbV62nbihXw39A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eYMk3ZRddveBt2yX3AZUh2CpRz7VCo2h/ngpI2jlqBNV2SGtPsHkO6Yw6fUl9c4mF
         +lQuC5CAI08251WFR9BU9mun0WfYqBn8Lj+tAqUpEj22eiSxsFwtPasBFY/+6IU3L/
         cNMJhSP/jNwXbByUOkVAMivNGAqlUuydeLk0vvio=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201016130742.tkdahmll3qipf4wo@holly.lan>
References: <20201016130742.tkdahmll3qipf4wo@holly.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201016130742.tkdahmll3qipf4wo@holly.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.10-rc1
X-PR-Tracked-Commit-Id: d081a6e353168f15e63eb9e9334757f20343319f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49dc6fbce33011733601e4e81c551e066f1682fc
Message-Id: <160287807902.14002.17288206193836523961.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Oct 2020 19:54:39 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>, Cengiz Can <cengiz@kernel.wtf>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Oct 2020 14:07:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49dc6fbce33011733601e4e81c551e066f1682fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
