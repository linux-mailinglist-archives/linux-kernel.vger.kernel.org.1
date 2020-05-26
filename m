Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8941A4B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 22:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgDJUkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 16:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgDJUk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:40:29 -0400
Subject: Re: [GIT PULL] proc fix for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586551229;
        bh=twCwJltR5dC8Zy1O8k4LKcxNoAWkVSwzCKPlWHuR3wY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Wwh9pH4Cq2UxfqLpY/VEogIEeLHmSZzzDT2GPaD20ASBEgQMaiVJP66Fo7lTK+gQh
         xHhok+FS/4jCES+lfIxH+qZGGEb2ESzHcz9VbIEpoO1997EV0aUtVb5X4zp30QUj4z
         ebzOQVL1hsGQMAj1pVCTGiBr0BMcgjXjGi+Oq3XE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sghbmr1z.fsf@x220.int.ebiederm.org>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <87sghbmr1z.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sghbmr1z.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 for-linus
X-PR-Tracked-Commit-Id: 63f818f46af9f8b3f17b9695501e8d08959feb60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87ad46e601340394cd75c1c79b19ca906f82c543
Message-Id: <158655122978.24997.12380057645522983565.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Apr 2020 20:40:29 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Apr 2020 08:03:04 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87ad46e601340394cd75c1c79b19ca906f82c543

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
