Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FB82DDCD3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 03:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbgLRCMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 21:12:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgLRCMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 21:12:13 -0500
Subject: Re: [GIT PULL] JFFS2, UBI and UBIFS updates for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608257492;
        bh=fw8CwVpgt0SmsOPzGYM9kYpW3UPnT7Hx6sUGTYL+7aY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KKTSDA0fFVpf8fBmyg03Qyzj/vCktFFfqeOzdJnkRqTuNf7rnaZPdJAs/Oouvvoz6
         sRp1zGkT1oHnhZeiNf+KVeGKgbj/9Dhx7l9iujiPQfh0i38WDfCk0aWtXzla+EdEgE
         wOh+VjZgY7y7e+tqV2o5I0o8mcr22jKvDaEXK9FyyxQXZ48opLd6Hl2wZeAyeEmrWo
         0eIdG3gMG1EebKuvfDg9WHmBzkkVjYSOi/MesuCu09zs7GnjFb5MjgkFoVoXMSNiy7
         39BcgR3njrIpvjuzIjAlAP8KDHAvzszqlbrLw20jCzDoZNVSq6QJ5PP73rsw3GXILk
         UoeCmRYtRXJNg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2026739641.140019.1608241461469.JavaMail.zimbra@nod.at>
References: <2026739641.140019.1608241461469.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <2026739641.140019.1608241461469.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.11-rc1
X-PR-Tracked-Commit-Id: b80a974b8c58164ed57b0f025a47b8f003198d9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 787fec8ac15cc693b9a7bc1b4a338b92483d993c
Message-Id: <160825749249.20122.13883608308717904000.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Dec 2020 02:11:32 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Dec 2020 22:44:21 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/787fec8ac15cc693b9a7bc1b4a338b92483d993c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
