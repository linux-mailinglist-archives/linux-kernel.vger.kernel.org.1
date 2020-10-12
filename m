Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA3B28BF97
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391034AbgJLSVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390884AbgJLSVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:05 -0400
Subject: Re: [GIT PULL] x86/pasid updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526864;
        bh=DXI+VhhHc5TKCY7mAAWcRkjzMjMk7fwaJC7tMUhqPh0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LZbPhC0Bw9EiD/GEGgLpPkHjodwazvSobaSEpDQni/NhVlw9KCc4H6LSD043jNXvH
         K6aeL6iWSWZBqqucujHjyB6YGXr9kyIy8yjNciDYIHgMD+IiUXcnobHIDPSmf3J8gQ
         BMjDYLMuki1RZOWKSn8/3j5JeCY9u4hUcdqZ0vIA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012101525.GE25311@zn.tnic>
References: <20201012101525.GE25311@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012101525.GE25311@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_pasid_for_5.10
X-PR-Tracked-Commit-Id: 7f5933f81bd85a0bf6a87d65c7327ea048a75e54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac74075e5d525f3e782f88ed8d8b1df35c1497e5
Message-Id: <160252686485.3643.4589406596349350585.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:04 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 12:15:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_pasid_for_5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac74075e5d525f3e782f88ed8d8b1df35c1497e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
