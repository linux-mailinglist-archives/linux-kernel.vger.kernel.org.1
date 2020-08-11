Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B27E2414F2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 04:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgHKC2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 22:28:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgHKC2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:28:15 -0400
Subject: Re: [GIT PULL] ktest: Updates for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597112895;
        bh=APYx2ieiO2c7ZFEH/QnpKdN0zBjOTyU/UUkVk41KsTE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=izQ2+hfNicFDiQECbTD/WwCuxmJfvoUTW2SjlIsPp1f0zeG1LHxBIlMxIbDuDcj/Q
         DRy9r9wA7F5uPm+ICLpye0SCxn9OOGL9VGNaJLn0fLEkJ27P7ju5XKvX4rqVhn6C8w
         ypcqEb1xBxjxyRwF1sV5S+zYFXQJIMZac9++si/o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200810214952.394ccc78@oasis.local.home>
References: <20200810214952.394ccc78@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200810214952.394ccc78@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.9
X-PR-Tracked-Commit-Id: ff131efff141fc679cccde28bc265f4c79cbe329
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed3854ff994b35cc11658d43d01a421bd5088d23
Message-Id: <159711289536.3363.15878002918604546056.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Aug 2020 02:28:15 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Warthog9 Hawley <warthog9@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Aug 2020 21:49:52 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed3854ff994b35cc11658d43d01a421bd5088d23

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
