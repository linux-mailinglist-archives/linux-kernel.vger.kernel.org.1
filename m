Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3121A5F94
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 19:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgDLRfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 13:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgDLRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 13:35:06 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB45BC0A88B7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 10:25:26 -0700 (PDT)
Subject: Re: [GIT pull] locking/urgent for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586712326;
        bh=ZzsZwplRj9mrmKC8NPcjAdaElXdEaLsi4VaYef4gkb4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=q5o/jokrtOkszCGohnophvBc/z9T4MhHhE+x13uxKLT8ddbldrq1C70Ds73fqDUHe
         QRpTTOxEVmioealUEQwByHmEYs3m5Slo2AMO6lf5D7VWILy3mnZSbjoxfs315/oGZx
         PxHtvmzdtgg/FwQ94k2PjyWOSnYzaM26NfM46M1o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158670111777.20085.1305752188791047060.tglx@nanos.tec.linutronix.de>
References: <158670111777.20085.1305752188791047060.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158670111777.20085.1305752188791047060.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-2020-04-12
X-PR-Tracked-Commit-Id: 9a019db0b6bebc84d6b64636faf73ed6d64cd4bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 652fa53caa01dbfdef1b8c5997767e284ac21a5c
Message-Id: <158671232650.12917.2954757524360252047.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Apr 2020 17:25:26 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Apr 2020 14:18:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-04-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/652fa53caa01dbfdef1b8c5997767e284ac21a5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
