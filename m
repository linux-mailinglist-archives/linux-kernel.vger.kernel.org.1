Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB6126EA4D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgIRBKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 21:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgIRBKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:10:09 -0400
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600391409;
        bh=X0QzoBRAoLfxfmXGL82nMHXlQLy7LaI5eiATbMdHuVU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EMCBTgcGwWwiarZolvLrKBeX+n9lNJRIp9cl2vw6/5xNdSY7GD9R1WXHUmAa0ySQS
         l6O5T3QTygViA99FxbyVfZxNt0Bm6KLJWFfW3fphv0jwx17cUIiFYSjWaR/mL85oMH
         s1jzeTJCFUINN6JxarYdqlPwPZYoW5J+MoD6TZJw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200917204514.GA2880159@google.com>
References: <20200917204514.GA2880159@google.com>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20200917204514.GA2880159@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.9-fixes
X-PR-Tracked-Commit-Id: b3b33d3c43bbe0177d70653f4e889c78cc37f097
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10b82d5176488acee2820e5a2cf0f2ec5c3488b6
Message-Id: <160039140942.8261.2749537384010281794.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Sep 2020 01:10:09 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Sep 2020 20:45:14 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.9-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10b82d5176488acee2820e5a2cf0f2ec5c3488b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
