Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F482D903E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 20:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391293AbgLMTke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 14:40:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbgLMTj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 14:39:57 -0500
Subject: Re: [GIT pull] x86/urgent for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607888356;
        bh=XU12oJ5ptOds2p9w4548svaCVx7r4IsRyIHLlEdhH1s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G+FMikDnNGJe3OCn8Z9fScBg7B0PihCjsw9Otg1I0P8jbHhMGAP0JXT6qbycNs7Ex
         /pIEmmBDPZ4jyaQ5YOER9yzg0kzv0RF7rX76gpmyUCmeDz7OfZtvz3+oeNXdxVg9AW
         5vXEjVur/VBTTmRMw9GBaFcWpOWUHEr5SpZxUy0tY0vWuKK0RHHZKa6dD9aNuviMgl
         DXEFVXJupcuuEhholODcyVY/PnkChXupf8udtUlE3ceyMEMDc5mflnoPyT0QLO4Jod
         Eq1X60rSpy/6hkV7WWeH+T8jVXsBDcl7KsQjhzXq4CxfXbIIWkwuwEaTRlQQnIRP/l
         NVh547XgP0FTw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160787544257.29236.9507174976469921731.tglx@nanos>
References: <160787544257.29236.9507174976469921731.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160787544257.29236.9507174976469921731.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-12-13
X-PR-Tracked-Commit-Id: 0d07c0ec4381f630c801539c79ad8dcc627f6e4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec6f5e0e5ca0764b4bc522c9f9d5abf876a0e3e3
Message-Id: <160788835691.9552.9914419967789101948.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Dec 2020 19:39:16 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Dec 2020 16:04:02 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-12-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec6f5e0e5ca0764b4bc522c9f9d5abf876a0e3e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
