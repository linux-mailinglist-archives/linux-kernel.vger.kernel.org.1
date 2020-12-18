Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC292DDCD6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 03:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbgLRCMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 21:12:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731747AbgLRCMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 21:12:35 -0500
Subject: Re: [GIT PULL] UML updates for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608257515;
        bh=4QBFm1gYFss7gclD+7+WtlXPDcXWiUEU2LMyOGZRm7Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I6Vz+7KNMSgebIcfM6KbX/ZGzFfVYWwYPMa5yW4r9m1CPmWSvOAaF0m19Db6NeWVD
         5bWDHbwC3vJuCBwIAYyo5mW3DfBtzM3KgOoJGK6lJz6TiInoOXy5ZKCnIIrwCPPdeh
         upmVsL0a/onOsdi9mdOAhjjLX51WFheI+xiG6POMIxxiMceMp9Yhowc1QilZ66IRek
         P8YxGpV7eZSVf1srejUdREzwpvehzMmvg2/M71LtyyXm4lbkx6TgFrEBm6IoEoKJir
         JVwwBz+00WL605SsWmKxTX3ZsMqROapKO1MK0drmg+xyucyN2FEWZWOq7b1CJMR5rv
         4c0M1yD/7ekMQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <841389660.140020.1608241463043.JavaMail.zimbra@nod.at>
References: <841389660.140020.1608241463043.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <841389660.140020.1608241463043.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.11-rc1
X-PR-Tracked-Commit-Id: 1fb1abc83636f5329c26cd29f0f19f3faeb697a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 345b17acb1aa7a443741d9220f66b30d5ddd7c39
Message-Id: <160825751511.20122.14390745699000245602.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Dec 2020 02:11:55 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Dec 2020 22:44:23 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/345b17acb1aa7a443741d9220f66b30d5ddd7c39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
