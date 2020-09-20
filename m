Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DAA27167D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgITSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgITSAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:00:24 -0400
Subject: Re: [GIT PULL] USB/Thunderbolt fixes for 5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600624824;
        bh=MuVizFa5vBj966NZnDj6fItvi+uTReX86p8xhkmkpf4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k2+PYoY1S2DHwUYCLdtY5At6H2L6CkgdRafzou4c4MuYmrmOL02j5zOTAbkJL6SHf
         YPWYcpz0UBxdlbgCqEXlWMCIo4e5hNcsAS1j55MwSnxJGh2o8/Pgp5nGxdyZPdqp35
         eHEXnrMZ/Q6/zIoA/ka7j//mP1YshaS6JBj4lmgk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200920132830.GA2845084@kroah.com>
References: <20200920132830.GA2845084@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200920132830.GA2845084@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc6
X-PR-Tracked-Commit-Id: 9cdabcb3ef8c24ca3a456e4db7b012befb688e73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0373c1463ef0cdbf05176eed2fc8f554dc2bd73
Message-Id: <160062482399.2021.4317238746631418497.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Sep 2020 18:00:23 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Sep 2020 15:28:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0373c1463ef0cdbf05176eed2fc8f554dc2bd73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
