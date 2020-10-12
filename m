Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7641428C3FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbgJLVZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732140AbgJLVZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:25:07 -0400
Subject: Re: [GIT PULL] Static calls for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602537907;
        bh=9XBOGWhfk9fSuYRSXdhBRwU3OxSbVn+sLG7eCjPaNlQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=i9eU9/njChi+lI27UwG7yY0PRputQTWCv7DJXsHGYh4lPEppSbgdMpPXDX5xTWS4z
         aV5lLl144HfakmEminjqlg+havZoUOT61NYOofh5A73w7vvNnF1kgnIXLfD5vc+oRQ
         QgjX17cK6bMpWUBkcFr+fo9hXQIKE/TWPPgbItm8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012155542.GA3557765@gmail.com>
References: <20201012155542.GA3557765@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012155542.GA3557765@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-static_call-2020-10-12
X-PR-Tracked-Commit-Id: 69e0ad37c9f32d5aa1beb02aab4ec0cd055be013
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd502a81077a5f3b3e19fa9a1accffdcab5ad5bc
Message-Id: <160253790716.926.466799779881149323.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 21:25:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 17:55:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-static_call-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd502a81077a5f3b3e19fa9a1accffdcab5ad5bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
