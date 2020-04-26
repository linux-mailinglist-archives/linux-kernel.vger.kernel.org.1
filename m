Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57F41B92B3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 20:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgDZSPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 14:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgDZSPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:15:17 -0400
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587924917;
        bh=nr/SB17M8cOdhz+v536BOjsBYVkobQUHIHfXrEsBrHw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0UQy1+N39PJDxPYuYMIXIOzcDmWbRqi1NRjSEF1qBtYpHPmkzJ8mSmAriV/RXePzg
         MJXiVcyARCSJwnf8NM2sziTo1z61KIrbCj0vXVRYr+N2/CIGGEYc8uENezTEKhyKmK
         4DaCvOORJeDsF1WPmskZPh9xrtkvS5yNkAEIKwH4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200426104655.GA2120547@kroah.com>
References: <20200426104655.GA2120547@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200426104655.GA2120547@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.7-rc3
X-PR-Tracked-Commit-Id: 5a3577039cbe0bbb8e7a12d2790e23039b8a8618
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8a0e2a96b7dcf7065f97db915e2deb92bf56634
Message-Id: <158792491744.6795.5841395883633894039.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Apr 2020 18:15:17 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Apr 2020 12:46:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8a0e2a96b7dcf7065f97db915e2deb92bf56634

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
