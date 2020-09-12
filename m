Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB35267C31
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 22:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgILUAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 16:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgILUA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 16:00:26 -0400
Subject: Re: [GIT PULL] seccomp fixes for v5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599940826;
        bh=oHYtXHZLM7zfyZNRaIyJTsTW+t6XyMP2+2GbPyV6zXU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TEqe4rx29uJYTLoZmo2FbExlzmEsdRmzkJqDfU38MGxqFb4jqDaOXVdBFplBZRscz
         agGJU7Xdaz/5z/Z67jmYwnuFRGSoleDwmzBVVyZv14CHbkF24S+UJlXoEl1uLjwxF/
         sNQwmBYWeP0nZdH7H/AOMEapW6Q0aADMhBz2sWt0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202009111718.B94EAD7@keescook>
References: <202009111718.B94EAD7@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202009111718.B94EAD7@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.9-rc5
X-PR-Tracked-Commit-Id: e839317900e9f13c83d8711d684de88c625b307a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef2e9a563b0cd7965e2a1263125dcbb1c86aa6cc
Message-Id: <159994082647.29146.17798103258761298184.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Sep 2020 20:00:26 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com,
        Tycho Andersen <tycho@tycho.pizza>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Sep 2020 17:20:02 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef2e9a563b0cd7965e2a1263125dcbb1c86aa6cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
