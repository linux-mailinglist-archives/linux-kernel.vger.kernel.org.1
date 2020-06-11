Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEAE1F70FB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 01:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgFKXpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 19:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgFKXpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:45:22 -0400
Subject: Re: [GIT pull] x86/urgent for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591919122;
        bh=4+yQLrkC9GRtpB2X2ZCSWiTLQi+ynS0ENtK5zT/19CI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=t14Ftoj6bDPuYC9AiZhGNtT0TeQh2e9ovHkMvkJTjDuCaIWI2BCwpoSwdjkiYSNdx
         F1cxcfnBh9C4aCRCA2y92Jsrp+ecaITz34cmbLRxn4WSrMaislc0Gg6T/n5+v86eXT
         8qyovp4tyvz1trWJqM/uF9CVpJqAKvDiCObNfct0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159190118331.28418.15784482710329781943.tglx@nanos.tec.linutronix.de>
References: <159190118210.28418.16838792857524354792.tglx@nanos.tec.linutronix.de>
 <159190118331.28418.15784482710329781943.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159190118331.28418.15784482710329781943.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-06-11
X-PR-Tracked-Commit-Id: 7778d8417b74aded842eeb372961cfc460417fa0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a45a65888393eda692fce0851c40d9f5ce4ef66
Message-Id: <159191912224.19194.18147504760330711000.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 23:45:22 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jun 2020 18:46:23 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-06-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a45a65888393eda692fce0851c40d9f5ce4ef66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
