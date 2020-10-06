Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8057285242
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgJFTSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgJFTSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:18:34 -0400
Subject: Re: [GIT PULL] arm64 fix for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602011914;
        bh=1O2SGYf8UdDixD8Rvu1LvQJOL7HoH93dP746FfsQCVs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=P6/ZlNrXgv38pqO6JhKq22ok4iZRcZ+DsBNEHpc7DMT/o4huA1ELaNu9UoX6/bQk/
         gZqbPK/wBvwivwwgGOBT5IBXYqlJwuu5SF82zjmRN2UwNbArsH5bu8lG6jsXc7+aW1
         8sK7lV+vtTESknuVEUnNwsEuzVyn9S76bhJg7EB0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201006180818.GA25842@gaia>
References: <20201006180818.GA25842@gaia>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20201006180818.GA25842@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 39e4716caa598a07a98598b2e7cd03055ce25fb9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c85fb28b6f999db9928b841f63f1beeb3074eeca
Message-Id: <160201191439.29733.2310834254809684461.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Oct 2020 19:18:34 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 6 Oct 2020 19:08:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c85fb28b6f999db9928b841f63f1beeb3074eeca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
