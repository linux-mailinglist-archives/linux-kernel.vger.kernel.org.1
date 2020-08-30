Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C08257008
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 21:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgH3TPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 15:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbgH3TPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:15:22 -0400
Subject: Re: [GIT PULL] USB fixes for 5.9-rc3 - take 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598814922;
        bh=KyZLMnOgAtut6dERRvxdzmUWPKzuwGYpyubNqZwnyfE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TAoiSYiSKcdCBn2ti9+A/CG7Y+ujCtK3xHeqyvC69unS4HVAO9/hwOVZ5iL0urjRN
         1lmLshMCqDRR9MPmYiglix6kK5E78+uqV5UbPYYXFd/jCxxtzRfZi6MwC9ou9MvzGB
         rey7g6/GRh5qGNXq4MfoSmBBhzHDKbbCzkbxdzk8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200830100156.GA129097@kroah.com>
References: <20200830100156.GA129097@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200830100156.GA129097@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc3
X-PR-Tracked-Commit-Id: 20934c0de13b49a072fb1e0ca79fe0fe0e40eae5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f0306d1bfbc4d3e3fcfb949ee2c4af21071920a
Message-Id: <159881492243.11937.12394656114937153114.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Aug 2020 19:15:22 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Aug 2020 12:01:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f0306d1bfbc4d3e3fcfb949ee2c4af21071920a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
