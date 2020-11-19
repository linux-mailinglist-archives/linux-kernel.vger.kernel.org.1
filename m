Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E675D2B9B81
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgKST34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:29:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgKST3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:29:55 -0500
Subject: Re: [PULL 0/3] xtensa fixes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605814195;
        bh=iobAXnkeXh+UgguXC9Py2yERWUonIJG8kNqgW9Q+/28=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hkXWvsij2GQVEA7AUJyQitdN6mSfyecfH5OOxvxjXtmTi9A8fMGYfTcRJ3Qjf+xYd
         BLZpGjry0VqHf7Jh32493NbbpBJmXD1QEQxb7wYSU4z8BgA698hnlGxJZPHaZP4Ksy
         THkhl9hKWgOYRce6f17zSCWXqiWZgiOh64d8dS08=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201119113734.25047-1-jcmvbkbc@gmail.com>
References: <20201119113734.25047-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201119113734.25047-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20201119
X-PR-Tracked-Commit-Id: dc293f2106903ab9c24e9cea18c276e32c394c33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3494d58865ad4a47611dbb427b214cc5227fa5eb
Message-Id: <160581419521.21513.1753113580636504538.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Nov 2020 19:29:55 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Nov 2020 03:37:34 -0800:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20201119

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3494d58865ad4a47611dbb427b214cc5227fa5eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
