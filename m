Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E391F6FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 00:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgFKWA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 18:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgFKWAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:00:25 -0400
Subject: Re: [GIT PULL] RISC-V Patches for the 5.8 Merge Window, Part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591912824;
        bh=gZ46K7plbt+eE/wq0aG7U6KOtRrOLE73xRAiFeDQQtA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lLzXKluwUtogg+QEcBdE+bgWFeCqe9frdD0SIJGVc0J5hYEuIMovdCzdrJR+XMEEa
         ucqtPnx1o2FcsXzSsh77kugAZhuv66g4JWi4zEPGA1lQ5QQO1q4n+iWoQqBsriZn+5
         BQ9JVJXc2FygUJJ2+PI09Uwiq23SM/AMYNWhBTQ8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-70ded5ff-c09c-4703-837e-7ab2d9eea85c@palmerdabbelt-glaptop1>
References: <mhng-70ded5ff-c09c-4703-837e-7ab2d9eea85c@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-70ded5ff-c09c-4703-837e-7ab2d9eea85c@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linus-5.8-mw1
X-PR-Tracked-Commit-Id: 01f76386b0ac0b1c1094456c8f43ea6085fc49d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd16ed33c3c618930ccda7049dcea05ee707a9c0
Message-Id: <159191282473.15411.16688151928262454215.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 22:00:24 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jun 2020 10:53:59 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd16ed33c3c618930ccda7049dcea05ee707a9c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
