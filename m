Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8F91CCD52
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 21:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgEJTpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 15:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728823AbgEJTpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 15:45:05 -0400
Subject: Re: [GIT pull] x86/urgent for 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589139904;
        bh=qj7ALf7+VBbTZXwVTKLPLO37lpmTfANxfLp9glTWoHY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RhwEUQRq7HjIcxnON09N99RYom987vP32fU13u9PQBQ1Rw/i0BeWE+cFpD2grFOMY
         8zkzKRR/9Cy/f07nPsdmYHrOdK4NoGmJYOaN12NAPPHfZ0Hf88jMNnw/HxhIy04zLY
         sqsEqiZR+I4R8tXwRktWTIOa98G8kCqF1P2QX1R4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158911175944.19109.11559501658854451831.tglx@nanos.tec.linutronix.de>
References: <158911175703.19109.2236997977254447943.tglx@nanos.tec.linutronix.de>
 <158911175944.19109.11559501658854451831.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158911175944.19109.11559501658854451831.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-2020-05-10
X-PR-Tracked-Commit-Id: fb9cbbc895eb6e986dc90c928a35c793d75f435a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c14cab2688d09b851349acbb83e5fce8e0d4ca42
Message-Id: <158913990466.3456.4084016586655724143.pr-tracker-bot@kernel.org>
Date:   Sun, 10 May 2020 19:45:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 May 2020 11:55:59 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-05-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c14cab2688d09b851349acbb83e5fce8e0d4ca42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
