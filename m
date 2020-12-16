Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0972DC7A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgLPURT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:17:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgLPURR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:17:17 -0500
Subject: Re: [GIT PULL] parisc architecture updates for kernel v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608149797;
        bh=trVwk2vMQwm4VXGLnsXuN4anCVVvLstBtKZMcPE5fLY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YXsJeCnXTx0tZT1IFyEDqk9YgomVdJIwm4j7/qfZ/K2L5x+jv1RwYUB9ogE1nceWo
         zZb+CYnTP+xxRy0a3f24sGVCE5LDC5Om2HOJ0HIoSmLoe66cHFvXSvERIYYAdLnoHZ
         4ORZstUZjAFFHxAjVq0MqzpSMXp4BVONCp7B53wY224mmXdbq8wD2ZOWi6YDTVrlS8
         Z1jSFUGqEc+sNwNCHVKnGVfWBwJlwCCFUNmj0ctC0Z/xLvwjyUr98NHLzZqAZAcx9F
         EzrY8IJ0KuCj3077UuyRYv5f04fcrJjjbTcPeyOMYu+0ckkO3yDtxAIUABGSxKSUOy
         h3gaW7WlIcopg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201216192235.GA27343@ls3530.fritz.box>
References: <20201216192235.GA27343@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201216192235.GA27343@ls3530.fritz.box>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.11-1
X-PR-Tracked-Commit-Id: 39b1e779b6e2d4ca7967b49b26f1e4358f20c90c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ee863bec794f30bdf7fdf57ce0d9f579b0d1aa3
Message-Id: <160814979733.31129.5599484646624875831.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 20:16:37 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Dec 2020 20:22:35 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ee863bec794f30bdf7fdf57ce0d9f579b0d1aa3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
