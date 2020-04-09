Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7F061A3B02
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 22:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgDIUA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 16:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgDIUA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:00:27 -0400
Subject: Re: [GIT PULL] Modules updates for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586462427;
        bh=S06Ker0AUMFzpVFs0Ly9cgPbaixlj2GldLgaC6kXGoY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ojttuttxXX5VrFDfT8GXFA2nzSX0fp5qrYWhibLgqxWulPtc5idllrDeV3SpmYGX9
         ZwtqO7WizzKLlPaBtSqfXmuHCO6d5d43DSVUymDUb6Agb7arJX6z1JKFcfQ3jl0fVO
         YV63E5Pz9+MMLQZKvKFw2CAOydIeigitCrcuXoJw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200409091323.GC26619@linux-8ccs>
References: <20200409091323.GC26619@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200409091323.GC26619@linux-8ccs>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.7
X-PR-Tracked-Commit-Id: 0f74226649fb2875a91b68f3750f55220aa73425
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0cc271173b2e1c2d8d0ceaef14e4dfa79eefc0d
Message-Id: <158646242770.17533.13954751309242498705.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Apr 2020 20:00:27 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Apr 2020 11:13:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0cc271173b2e1c2d8d0ceaef14e4dfa79eefc0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
