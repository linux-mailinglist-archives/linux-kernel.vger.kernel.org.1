Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD50F2DDAF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgLQVoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 16:44:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbgLQVoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:44:54 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.11-1 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608241454;
        bh=yDaT+y9l9aimHmbslfpMN97U03h9cNNDggqbUiQNKdM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NuekjydNQHdI8Kh22vra0jetIyqGpz3oOxuZkIJWRj2km8Fo7w0Go3KEhEnSIZkNY
         OQUTkGH/4GNzm+8VJuQLEUCLuWehIu7cmSnIgst6AxFIsUBedwWO542rwy7vPou/gJ
         2B75oZUjrTXdMNPPkXzIePextDmbvx2lbvZahGlFihC/Z9ZmnZxm6wMt0Pp6ro/2mV
         w7of5cBA/qKV3U+YyW/snJ01MziMzidPwpLOvAu+NY/Se3I6gG1ygK29vePNXDifcx
         Eb8hy+oogjxFsNifl7WFkHlh26248FdY8fT5t5Yxm+8yUGGsaX3mm9lWRvhy8HYw0r
         QSIK4z6hy9l6g==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87r1noy325.fsf@mpe.ellerman.id.au>
References: <87r1noy325.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87r1noy325.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-1
X-PR-Tracked-Commit-Id: c1bea0a840ac75dca19bc6aa05575a33eb9fd058
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a5be36b9303ae167468d4f5e1b3c090b9981396
Message-Id: <160824145406.19561.14544299547675584528.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Dec 2020 21:44:14 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ego@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com,
        david@redhat.com, aik@ozlabs.ru, jniethe5@gmail.com,
        srikar@linux.vnet.ibm.com, bala24@linux.ibm.com, oohall@gmail.com,
        miaoqinglang@huawei.com, ardb@kernel.org, ajd@linux.ibm.com,
        leobras.c@gmail.com, maddy@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, vincent.stehle@laposte.net,
        tiwai@suse.de, ganeshgr@linux.ibm.com,
        u.kleine-koenig@pengutronix.de, harish@linux.ibm.com,
        longman@redhat.com, mathieu.desnoyers@efficios.com,
        nathanl@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        Kees Cook <keescook@chromium.org>, amodra@gmail.com,
        npiggin@gmail.com, oss@buserror.net, kaixuxia@tencent.com,
        clg@kaod.org, oleg@redhat.com, ldufour@linux.ibm.com,
        tangyouling@loongson.cn, po-hsu.lin@canonical.com, dja@axtens.net,
        atrajeev@linux.vnet.ibm.com, zhangxiaoxu5@huawei.com,
        linux-kernel@vger.kernel.org, tyreld@linux.ibm.com,
        fbarrat@linux.ibm.com, colin.king@canonical.com,
        linuxppc-dev@lists.ozlabs.org, morbo@google.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Dec 2020 00:28:34 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a5be36b9303ae167468d4f5e1b3c090b9981396

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
