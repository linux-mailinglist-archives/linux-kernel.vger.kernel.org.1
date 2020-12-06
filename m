Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903DC2D06E9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 20:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgLFTb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 14:31:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgLFTbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 14:31:25 -0500
Subject: Re: [GIT pull] locking/urgent for v5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607283044;
        bh=yofZRJWK9hU4ptasclXIFYgIcrzxhkoHXDI5oJvAzf4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k3pXlu5J03W5xJMdbJqgHRekUAumioy0AP0hKoU9JH6YMK94FjlzQFaMQ39455yc9
         8VxBTkgIOLdA+RZqdd4anDRrQ9WaIIoUXxaxsrknpkYJr5hRFFtaSLs5zEL2H9XAP6
         v8NfSPk7jm3j+NY7cRBWjO/rrrPPYGhU4jrTTaCUsJShnW1N31EjA8TcP+KZdNhIxS
         0ZNyNkC6Tuj6sUVvaYOw1AtXXNQ7xxQ18uLKkqBmgkgHxaAphtUOnV72Wmh9iqc10e
         aT3TXCGnWLF8Z4cvgbNYnxtYQybC/IMFs8++ZTYCIdhi2gepG5Zp4jahVJ2myC8UQo
         6ZsyIj20jt7xg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160726029935.10836.17254923642337108244.tglx@nanos>
References: <160726029814.10836.11636935433736940390.tglx@nanos> <160726029935.10836.17254923642337108244.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160726029935.10836.17254923642337108244.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-12-06
X-PR-Tracked-Commit-Id: 4d916140bf28ff027997144ea1bb4299e1536f87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff615c98035729776a74f9c86c3b137ae35ac1d3
Message-Id: <160728304465.10233.15399106055976664284.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Dec 2020 19:30:44 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 06 Dec 2020 13:11:39 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-12-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff615c98035729776a74f9c86c3b137ae35ac1d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
