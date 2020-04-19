Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93111AFD52
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgDSTUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 15:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgDSTUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:20:24 -0400
Subject: Re: [GIT pull] perf/urgent for 5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587324023;
        bh=bQKFTLZ+81cq6hjhY1H0vefpWhAtyq6GG3wTvulCMMQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bWzPV6ro3l479kmirCE2MEso9IJbtTU2ic1HhoONPm8BaTt3TyZBjQ3Vqzs7Gvr+e
         Au1O2bzovlSr89taKGUP3JX5BphEoNeT6/iPoqNvQE764SJSFdGC3P7MxqDBh0XZNZ
         m3rJ3/iWjCAtI/y0pW/zS8Pce//W0CHGpx5G8jlw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-2020-04-19
X-PR-Tracked-Commit-Id: cd0943357bc7570f081701d005318c20982178b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7374586ebd48b1bfc75f5ed0eef89de17bdbe04
Message-Id: <158732402380.20624.8704474595053752726.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Apr 2020 19:20:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Apr 2020 13:56:41 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-04-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7374586ebd48b1bfc75f5ed0eef89de17bdbe04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
