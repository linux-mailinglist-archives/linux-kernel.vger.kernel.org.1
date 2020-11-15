Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122942B37C5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 19:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgKOS2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 13:28:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgKOS2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 13:28:12 -0500
Subject: Re: [GIT PULL] USB/Thunderbolt driver fixes for 5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605464891;
        bh=mhoc+9o/qXZTiDwAULK+3n3O2vaqAgSblUBYg8rSzLg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TCcjjKCGi/Xvglvc+HehiKjaF+Z9To645kTkEci5y61pyr5cjq0LVh8XRZ421c67n
         KK+Db1xyCGYsy/8kXM8Bpylxkkd/F2/52YvqfO8gLp8Q5u8KhQWIx0TobG/JjkYx75
         F07yHqRnfvDV/xT5HQmO86b3l+yLskXkaIdCFMFk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X7E7UiresGDdG1P1@kroah.com>
References: <X7E7UiresGDdG1P1@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <X7E7UiresGDdG1P1@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc4
X-PR-Tracked-Commit-Id: 6d853c9e4104b4fc8d55dc9cd3b99712aa347174
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 281b3ec3a75bfa14b2bf53501c4596415b3309e2
Message-Id: <160546489147.13295.8277202600102848330.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Nov 2020 18:28:11 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Nov 2020 15:29:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/281b3ec3a75bfa14b2bf53501c4596415b3309e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
