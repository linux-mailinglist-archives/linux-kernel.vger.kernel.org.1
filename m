Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6CA301E7D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 20:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbhAXThE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 14:37:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbhAXTea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 14:34:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B6AA422D50;
        Sun, 24 Jan 2021 19:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611516829;
        bh=C+y+pezuZ00Ku1JY1auVzje+lmNnVWZFVE/+kO/3Lbs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gy8cnYo449QVCPOZ4eFVpgmP2LdR7sfrHDU14IWIyejR9OjWdy4Jtxk7csLa0o4zz
         AteLOcYsf3vtvSnCs27cgbqn4E9lFR/K7+aIUgOgz3rciUJN7MdyQE8wXwE3mYRPKz
         CczyXsDeffLj0JC6wk7RubwSvfpgLeOifyQg4UcNanY1gJ1VQLfvy2HZ7AmLhYqLOb
         rSbaY22e1iW3PxqHWYOkNZkOUOgJxgEZ1McIM9hDaUTXGM24pxBcYFyphXjWBIA9fj
         tynraL+jZWpAVIpORPft7dIqxf/+EL5NN2PAbWK7KziQaCaBLbtYDR7uA8oALiD+Mc
         FmCXUVgNYWC0Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B2208652F1;
        Sun, 24 Jan 2021 19:33:49 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YA1urjFySDgiW7QE@kroah.com>
References: <YA1urjFySDgiW7QE@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <YA1urjFySDgiW7QE@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.11-rc5
X-PR-Tracked-Commit-Id: ef02684c4e67d8c35ac83083564135bc7b1d3445
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f3bfd2181ecb920e5f51e2a16c1ef65d6f50a5f
Message-Id: <161151682972.23923.7258555399781067077.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 19:33:49 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Jan 2021 13:57:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f3bfd2181ecb920e5f51e2a16c1ef65d6f50a5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
