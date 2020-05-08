Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280271CB46C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgEHQPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 12:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgEHQPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:15:05 -0400
Subject: Re: [GIT PULL] USB driver fixes for 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588954505;
        bh=Y9tcAAdWfL8gvCesCTdtnaTDOP1FBSNgszQcEKo+2Zs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XsHOPyMFa60vqt5Rd2TlvNZGBYx4tdycLekP3t35rMgu6PG+OldQuuj+xNmmwJncu
         gohFL05i/84rza1eSkujAVOHvH+PpUzZnF3TJdPndAjdETnsT8uoULlWLkJxRupTXN
         9lVymYRSz454BkWFnVJhcB0bBtfdpVHOBK7RPpl4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200508141718.GA324234@kroah.com>
References: <20200508141718.GA324234@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200508141718.GA324234@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.7-rc5
X-PR-Tracked-Commit-Id: 91edf63d5022bd0464788ffb4acc3d5febbaf81d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a0b96b2e27d75c74e254abf8efe17628aa427ad
Message-Id: <158895450503.20886.4380026790674395783.pr-tracker-bot@kernel.org>
Date:   Fri, 08 May 2020 16:15:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 May 2020 16:17:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a0b96b2e27d75c74e254abf8efe17628aa427ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
