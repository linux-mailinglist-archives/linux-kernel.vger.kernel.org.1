Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEB128E883
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 23:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgJNVpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 17:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgJNVpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 17:45:09 -0400
Subject: Re: [GIT PULL] kernel_clone() for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602711908;
        bh=R3smw9NmTsWDDgCGzmxa8xrR24TUsyYu/U8El/AJW3o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bibazfRSnmZXE7sIJsVHwaWjMfgYW9NnNpwnGfIi2Vn4ClX2ur3pcT2ovy/+o555e
         ybm1vD7jhALGbReYKOXpjLFDTWHm8kgbk0YpPcuP1U25I/7OaYPQ0WvHj6jAUOKExl
         kd/w6f994Jkfp72JiuIQJj/PBmh1xCeRTvM4WoiA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201014084153.170148-1-christian.brauner@ubuntu.com>
References: <20201014084153.170148-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201014084153.170148-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/kernel-clone-v5.9
X-PR-Tracked-Commit-Id: 06fe45634942dc96c316bbb789049a4b0b692542
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 612e7a4c1645f09449355cf08b6fd3de80b4f8cc
Message-Id: <160271190867.18491.9594213894196137956.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 21:45:08 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Oct 2020 10:41:54 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/kernel-clone-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/612e7a4c1645f09449355cf08b6fd3de80b4f8cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
