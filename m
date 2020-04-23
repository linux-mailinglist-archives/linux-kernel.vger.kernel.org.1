Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0751D1B6131
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 18:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgDWQpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 12:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729407AbgDWQpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:45:18 -0400
Subject: Re: [GIT PULL] Audit fixes for v5.7 (#1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587660318;
        bh=2H0xaD5b72HI7Xk9Tngpmu837nPxKcdFdyRGf1G/TNw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F9f6tpgl1Hd6FSqGB/CyVBgiznbt7Vn4Kyhc72B6xELUnLZm0uJNu97yFbQwEwuk4
         BT73F43vXdsYv7BGhDNtmCx+PrPSBDRAfmEto6Eu/enP9YkhgSR0GjTtUhlmzOY6Fq
         VFoAs2RvcHaZiKKy1BNW0PcHl83fKzUEAdtgG7p4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQNo=Z3G-K8KvTGiu0Fzmwv4byFQriNuTsu+vwnx85YXg@mail.gmail.com>
References: <CAHC9VhQNo=Z3G-K8KvTGiu0Fzmwv4byFQriNuTsu+vwnx85YXg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQNo=Z3G-K8KvTGiu0Fzmwv4byFQriNuTsu+vwnx85YXg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 tags/audit-pr-20200422
X-PR-Tracked-Commit-Id: 763dafc520add02a1f4639b500c509acc0ea8e5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a400063826b6ab7a9dc8eeddcb36a55ebbd7dab
Message-Id: <158766031859.20212.3262990343424454639.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Apr 2020 16:45:18 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Apr 2020 17:25:44 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20200422

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a400063826b6ab7a9dc8eeddcb36a55ebbd7dab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
