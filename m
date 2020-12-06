Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82712D0700
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 20:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgLFTxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 14:53:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbgLFTxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 14:53:22 -0500
Subject: Re: [GIT PULL] USB driver fixes for 5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607284362;
        bh=c1wQs0ZHGLAdFs7aPyKMs1P7BVv28pppnPmp75fbIPY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XpL/NcR40sq8MaFZwzK2indT5wPSEMNDUi9efR+Bs3DcxoMmEP/ZoQ+7+RtbgI48j
         nPriIQro4DOnKh/uhruGeFOAagfe24XuoSoCLnikokKpRk5uDKsblzQHOQXN5IqeFW
         llzYP/tIn41YdtG0BtR0A4yHoW1GwIAz26kM43FrTCBBeFI8OZt7aQtSjiY52zgFBe
         i+1yPltj3TvOD/7aKJbdAlGp5hfMDcy0YsGE9wBnbMzoOC365ZQULpuU46lIE6VoHP
         uOhDGzT/0jZhInOQ4eGX8m09SWqknO/Jzcq+hn6ZL+cSve6L23TiVzNHMBthTEnkdU
         9uI7+a/kjxbZA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X8zsMIpNKLSkS6ya@kroah.com>
References: <X8zsMIpNKLSkS6ya@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X8zsMIpNKLSkS6ya@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc7
X-PR-Tracked-Commit-Id: a4b98a7512f18534ce33a7e98e49115af59ffa00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5226f1d20c4113922dbe7742c416f06700c1ea9
Message-Id: <160728436219.18476.17954925267120277756.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Dec 2020 19:52:42 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Dec 2020 15:35:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5226f1d20c4113922dbe7742c416f06700c1ea9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
