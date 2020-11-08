Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1402AAD40
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 20:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgKHTii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 14:38:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgKHTih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 14:38:37 -0500
Subject: Re: [GIT PULL] USB driver fixes for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604864317;
        bh=iIIZEpyZAiehGm2+ngit6ULmOl2jV5Pu16Xc1WhRGl0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UejgtQZQZB53k//2tPjY3oiH6whOScyroyk2LM0Vgqt/MLahmzXZZvyexbqtf2tih
         0YWJHkcaE5dNnGdp22vaUcXUm1EL6cNuqaMVjEHdmw+O8lN3DsXS/DuK3Veffge0XE
         rHiLWUzFdZrcKJu9XlwOPxj7Icj7JFKgEuIssBBc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201108184549.GA66721@kroah.com>
References: <20201108184549.GA66721@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201108184549.GA66721@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc3
X-PR-Tracked-Commit-Id: db388a6cb7ed986077d3a275712bfc2e28082760
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df53b815c799cab8c6e04816b5005810a57ea6a3
Message-Id: <160486431738.12026.12207099632642568486.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Nov 2020 19:38:37 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 Nov 2020 19:45:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df53b815c799cab8c6e04816b5005810a57ea6a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
