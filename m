Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E047E25E311
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 22:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgIDUur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 16:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgIDUth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:49:37 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599252577;
        bh=jZg1z8uowRvrbN+45w5wOSWFpBlhuP3Mhq8QvnvL1Vc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cCw1rFYLqgg3lhHOTe+mqbUhrTAv/9VdYzXv02xczO10MUZSvnN06bz2hC2jsSL7B
         2va7jMxIsYSLUUx0jcQsop+LK195tI+5tVHQFcJoBJpBpi3TovXXTYQaZdK9TBKS1h
         36uFQDdEn5gkn50xqE5/wLM+PpKVmvJ6lqMPfgRg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200904164132.18160-1-catalin.marinas@arm.com>
References: <20200904164132.18160-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200904164132.18160-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: e0328feda79d9681b3e3245e6e180295550c8ee9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09274aed9021642cb3e5e0eb0e657a13ee3eafed
Message-Id: <159925257698.25529.17084748437213435788.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 20:49:36 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  4 Sep 2020 17:41:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09274aed9021642cb3e5e0eb0e657a13ee3eafed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
