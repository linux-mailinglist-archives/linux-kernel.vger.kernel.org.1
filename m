Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49082DA6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 04:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgLODI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 22:08:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgLODIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 22:08:37 -0500
Subject: Re: [GIT pull] x86/fpu for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608001676;
        bh=su+YcuC+A/vdHxUcb9jwC7QpVhef/iD8pnVupLPHKYI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RkP0wK2uAqsEj7eiYIO2D5T6DeKwYVVX0eL/hsed+hejqgvS+/dx4/esx/H8P14R1
         F22wrvgTbU+EPSoq2kmOVc2W8zjtw4GKXXiMMxpNq2qnX5mo5Asgh/QG6eqqaHfH7V
         4WY8ZlNwpWlSnGmUJ/ZloFP4weiES9KpLSO0WVpcUyee3m18Ky1WIcUU+4Ob4+WFNZ
         T1zF0KteZC7DF2BMSpwAHBglf4UFQ2Zb1C8+bXvPmXzYbeMPcfYqWz3cMpMQT/wpx1
         hOCN3tcMEk7Hvqcq/xDaBNtlgOXXTom83WcO97Z6SUnML52EUjXvPCyTazNzppPJKz
         AGxtlgh+0pTjg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160797734154.10793.1671535872493484817.tglx@nanos>
References: <160797732939.10793.9152151866806316627.tglx@nanos> <160797734154.10793.1671535872493484817.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160797734154.10793.1671535872493484817.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2020-12-14
X-PR-Tracked-Commit-Id: cba08c5dc6dc1a906a0b5ddac9a9ac6c9a64f2e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb0ea74120e0f14a6d6454109153d1b4ccf210fc
Message-Id: <160800167684.18953.305292577923439385.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 03:07:56 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 20:22:21 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2020-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb0ea74120e0f14a6d6454109153d1b4ccf210fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
