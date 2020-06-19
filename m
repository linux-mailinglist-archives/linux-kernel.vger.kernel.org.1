Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74E8201B41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 21:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388741AbgFSTa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 15:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388580AbgFSTaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:30:23 -0400
Subject: Re: [GIT PULL] overflow helper addition for v5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592595023;
        bh=XreBJ9QwN4ELpOzgYdDthlvw1lAm1Q3T8fnwzsH49G8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iaRlLAKByU2ImuRwHSF21cu6Vy/nmHzp+wXYKZnRvVCCGooY9A9yAr9K6hbNPkHDg
         6CtpcW9L6bgcre5fnXxWszS8dCZpvq1aLFBSNM0Ov0Meqx+YaFOyLu53oX9GwKtWoL
         i9Zq5IlGLbcUKAL2ZpjUoFCCmqcnb7EJJMgJx5aY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202006181937.CA6017A@keescook>
References: <202006181937.CA6017A@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202006181937.CA6017A@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/overflow-v5.8-rc2
X-PR-Tracked-Commit-Id: b19d57d0f3cc6f1022edf94daf1d70506a09e3c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98b769942c698e43117334332ebfed852dfa6ff9
Message-Id: <159259502311.2705.2557183636948415164.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jun 2020 19:30:23 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Jun 2020 19:42:12 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/overflow-v5.8-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98b769942c698e43117334332ebfed852dfa6ff9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
