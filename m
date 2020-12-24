Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F292E2903
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 23:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgLXWQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 17:16:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbgLXWQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 17:16:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6A5DF22AED;
        Thu, 24 Dec 2020 22:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608848121;
        bh=bmrbazNAIQiM2MBU0jn7uXzJEYjY8yaIYolkmDM5W0A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=muHBwhEW52WM6L7wPtg721TPFJPhbH2N8pdBSKRHVhTYmbnug+z3Au1ceW1M7kDkJ
         pZ6b8Fcs2UZUyWaXtHs+6lOS6VGDlggkZ9BV0WNnWY/4fMIgxB+heMVlHXw36x1gpS
         C12LX7WB7bKpuGpU9IsJRNzWanHcsCqx5agrWTB82hNhEgZpapHHQbr19MgjRJrP2F
         iT76KnClV+OXKXXtGHj8mkn5ObcffE7rpeeMYdc8s0fE5RAym6cuclifvkZyHu+Vg1
         /kLgyjlDj9K3XJ2oH8pUb4PNP6TBEdV/Omga5W6/OGab0Uh19fNcYl0vvCWL88emwL
         ZwVRYRO4x7b+w==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 6351B604E9;
        Thu, 24 Dec 2020 22:15:21 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 5.11-rc1 (or rc2, if it's too late)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-ab52db2e-d084-4a51-b804-ae41d45ca8db@palmerdabbelt-glaptop>
References: <mhng-ab52db2e-d084-4a51-b804-ae41d45ca8db@palmerdabbelt-glaptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-ab52db2e-d084-4a51-b804-ae41d45ca8db@palmerdabbelt-glaptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc1
X-PR-Tracked-Commit-Id: de043da0b9e71147ca610ed542d34858aadfc61c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a2fde8def1fffceda728d2441d7e69230478285
Message-Id: <160884812139.9963.14494696534917649175.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Dec 2020 22:15:21 +0000
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Dec 2020 20:24:05 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a2fde8def1fffceda728d2441d7e69230478285

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
