Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC6E1D6CC2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgEQUPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 16:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgEQUPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:15:04 -0400
Subject: Re: [GIT PULL] Please pull exec fix for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589746503;
        bh=j/AwKnTpUgFy8aXOjDQHEvtIZJQbknoqa+joHEaEqG8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cljdGm3KQGj2YodMp+y22aAN173Uj6c3NBt60egV882EDhwxkcvvuBcc4Eq4pDnbc
         bnmvHZC8/DnXkw70tRjccUnbVFkSyfkf8yF0N1CVZiquBkKJ0mlaKC3DNDA2XDZT6V
         iUqTWFgP6WvKrIqrWdLSaHWc7054nBqfnImhnFUk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87imgu7dio.fsf@x220.int.ebiederm.org>
References: <87imgu7dio.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87imgu7dio.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
 exec-linus
X-PR-Tracked-Commit-Id: f87d1c9559164294040e58f5e3b74a162bf7c6e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b48397cb75ac17a5c6f99b3b41fab0ab1f879826
Message-Id: <158974650372.31612.727158402282060572.pr-tracker-bot@kernel.org>
Date:   Sun, 17 May 2020 20:15:03 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Willy Tarreau <w@1wt.eu>, Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 May 2020 11:05:35 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b48397cb75ac17a5c6f99b3b41fab0ab1f879826

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
