Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361C61BE457
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 18:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgD2QuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 12:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgD2QuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:50:13 -0400
Subject: Re: [GIT PULL] RISC-V Fixes for 5.7-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588179012;
        bh=bKg24XwkHVX8aJUuYcsRZeOlgw2+5m4GrK/bym9sLHA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YlFyoPp+RX4fOGy1hr+a/QAvZ0f8gO3XTSOgYIFrX5V7uVzT4FBv8RURML5DN07ZW
         4MMsuij/5Mv2Zl8xpqd9w/JgXqvxK09ORuK3jRTXxCHULnn4HnKPKBdpuqkUmhmzYX
         jetpRxCeVPySVoZwyiqmePZdpJ0oAdKZj7jlFJaE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-bd053cce-6f5a-40f4-9e58-a5ee70cc73a1@palmerdabbelt-glaptop1>
References: <mhng-bd053cce-6f5a-40f4-9e58-a5ee70cc73a1@palmerdabbelt-glaptop1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-bd053cce-6f5a-40f4-9e58-a5ee70cc73a1@palmerdabbelt-glaptop1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-linus-5.7-rc4
X-PR-Tracked-Commit-Id: a5fe13c7b49478c95e74f31f5b8b8347735684a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d2cc5ac6f6668cc15216d51051103c61467d7e8
Message-Id: <158817901265.22148.17660808942250838603.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Apr 2020 16:50:12 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Apr 2020 08:53:16 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d2cc5ac6f6668cc15216d51051103c61467d7e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
