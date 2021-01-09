Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0872F033F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 20:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbhAITv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 14:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbhAITv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 14:51:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E892323A82;
        Sat,  9 Jan 2021 19:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610221875;
        bh=btM3J9huZ052q08sCMPUU5gRld5Te7kDevMc99iHFMM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X8aZJ2lnWgCUCY/gWfROOi+zSELn2mdmap4DenNC3wKe4/+QAq8OSlR+ymKoZ1Pnb
         9AuT5op9EfzG3UoQAW7h7tF9rnnRIUpVTr1ha9kItd5qJvWqN9czyBXIB02qGbdfBw
         AKzVyIM/7c9F5Ficsij9YyafPEBgT5e+6hbhuhcG4IuZqOqJXtPdbo+ne4ZidIz9PK
         X3FDwxiJzzpK6aDgMd4KgKRKqUARbg0crh25Zd1ZptuppDrm1C4ISRXxF+XgDzz/zy
         33o8Exq3EG//U1BxFoR6I+QbarnXhCZLEhAGCK0/QuTstOZxJohLiyL4KKWqrnTReQ
         PabvvXn/peOdQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id E4FA760508;
        Sat,  9 Jan 2021 19:51:15 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210109090124.GY2771@vkoul-mobl>
References: <20210109090124.GY2771@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210109090124.GY2771@vkoul-mobl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.11
X-PR-Tracked-Commit-Id: e1263f9277bad198c2acc8092a41aea1edbea0e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f408126be7dc642102224cdb55d6533519a67c19
Message-Id: <161022187592.8002.2318989684021687150.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Jan 2021 19:51:15 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Jan 2021 14:31:24 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f408126be7dc642102224cdb55d6533519a67c19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
