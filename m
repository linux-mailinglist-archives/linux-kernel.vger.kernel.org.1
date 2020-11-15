Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5962B37C7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 19:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgKOS2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 13:28:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgKOS2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 13:28:16 -0500
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605464896;
        bh=+lFKXHtNA1E63qVm5fdZwh84xK8SyKm6f/so8qGjWng=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=t2Zenn5C+rt9QJWcQW/0ccpuAjfjagDyd/mCQpjlPr+7Jow5oOrQEuzgfrOMyoF4Q
         HYEuVvl5Wu9vbDz3gejuRbmNIFUdwI5/1E81dxnWn8RNf9rVNKvMY1EGl+4gdK1Df1
         E9EKK9ObMIESsFil1fouxDA+Lqym+jnYu5TBFILg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X7E7cMDVfEMb2oSt@kroah.com>
References: <X7E7cMDVfEMb2oSt@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X7E7cMDVfEMb2oSt@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc4
X-PR-Tracked-Commit-Id: 092561f06702dd4fdd7fb74dd3a838f1818529b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cfd9c45994b409c7103efc2f265e0af7634cf75
Message-Id: <160546489646.13295.2686218307257702970.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Nov 2020 18:28:16 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Nov 2020 15:30:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cfd9c45994b409c7103efc2f265e0af7634cf75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
