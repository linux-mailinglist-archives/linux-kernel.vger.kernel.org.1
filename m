Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72231EB14E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 23:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgFAVzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 17:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgFAVzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:55:05 -0400
Subject: Re: [GIT PULL] kprobes updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591048505;
        bh=Qc/qc1vzVlIST/6egVXEGnarxuVppbT2FA3DreMjDaE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m0RkGa+Tw7IdtAU5uFW3ZLkCvBQjT8J1LjIUal6ei3IoSifg8MqsJyQlHq4PXw+V0
         1uz68/pHUpxZmCPEa2AmXtGMtNra95SwIe3bebknRXJhd8P8eWDqPrM6/PjWZhUBJy
         BA1tw6r94OCL9ZzoRnUn/fwVDyMgzwayDD+MQw+0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601130806.GA746506@gmail.com>
References: <20200601130806.GA746506@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601130806.GA746506@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-kprobes-2020-06-01
X-PR-Tracked-Commit-Id: 66e9b0717102507e64f638790eaece88765cc9e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0bd957eb11cfeef23fcc240edde6dfe431731e69
Message-Id: <159104850492.21074.260041352402237226.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 21:55:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 15:08:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-kprobes-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0bd957eb11cfeef23fcc240edde6dfe431731e69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
