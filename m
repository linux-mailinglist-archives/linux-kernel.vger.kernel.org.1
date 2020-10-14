Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4E428E888
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 23:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbgJNVpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 17:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727356AbgJNVpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 17:45:09 -0400
Subject: Re: [GIT PULL] thread changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602711908;
        bh=PXrJ4bBC/zJxS2E/O713+sfGDGNkOMPEY2rzCqOnPGE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gfWr6ieXIOWpqKK1kotVxFA427ehlJQfbd8Oifw5QvRUIe1jZgQwY52pN2oRTH01e
         u9L2XHjM8FQFWo7WZZA5FUrMetiSkb9sP7MGgdT4ybLTqXpYbEoNBBjDfpgJJI2ZPf
         Tho4+KUIgy/6Upy6d6j32RDMp6QStfm/K5DTCjh8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201014085948.172950-1-christian.brauner@ubuntu.com>
References: <20201014085948.172950-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201014085948.172950-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/threads-v5.10
X-PR-Tracked-Commit-Id: 01361b665a26ef0c087e53f14cf310d1cfe0cf98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4da9af0014b51c8b015ed8c622440ef28912efe6
Message-Id: <160271190890.18491.8242800955458842875.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 21:45:08 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Oct 2020 10:59:48 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/threads-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4da9af0014b51c8b015ed8c622440ef28912efe6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
