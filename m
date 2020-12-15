Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6B92DB67A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 23:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgLOWXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 17:23:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729842AbgLOWWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:22:34 -0500
Subject: Re: [GIT PULL] Staging/IIO driver changes for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608070938;
        bh=VMzxmOcaJtcJJWUe9Tf2Tcj2pV41CIhNNNe+rRXhbiY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mVwPrLuLmB5Z0W8HIGYsa/CUyco/1IF4D7Niwl0PdL+F3pMISCvnF1+I0a8PzEpng
         W6mzC85n8yY146AI7zWDafdqT2ryzvWV4A7eZ0c9Eq1Dib3Xey90noFGqMaPdhwYES
         tGPn3w7sEEEdTAQebnTyvbB9hgJxtSJTYdlKy2C2Ndp4eG5YplVVUASgBZPvvSBZyK
         ze7ZMI9akCvYOJTh7XdI9viWs0j8k9On6vLqKh/3+jw1Ub70pfNYHMyChTuPTGCU6j
         C1YbnTA+8k0a+d5RpOwhdGWop2DSJuibGmTY80EgJIuLsZqjwqcHnWDaBei721k0yy
         3hC/F0sSqobpw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X9iNTajXvwiLa1bV@kroah.com>
References: <X9iNTajXvwiLa1bV@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X9iNTajXvwiLa1bV@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.11-rc1
X-PR-Tracked-Commit-Id: 4996b4610767064807d022dd731584f7ff78c309
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3db1a3fa98808aa90f95ec3e0fa2fc7abf28f5c9
Message-Id: <160807093876.3012.2067442470065183086.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 22:22:18 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 11:17:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3db1a3fa98808aa90f95ec3e0fa2fc7abf28f5c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
