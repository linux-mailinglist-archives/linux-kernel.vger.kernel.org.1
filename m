Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005E328D730
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgJMXtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:32932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbgJMXtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:49:14 -0400
Subject: Re: [GIT PULL] overflow update for v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602632954;
        bh=NJk47f3he7hIGR5RbqTU76RE/X8xxMHMg2eBEEy5EcM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d41czsMKfMWyCoPpXdUqKqyLL02gSYYqPjkcnsymXKhUBaxL18BuplX2TNC+Ak87D
         rTyND7Z3eKPqXewStEAObOn3A6Whb11mSUm7AwWRTQMDLvQpjzZ7CWNysCL4HjibnV
         wb557nKhP9wX52Jkz9JUAEjK/8tbxCJzEJ7un1zQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202010121537.E5CB11BA@keescook>
References: <202010121537.E5CB11BA@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202010121537.E5CB11BA@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/overflow-v5.10-rc1
X-PR-Tracked-Commit-Id: 9b80e4c4ddaca3501177ed41e49d0928ba2122a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5fc7a89e58bcc059a3d5e4db79c481fb437de59
Message-Id: <160263295450.20088.9192911627059572575.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 23:49:14 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 15:38:53 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/overflow-v5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5fc7a89e58bcc059a3d5e4db79c481fb437de59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
