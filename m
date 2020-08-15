Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F9F2453C8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 00:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgHOWFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 18:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729957AbgHOWFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:05:31 -0400
Subject: Re: [GIT PULL v2] MFD for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597504994;
        bh=B6GCUuwQxUTDBWGpaFhUiruU7s8AwzGkT4vLM+ajV4M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pg4nFFcuA2l5J9hd0CXSWbUMm+qeDpZTsof/NHVeZg7xVo9/X8bzvb/UJucBA0S18
         XMWk7llvIm7hawz8ZXnyR0W0RRetkehYkryK7lNcj972F7K9Atq6cqzdhUCylrZ6vZ
         BFt/mqG2B+5Hhdv2tBMmqAjlSQ2PcNj2atVMxYps=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200814144206.GL4354@dell>
References: <20200811074637.GG4411@dell>
 <CAHk-=wgF6Ld0-E0Ych_s=jyS4ssaabK08QR4NOzfRrde0LVHfg@mail.gmail.com>
 <20200813071949.GG4354@dell> <20200814144206.GL4354@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200814144206.GL4354@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.9-1
X-PR-Tracked-Commit-Id: e15d7f2b81d2e7d93115d46fa931b366c1cdebc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 884e0d3dd59dde1c1f0fbb5b9db2bcdc581982c7
Message-Id: <159750499452.10263.6996425077964993477.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Aug 2020 15:23:14 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Aug 2020 15:42:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.9-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/884e0d3dd59dde1c1f0fbb5b9db2bcdc581982c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
