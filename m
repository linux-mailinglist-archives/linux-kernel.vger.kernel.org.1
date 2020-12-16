Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CAD2DC75A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 20:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbgLPTps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 14:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbgLPTpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:45:47 -0500
Subject: Re: [GIT PULL] gcc-plugins updates for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608147895;
        bh=IfXFlfGv0AiOL2RAwIq6jjaIJA8K0ucaRg3QOWSOT6M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jMfKWrCAml++1+v2gtu5k94LhuhzFlMuThKZ2wefvBOlVd+23l17X8VQ3bxgps1ME
         M8CDNZcSpGnrdEj9L/dAjzmj0Xfz+qUT67oUF50IhovH0EOvFmdEVpbItplfyuzn17
         TNDExbNmxOSdCFJFRx48OJUuejKj8oPpYpBlGRmo0i5dJYLV94AfKefWAUC8mIX/QY
         a8+wvRbj5+xZHANzVAueJ8/p6FzFZecPk4GyFbLDJzUpb/CS4sQ/hZwDzs/Ly8bBx7
         02CixTSc74NxgrpJlagEqerGRuecPkMcnOTStOn1Mk/IbkfdnXrd6lp2dv4bFX4jRn
         v5aur+V+nnw2w==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202012151215.E7AA7D6@keescook>
References: <202012151215.E7AA7D6@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202012151215.E7AA7D6@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.11-rc1
X-PR-Tracked-Commit-Id: 53a57e60de74a3531ae769b3241cc5169e1431ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6df0f2855a9ae888fd19d034d8e6889cee6b639c
Message-Id: <160814789560.14944.16028131072094326620.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 19:44:55 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 12:15:36 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6df0f2855a9ae888fd19d034d8e6889cee6b639c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
