Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D2423AFF9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 00:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgHCWKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 18:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbgHCWKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:10:06 -0400
Subject: Re: [GIT PULL] objtool changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596492606;
        bh=TLnLG9HmcPLzl3JqJN85w25AnzNRNsD3wzvofF4bEUU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gmakMPZmIN6yedB3PnAfO5FllDimbP1L8qQ79/L2FSlWkforfBACxaKmcmuhELbCT
         X+gaH53a7gv7/Xm8+EdiRzLYEcwwi9bmzHGhgLorQ2/0Eky9OBlQBRy94/5dOkEamU
         HChDInMMaP17briafl+IA9rFLCmPUVFSomQCdMeQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803120602.GA506993@gmail.com>
References: <20200803120602.GA506993@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803120602.GA506993@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 objtool-core-2020-08-03
X-PR-Tracked-Commit-Id: d832c0051f4e9cc7d26ef3bc6e9b662bc6a90f3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9dee86896c5968a928e56828236af41c136bdfbd
Message-Id: <159649260613.26696.11610296713749503249.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 22:10:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 14:06:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9dee86896c5968a928e56828236af41c136bdfbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
