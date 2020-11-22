Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5083B2BC991
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 22:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKVVfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 16:35:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgKVVfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:35:12 -0500
Subject: Re: [GIT pull] locking/urgent for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606080911;
        bh=5D0g+AgwMicGkcSIlSxIhO9qdIU98Ytv+rgTWrgrNZA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JHqgtFnYZnCoZ3yRGloHSI8UdmQJJFzHT7oTqkw5u26vYESYyMkN4q0X3m1CK9YwB
         kLMo20X7zTc1W+fjYMETVDPDjhQvh1MgpVo466+9spIGeMH9PY2N4xw6wxxv7/9+SZ
         Z0vfZT3QGDtlCquqKNHr5FcMyReu4EagfpBiwGiA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160605644301.9003.16302947389602369819.tglx@nanos>
References: <160605644301.9003.16302947389602369819.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160605644301.9003.16302947389602369819.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-11-22
X-PR-Tracked-Commit-Id: 43be4388e94b915799a24f0eaf664bf95b85231f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 855cf1ee4726bfa2077b2226bff507babe1c8dff
Message-Id: <160608091193.6067.17398055792217566136.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Nov 2020 21:35:11 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Nov 2020 14:47:23 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-11-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/855cf1ee4726bfa2077b2226bff507babe1c8dff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
