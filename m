Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14647244FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgHNVvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 17:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgHNVvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 17:51:17 -0400
Subject: Re: [GIT pull] irq/urgent for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597441876;
        bh=gUxHwrTLv7dFot0yUVjKIJmpoglqjbKSolhkWij83Ro=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=C5NcWEgor+MntULz6w0wUi8zZb36MClCjO34RA+xHjIus8Zxaeg7mKbtQpfj7HieC
         izB4oA3PZQk2ZfiVPnmEACbUfm4AFRVis4aJ/5uO4ajQHpDYikauH+LG5qmJ1A3Wxf
         iEywFc0cVF6Y9dAv/YzA69jiY1xd4Vt3bbNAL/hg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159742071192.30851.2328227964586183297.tglx@nanos>
References: <159742071192.30851.2328227964586183297.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159742071192.30851.2328227964586183297.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-08-14
X-PR-Tracked-Commit-Id: f107cee94ba4d2c7357fde59a1d84346c73d4958
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d229a65b419cf51a9921d73907f1998a0e14daa
Message-Id: <159744187670.11302.17145360398497433203.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Aug 2020 21:51:16 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Aug 2020 15:58:31 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-08-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d229a65b419cf51a9921d73907f1998a0e14daa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
