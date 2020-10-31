Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296DC2A1AE0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 22:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgJaVqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 17:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgJaVp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 17:45:58 -0400
Subject: Re: [GIT PULL] flexible array conversions for 5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604180758;
        bh=HmlnDeDVgTSfSEBG5fTocH7NdEBXMRnoEQVi+MHEtcQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oDHkY/MhpCWLlnhE0JXoE8GwtVoOXLAnC8Vm34+sNYbDi+UGw562AlBQNRHJFc20b
         EQuvFsnXrHrw2m0WvimcmmfTi9uovLBXpjqDYp10rv0qaZBTS3wuOjxIHqIbqY1Ddh
         WHI0K/WlHtaBtMatcU+eG278JR8t+fv56yTEphUI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201030221342.GA6183@embeddedor>
References: <20201030221342.GA6183@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201030221342.GA6183@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-conversions-5.10-rc2
X-PR-Tracked-Commit-Id: a38283da05d321fa1fce38ea3cf41c9f1dbd1f21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53760f9b74a3412c1b67a20b0e8dbf7c3cebfc45
Message-Id: <160418075849.5586.8963379479390747572.pr-tracker-bot@kernel.org>
Date:   Sat, 31 Oct 2020 21:45:58 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Oct 2020 17:13:42 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-conversions-5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53760f9b74a3412c1b67a20b0e8dbf7c3cebfc45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
