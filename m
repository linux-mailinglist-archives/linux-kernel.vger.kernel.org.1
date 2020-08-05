Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951B623C304
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 03:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgHEBZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 21:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgHEBZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:25:09 -0400
Subject: Re: [GIT pull] irq/core for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596590709;
        bh=eqKhtugrtqOVJpDeY6YyhwGbDPbz2z8/g5wncRkwwRI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EqM/eLWB4trt/Z1kEyKdQBNp+wXsiGOFuMdlrJpdfJ+vQuv6CA4+If3YzqatmVz53
         V97z7LjJ+3jj3KBJjecXYppz9402MtAsgfb8BMA4ZNhnXClJBNYC5ItAtU+qmGvrYI
         0rCki1mH1rB5b5M69P0vw8j6wTnaGBHbWeoWm0QY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159652931460.11821.10453621811208035324.tglx@nanos.tec.linutronix.de>
References: <159652931338.11821.6870342948950391828.tglx@nanos.tec.linutronix.de>
 <159652931460.11821.10453621811208035324.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159652931460.11821.10453621811208035324.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-08-04
X-PR-Tracked-Commit-Id: 3d5128c1deb5d27993fb11ba5e517798f8021046
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8b036a7fc231fe6e8297daddee5dffdbbf2581f
Message-Id: <159659070929.20322.15656482454738646896.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 01:25:09 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Marc Zyngier <maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 04 Aug 2020 08:21:54 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2020-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8b036a7fc231fe6e8297daddee5dffdbbf2581f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
