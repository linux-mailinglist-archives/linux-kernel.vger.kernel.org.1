Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444562DA62F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 03:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgLOCWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 21:22:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgLOCWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 21:22:31 -0500
Subject: Re: [GIT pull] perf/kprobes for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607998911;
        bh=N/odZHOLUuD7y5xf5A59YP4EcDtYz/Qq3GTJztzzZlU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b+6YCjmEqqIEt15Ch5GtXTC1VNKipfEuSAk7kGqBqmRoyLg5AC28JtsowAdZLdZFD
         016Qtx+Y/gierdeKizEVRT77r5tKmTR4JUaAcrFN6kXPwTZmUkHDqyhoiJunNdZXoP
         +TbmVnY+5r0F0rMlxGzGEDde1dTIf0DeSX3tqXWeNeaLp3ELggLj+haG7PYBwUQVBw
         92YXtcKyK0TYCal1R8z3kOPnTkWXeItlNDo2PldWG+AOUiYuvi1q8wdWxCeohnUz2R
         JxlfJNN0Sk8G8IkWcc82V3Xegphmg4+B2EgCQMgCbgzQNsyATBLnqLHTs3kfjZapJg
         TTqKUyeXmMcIg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160797733667.10793.7109332068482192551.tglx@nanos>
References: <160797732939.10793.9152151866806316627.tglx@nanos> <160797733667.10793.7109332068482192551.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160797733667.10793.7109332068482192551.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-kprobes-2020-12-14
X-PR-Tracked-Commit-Id: a70a04b3844f59c29573a8581d5c263225060dd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76d4acf22b4847f6c7b2f9042366fbdc3d20f578
Message-Id: <160799891144.23883.5573778799007327832.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 02:21:51 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 20:22:16 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-kprobes-2020-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76d4acf22b4847f6c7b2f9042366fbdc3d20f578

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
