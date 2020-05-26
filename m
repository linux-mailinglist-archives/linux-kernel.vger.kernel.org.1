Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3C51AB4DC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 02:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404870AbgDPAp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 20:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404680AbgDPApV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:45:21 -0400
Subject: Re: [GIT PULL] EFI fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586997921;
        bh=vBw4T3xTlplGvbEqBdW8GHYuLCowN5rvdavpmsnvdqY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LlcCrTGq0iK8/fGhERzEbWjkzpWJvZ1q/5ooSiED8xNZO9mkeT9dUsuEJxH/W78E3
         GoruTkxSISDw77JdVgGZpPpVReXC+2v4sPHNdL9hWKQniJhLDWTLxn6qWvjS1++Th2
         jccdfMgWbgYQ5vKfq33ff2lZ2S3Dp4zDpBMlmIB4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200415090327.GA35892@gmail.com>
References: <20200415090327.GA35892@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200415090327.GA35892@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-2020-04-15
X-PR-Tracked-Commit-Id: a088b858f16af85e3db359b6c6aaa92dd3bc0921
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00086336a8d96a04aa960f912287692a258f6cf5
Message-Id: <158699792123.12687.380291890980058766.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Apr 2020 00:45:21 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 Apr 2020 11:03:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2020-04-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00086336a8d96a04aa960f912287692a258f6cf5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
