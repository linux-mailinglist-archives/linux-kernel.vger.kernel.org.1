Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C00D23B1D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 02:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgHDAuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 20:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729168AbgHDAuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:05 -0400
Subject: Re: [GIT PULL] x86/asm changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502205;
        bh=4A8rw98ov8fCxggCv2GrxWbAVFfCVSL7QLAP+gSPPik=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WVSuKsHOFjS/q9FXin8gWcOxhhCFTvTxSYzP0R8owXY/pOa0L3eGwHAmg0PlUBhIq
         uGh51wMQbxlZfQx2EAmcvuLAI2WhdYQTa1Qp20chIb/Gr3mcsFzHwR9ZheSU/3NM7Q
         epogRJkaE0hIziiBQkwoqod62531D9GMxpfSyIS0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803160210.GA760622@gmail.com>
References: <20200803160210.GA760622@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803160210.GA760622@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2020-08-03
X-PR-Tracked-Commit-Id: 158807de5822d1079e162a3762956fd743dd483e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba77c568f3160657a5f7905289c07d18c2dfde78
Message-Id: <159650220509.17631.5916093244891665937.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 00:50:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 18:02:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba77c568f3160657a5f7905289c07d18c2dfde78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
