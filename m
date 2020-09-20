Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A9827186D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 00:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgITWk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 18:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgITWkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 18:40:22 -0400
Subject: Re: [GIT PULL] objtool/urgent for v5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600641621;
        bh=yCCWLrt/MD67+eKvl2ZGgzgI8GaBi9JYq0BQxWqknn8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AfBglduxCAIOtgNafiEmojNTiE9I3E+Jg/6q41e5euZGWheLjKQ4GkpMevelzi0so
         YxLPL2VM+dn4XrX8xdlx+jJJWopKco5FbqK3gM1NC2j25RY3f+hLmebK8J1JVZxvnX
         I/+rdwRxR7cJvFUWbp+XQItW844kdbxApCDRObGU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200920195823.GF13044@zn.tnic>
References: <20200920195823.GF13044@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200920195823.GF13044@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.9_rc6
X-PR-Tracked-Commit-Id: db6c6a0df840e3f52c84cc302cc1a08ba11a4416
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f8ee7e8521a496024fb504de9eacbb49bd9152a
Message-Id: <160064162189.32524.9553767938051574078.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Sep 2020 22:40:21 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Sep 2020 21:58:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.9_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f8ee7e8521a496024fb504de9eacbb49bd9152a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
