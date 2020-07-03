Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE652133E7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 08:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgGCGKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 02:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgGCGKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:10:07 -0400
Subject: Re: [GIT PULL] fixes for v5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593756607;
        bh=3YlYHtxM3qkNY9FwkyrdW1rsyUXreaO5S9Q0mIe6fFg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VOhrOxgSVHBkM+npdmPNt2dYUrfvo0f7bf9Scla/a99B7XvIv1gtYudmiTwHwWkNB
         yRe//ZmSVAHtZS/fIqAo5H8nsRanDiLDjWmjxgUkppzuszXuQu3XgelXvaaX1+HTfT
         nucdW0C1vF1MpRkmnAXVhcoF6QbzaHRWjy48EaeA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200702204732.1114343-1-christian.brauner@ubuntu.com>
References: <20200702204732.1114343-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200702204732.1114343-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-2020-07-02
X-PR-Tracked-Commit-Id: c17d1a3a8ee4dac7539d5c976b45d9300f6f10bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45564bcd57046ebe8c9309527c114dcd042cb7e5
Message-Id: <159375660756.4799.3325007475348681785.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jul 2020 06:10:07 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  2 Jul 2020 22:47:33 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-07-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45564bcd57046ebe8c9309527c114dcd042cb7e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
