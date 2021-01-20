Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5987F2FCA1F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbhATEvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:51:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbhATEvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:51:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B88572313B;
        Wed, 20 Jan 2021 04:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611118224;
        bh=dBq7Unjs6BAhv0IIKzod7dAyAlhhRYH0LzzBQ4adwpA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F0ZoW5G+oZlLPnUaFzISNr74HLFRqtIFrLPBtquJ8zog92+9HWMT+EceAoZW30m1i
         lmqOqnmYDk/O8FmHKRTCqxgigff9OJDF9Kk2h+l9Ve/4JwaG/qYJf4XafFhhZugzDs
         DmryBenA0lh2JRiL6AY/W38vI+yyPZhQC+HHE0WqNmtjwawHjKkWIxakwxj/v4l0ik
         YZGEQvrwsuuzCzzBtjMXW3IcPgtFqzxBzVqix+/r4NT8h4ubQv7wkIliRlIAvtK061
         Shg9PuqbX0+PkdPs+mQwC4tfMfHfz7766RPrAJXsV7xGbtnKQ1p7ppfyvWURd2+b/N
         +gJISY370NVeA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id AFBC1604FC;
        Wed, 20 Jan 2021 04:50:24 +0000 (UTC)
Subject: Re: [GIT PULL] task_work fix for 5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87a18f00-8f32-edcc-4595-da70e623febc@kernel.dk>
References: <87a18f00-8f32-edcc-4595-da70e623febc@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a18f00-8f32-edcc-4595-da70e623febc@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/task_work-2021-01-19
X-PR-Tracked-Commit-Id: 35d0b389f3b23439ad15b610d6e43fc72fc75779
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45dfb8a5659ad286c28fa59008271dbc4e5e3f2d
Message-Id: <161111822471.31434.1338047207623878995.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Jan 2021 04:50:24 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 19 Jan 2021 11:15:54 -0700:

> git://git.kernel.dk/linux-block.git tags/task_work-2021-01-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45dfb8a5659ad286c28fa59008271dbc4e5e3f2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
