Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC6F214F16
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgGETzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 15:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgGETzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 15:55:08 -0400
Subject: Re: [GIT pull] irq/urgent for v5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593978908;
        bh=rkkNiGa8Xv4KiQRtBJXyyFHGekURYxQj1ZJDRrpodKA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eWbsUWBE9nE+PZ2P2akHeZcsrDuhFraZydn67F/D3iIr4r+dY+K9+gC3fBBfQ71IE
         /+SJr/BBfwoNtf5KzYUvNx9ra2fsTPHl5epZAs/3/EM0wOi/UmjzLDzPvSltrrWtNY
         t7BmOpH5go8Yz5pKRGrcRh1Nom7EbvC+1kWOVOPg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159396401536.28963.14025922176028941347.tglx@nanos.tec.linutronix.de>
References: <159396401414.28963.18435590961866091585.tglx@nanos.tec.linutronix.de>
 <159396401536.28963.14025922176028941347.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159396401536.28963.14025922176028941347.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-2020-07-05
X-PR-Tracked-Commit-Id: 98817a84ff1c755c347ac633ff017a623a631fad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f23dbe18930ba992f5c8c7b31e80f40dd6716081
Message-Id: <159397890809.7489.18247541385895797442.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jul 2020 19:55:08 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 05 Jul 2020 15:46:55 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-07-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f23dbe18930ba992f5c8c7b31e80f40dd6716081

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
