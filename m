Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FD22F09DA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 22:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbhAJVWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 16:22:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbhAJVV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 16:21:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8470722AAC;
        Sun, 10 Jan 2021 21:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610313677;
        bh=Nno+3pKGQr/ZyEJh/RO8akz3NQ1ZmbQwk9xRF41jSqc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h7zBtu7BToSSxFpFgJmLfFc2cRSbENxbJqeKESM0Ut+roI+DT0W2dI8qYrNNrArrm
         6sJWhSeApdvUiZ+XTQ0oZVpdArhg7wVKdwG5+hCE9tgHYPMQW2fiUXx/wEzHP5n1W+
         l3Kn17TPtgKJJ7umVvN0srLXkIBoAiv0+xQce+q5LDzrH27zK799MXmRNqWKeZhXHp
         DzJ9joYOTAvHXIvML4kG6TNDixZ9npQeZDsok6VnTJduykF1pnPU8KhD2zx94kVM/o
         L1bBLpN9XR5tsNyQHg96nR5A+mE44flZZ1ZVwvil9DOVspgawcbp7h3/qzqGj99hru
         Or7b39OtFNJpw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 7A5B560141;
        Sun, 10 Jan 2021 21:21:17 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X/sK8J7QqiNSPZ1e@kroah.com>
References: <X/sK8J7QqiNSPZ1e@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X/sK8J7QqiNSPZ1e@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.11-rc3
X-PR-Tracked-Commit-Id: a5c7682aaaa10e42928d73de1c9e1e02d2b14c2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28318f53503090fcd8fd27c49445396ea2ace44b
Message-Id: <161031367749.28318.2198119359449543218.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Jan 2021 21:21:17 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Jan 2021 15:10:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28318f53503090fcd8fd27c49445396ea2ace44b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
