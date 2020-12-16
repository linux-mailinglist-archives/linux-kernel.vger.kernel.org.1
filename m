Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD4F2DC754
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgLPTpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 14:45:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgLPTpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:45:34 -0500
Subject: Re: [GIT PULL] printk for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608147894;
        bh=id7Tm1xfjL/+XXOdtgNSGXktTjxztRMjkbGem3By2hI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mVtOkKZ3q6BcNV11WOsevmC1rdIQRIJY/65GTsrugLFdTmnhccNT80FfI50KFnz/x
         os9pIh8DbI6WrFxdz2Z96QEf/IClYxJPcDvH6+T6BBXQw3V/jXBICiPKlFG5It01MB
         gROerJfQTcVScIxz9Z9UXjoeliFMhcTB2SzClN5mVplnm5HD3rwZbyL6UombUOnUVd
         QucmYc57nqLNEeFsP6wxhDyPV9siDHDqc96etCCe7Ie5KIR6wc/Mn0erNCVXuidyrR
         aB3U+e07hyQtRWje9b9QmxEXfOpChG+DArbHAgw5ErtZq9i4hUiuzbpukooEFYG+Oq
         ACxjvJ63PD+mA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X9eCSHnMZyJUt3FW@alley>
References: <X9eCSHnMZyJUt3FW@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X9eCSHnMZyJUt3FW@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.11
X-PR-Tracked-Commit-Id: 5ed37174e6c7e1ed4abfd0d8e932a3044441fb5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3eb52113d162cc88975fbd03c9e6f9cf2f8a771
Message-Id: <160814789396.14944.3724873154623955655.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 19:44:53 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 16:18:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3eb52113d162cc88975fbd03c9e6f9cf2f8a771

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
