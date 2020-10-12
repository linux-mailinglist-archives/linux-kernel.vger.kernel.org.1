Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103BB28C19B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389402AbgJLTrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbgJLTrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:47:05 -0400
Subject: Re: [GIT pull] x86/entry for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602532025;
        bh=C1sE0hWL9JdfraYgCcc6f1YUXgnqGir5mAXGivW8sZU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=03y/GOZ/9TkLx/Axh4fZ2dzJNgv4BIe33gILLA74aajhV76IIe1zI+oc7J1Qh+Y/A
         VWru5/f8zLYYOu89c0uVNpKEaSzHzLx4D4uCEwe/Q46qIQw3q34I1gk/PSei4p1otg
         hIKelLdrW1E+GVpFV04ZxZjnYNlimR/33QezUmyo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160252482265.32373.8059671755708873284.tglx@nanos>
References: <160252482265.32373.8059671755708873284.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160252482265.32373.8059671755708873284.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2020-10-12
X-PR-Tracked-Commit-Id: d53d9bc0cf783e93b374de3895145c7375e570ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13cb73490f475f8e7669f9288be0bcfa85399b1f
Message-Id: <160253202495.16131.939705675257015191.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 19:47:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 17:47:02 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13cb73490f475f8e7669f9288be0bcfa85399b1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
