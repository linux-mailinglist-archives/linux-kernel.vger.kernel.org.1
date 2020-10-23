Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA6297757
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755153AbgJWSxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755127AbgJWSxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:53:19 -0400
Subject: Re: [GIT PULL] Arch/task_work cleanup
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603479198;
        bh=qECofJMfGcX4SDwiAQpEV/jFZD3GLi6bmMK7cR1ckew=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bxQRCwzmlQwrtAQrbcNUqUG5CfEIxhiYzYK80aet4wgsZTAaPlSblVsUu37KtFbgK
         fbmAdEFxNWHZJMPJ6kGhPSgSYLHhWwOZxPup0vHyVgXaKkSJMs2LKqdIdxzefCKaa6
         9BrKmyE7Ubco0DVSz0U4FJblNiDlGaaTFh+2anpY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e1e0acc8-1859-bd37-80ab-612a122a334f@kernel.dk>
References: <e1e0acc8-1859-bd37-80ab-612a122a334f@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e1e0acc8-1859-bd37-80ab-612a122a334f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/arch-cleanup-2020-10-22
X-PR-Tracked-Commit-Id: 91989c707884ecc7cd537281ab1a4b8fb7219da3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a22709e21c2b1bedf90f68c823daf65d8e6b491
Message-Id: <160347919857.2166.5691055216702055123.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Oct 2020 18:53:18 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Oct 2020 20:04:48 -0600:

> git://git.kernel.dk/linux-block.git tags/arch-cleanup-2020-10-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a22709e21c2b1bedf90f68c823daf65d8e6b491

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
