Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 386B119EDAC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 21:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgDETp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 15:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbgDETp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:45:27 -0400
Subject: Re: [GIT pull] irq/urgent for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586115927;
        bh=Uc4dxmXZt2TubmHwnpLgaa0+JjCBvYlwPblos1OLkh0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m4ogZfshiicWcq0AbpL76+5QtMIp0qgqpYV+gjevJyHK8iNVjNja1ek/PADj1oHsq
         TBb+uzX5xUFv3QlpsJrk3+ZO2oqeVXAi05IiY5ud+GjvjFflIe/3+gdqqscg+ZTj8U
         DI7SkXNYPIHp6znys2Y7yLWGuUcWZPL3rkbjElJ4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158609410988.4266.5816311298811487752.tglx@nanos.tec.linutronix.de>
References: <158609410988.4266.5816311298811487752.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158609410988.4266.5816311298811487752.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-2020-04-05
X-PR-Tracked-Commit-Id: a67cd1fb660df8d8e093cb4b75343ef3dcd17cd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5adbd6ec480164fe30ee65c94426cb12d64bc99
Message-Id: <158611592703.11305.2043316664050312096.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Apr 2020 19:45:27 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 05 Apr 2020 13:41:49 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-04-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5adbd6ec480164fe30ee65c94426cb12d64bc99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
