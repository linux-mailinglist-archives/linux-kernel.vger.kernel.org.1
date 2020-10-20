Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145742940C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394832AbgJTQqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394817AbgJTQqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:46:05 -0400
Subject: Re: [GIT PULL] ARC changes for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603212364;
        bh=LQPiQPmS9JRz9yams9x2cA8qS2ds1jJjHVTUV12Mh1c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bd5IEG7xnL4SUIeD3rTEPvZSqSWyDnWGtf2S/4WG30dK4uAfFwOO+EaVjeJk8GK7R
         9aSJMP6XdjExotd34CvIbc34VJ11TIXXHORog1SQKJWlhqMTwPWuljKr6Gur/XqU46
         cN7BIzgqv8kV4uy1CInJKAgUM3CIcfQqynMlDikU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bbd3efb4-39d2-1d2f-b4c5-0f68dd6f481f@synopsys.com>
References: <bbd3efb4-39d2-1d2f-b4c5-0f68dd6f481f@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bbd3efb4-39d2-1d2f-b4c5-0f68dd6f481f@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.10-rc1
X-PR-Tracked-Commit-Id: 6364d1b41cc382db3b03cf33c57b6007ee8f09cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b32649b863623d89fec83aa27d19c28715c4fae3
Message-Id: <160321236462.11581.12800103264500445363.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Oct 2020 16:46:04 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        "Ofer Levi(SW)" <oferle@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Noam Camus <noamikong@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Oct 2020 01:57:21 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b32649b863623d89fec83aa27d19c28715c4fae3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
