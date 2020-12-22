Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3712E102B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgLVWZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:25:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbgLVWZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:25:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4F8E62312E;
        Tue, 22 Dec 2020 22:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608675865;
        bh=L+v7KsBpMe+X45wwGxsyBRz+we2itVL+HC6Ia+0nnLM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ua4imAIQ/OV5PF+7rxGj/5im95O/1I6UrO0IzP3RNrv2/btkJehPyJMmerK+viRKP
         49meuv+kIwpgd6EnlsCZXJglGmTSD2VmhJgnoUV2qjupJXGeW73IY1ps2yrHa1WgGi
         X7V2MyRfEdHx1UosZxQeZwIeSHMFOFMkHpueVqNhLtbaoClHsskiu0DBjgFmGwWvi/
         8tdSO55q7GtdAWCp/HVr8LqO1uJWBEH2IcF59wDPV8bt1fs277PyVYa7pOb9Ya6dcc
         IbPrnNA/dL+JHf+PCvSAujbb/wXoyMBmd7Eh2x0DezVVvAw+zQpHeC75Hiz2ZWkR8f
         2sFrvS3w746qw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 47C8B6019C;
        Tue, 22 Dec 2020 22:24:25 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 5.11-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <00ac01d6d82f$cb740850$625c18f0$@samsung.com>
References: <CGME20201222065804epcas1p4968e405d34b6c0ef755c55d3dae624c6@epcas1p4.samsung.com> <00ac01d6d82f$cb740850$625c18f0$@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <00ac01d6d82f$cb740850$625c18f0$@samsung.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.11-rc1
X-PR-Tracked-Commit-Id: 9eb78c25327548b905598975aa3ded4ef244b94a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9e541ecfee39745da042ff5194b0813bb4c3f9c
Message-Id: <160867586528.8550.7672301131391321827.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Dec 2020 22:24:25 +0000
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        'Sungjong Seo' <sj1557.seo@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 22 Dec 2020 15:58:04 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9e541ecfee39745da042ff5194b0813bb4c3f9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
