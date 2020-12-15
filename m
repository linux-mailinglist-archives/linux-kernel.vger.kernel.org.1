Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CF02DA514
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 01:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgLOAvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 19:51:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbgLOAu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 19:50:29 -0500
Subject: Re: [GIT PULL] time namespace fixes for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607993389;
        bh=Smb9dPua9huyfGFnp3lNVDy1pXsPtDJ+1zAAnkg7T7w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rA5SqTnojB9FQnL6ye5nokG4hBzd+kbo9L3WvcqfQh6ALemMy+UfsLdsprdhbylYj
         EKJftgU42V9lqp4iOwAHBZwdpuSjAyFvrywNJNmAK9OV1ewVBwtX6ZQF5ineRSz9f2
         iuWDNPjnXAKRf54+wvV9Is6j9uO7wx8Rd7g9jMyqYjfyNX24jDEr1Esa74c675ys6y
         POI8UJmhGL9q55tl74KifcvKVNxX+dnwofJ8EljKy/hOy3qvL2OCHhQJ/4htxhZY4L
         /dSrKQrNRdVLtxwX+wIh2bqid0RII9nSi/iF8pNf+Y7mKMhkrYcIS6hFeKNDbZ+QEB
         5GpQKZ3ot9C6A==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214115744.3306832-1-christian.brauner@ubuntu.com>
References: <20201214115744.3306832-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214115744.3306832-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/time-namespace-v5.11
X-PR-Tracked-Commit-Id: 5c62634fc65101d350cbd47722fb76f02693059d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d93a1971a0ded67887eeab8d00a02074490f071
Message-Id: <160799338911.8612.5070165313070369308.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 00:49:49 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 12:57:44 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/time-namespace-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d93a1971a0ded67887eeab8d00a02074490f071

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
