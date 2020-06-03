Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31EC1ED7C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 23:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgFCVFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 17:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgFCVFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:05:10 -0400
Subject: Re: [git pull] [regression fix] uaccess.csum ia64 braino
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591218310;
        bh=15cqdsv0ky6exUtAlQeJcsJuYuDTMgJ0GKWehS0ZhBc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N7dGIOFruQ+Oh9PCdrQe551guzHnA2vOxqz9/J3WPJGvmmPkHryCuYfiGPN5DDja5
         NYVjEVX7wPcGJOvHkiYI20puNzNX2lWP03W9SFcjzOYxeN09g13NUzrGr1oWYrAaqV
         n51ckwNkWyCAquwHBnfO963T8cwQwTCWF5ZbBSf4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200603202027.GB23230@ZenIV.linux.org.uk>
References: <20200603202027.GB23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200603202027.GB23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.csum
X-PR-Tracked-Commit-Id: 174e1ea8a2f6140078b6c61068b478cf3c4aa74f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8f4abf8fd1a2beb94983cb95ed713df75b3d135
Message-Id: <159121831015.19900.1695872052700900679.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 21:05:10 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Jun 2020 21:20:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.csum

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8f4abf8fd1a2beb94983cb95ed713df75b3d135

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
