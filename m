Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D611EB15B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 23:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgFAV4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 17:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbgFAVzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:10 -0400
Subject: Re: [GIT PULL] x86/boot updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048510;
        bh=DVs2HY0APLahbb1FYhhmxcPtdhBotBXa8zaaxqlcz00=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TxAbBXe15NhLYWoNHmNqfCLeSrjTDetQQD7YeWU/5qzGK7dUd8bYpPIJy/YsqRX66
         Acijk2PDWgF+es1bDldZW546IBAsZSRQMdIPHzeyu8BsnmG6CrH6uLJbarGtsHojkx
         jcK1wVTpIekqN265BzAGqNjAzwPO6IYtwJTZxoxY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601162302.GA1138465@gmail.com>
References: <20200601162302.GA1138465@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601162302.GA1138465@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2020-06-01
X-PR-Tracked-Commit-Id: 5214028dd89e49ba27007c3ee475279e584261f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae1a4113c24470007424ea0e1d2e31336edd7296
Message-Id: <159104851019.21074.15315591476011225104.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:10 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 18:23:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae1a4113c24470007424ea0e1d2e31336edd7296

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
