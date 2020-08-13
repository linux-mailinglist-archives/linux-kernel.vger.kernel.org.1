Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68248243F77
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 21:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHMTrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 15:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgHMTrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:47:35 -0400
Subject: Re: [GIT PULL] exfat update for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597348054;
        bh=16mWNXwVL/YbxsR6AkPntgk1/Op6z6YurqX6k/PhO5w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KEKpR/nmIAHf/DsINeH8WmYBw3hKq1elNkRR6v0tKXQbdAEvJzGuPfGWO/AxHWpaI
         96RK8q0qsI75CQMoENBcH0gwGWlKTCztPDdobBbnSqqmReHpv+2XxDLFg37Ku2jieu
         BpZ94cm3FtFICMkIfiVnDh48XzvrW6/gmAosc3Nk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <000001d67111$0fc882f0$2f5988d0$@samsung.com>
References: <CGME20200813012834epcas1p2ca9a4e0f74353f7f3359a46b5acc5e39@epcas1p2.samsung.com> <000001d67111$0fc882f0$2f5988d0$@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <000001d67111$0fc882f0$2f5988d0$@samsung.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.9-rc1
X-PR-Tracked-Commit-Id: 7018ec68f08249de17cb131b324d5a48e89ed898
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff419b61fd66dab6ad223e044d1c3c54bb5cef6c
Message-Id: <159734805465.27850.18103735825276954010.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Aug 2020 19:47:34 +0000
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Aug 2020 10:28:34 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff419b61fd66dab6ad223e044d1c3c54bb5cef6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
