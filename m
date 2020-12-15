Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AE42DA62E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 03:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgLOCWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 21:22:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgLOCWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 21:22:31 -0500
Subject: Re: [GIT pull] perf/core for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607998910;
        bh=R9heuPnF+Vb5pfrSbZKBNifBpqZjFcQgiBgi6hL+h+c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DhNOdXDTKg2Nq6ANkI5CyKxV8ncrMRq3H9b4+CpB9+9IMKKCdax/aX/tmWj5sLXiE
         LopaMOr2Bk3wzP/CahjfH90s4+bfrdXNA9Ek3JnpSxz2TNL59v5Hcd8YM6xn3e2hr+
         Ewo9NFdKgcjaR81Gxpl/zhTGyoutNpMeDqL6nF5/XQgrdCCPNn3uMGit0v4Rw0iC7q
         VhISWJgrGSVs4Ke1+BK9zhlxslW66K3pa/xrS6hS2rMl5ewMYZtUEOkzhttgq9Bk+C
         zDCY0h9D52c7ycuNZSnMdMiW3Id0K7hea6ITJ8/yvzFZlzvjfqGAP7QYn28GUzZsrc
         k4nyiN4cgQJ4A==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160797733546.10793.8273660982632549351.tglx@nanos>
References: <160797732939.10793.9152151866806316627.tglx@nanos> <160797733546.10793.8273660982632549351.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160797733546.10793.8273660982632549351.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2020-12-14
X-PR-Tracked-Commit-Id: c2208046bba6842dc232a600dc5cafc2fca41078
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a8ca83ec3cf7ffc69020c189e3d368b1d4ba98a
Message-Id: <160799891083.23883.2114675003525545559.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 02:21:50 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 20:22:15 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2020-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a8ca83ec3cf7ffc69020c189e3d368b1d4ba98a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
