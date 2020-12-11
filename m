Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0A72D6CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbgLKAk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 19:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389244AbgLKAkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 19:40:46 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.10-6 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607647206;
        bh=sOEfvadm1MFJBkWahDkvvu0eQu9e4044ek0+X0D9/58=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L4cL4IEnJGh3jdEhys1vpmJ4oc1Izhb91A8z5ypQaR0MyU4rE95YbKK2ZiohRB1FG
         hH0effp63qYZ3c2z/+jvuf5KHmciBZ8FuQ7MyJV0j+YkCF+sACQmgQnxG1qWVbjaUU
         zzfzmMdOCwK919YmIuVB8ee0RwGMsRL7Xao2Wog55h9FLBHTntJYnUEce+rGpKpaDB
         K1a82Iqp6ZGC3p67kzFK7EnAJZ6tt4b5tFzJma63yUS0+o0E6NxxNQnuicNuQbxKKO
         yepy6TKe+aRGOYBfqrq1pMguGVZ1YR+IqtacrE24Iudy7Kmoy+dsArCBm/1cJD5X7b
         1rGAUfkks0Vvw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878sa5rxx4.fsf@mpe.ellerman.id.au>
References: <878sa5rxx4.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878sa5rxx4.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.10-6
X-PR-Tracked-Commit-Id: 5eedf9fe8db23313df104576845cec5f481b9b60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47003b9971cc7c38737f21e07034502ca35ab7af
Message-Id: <160764720624.1595.7316604659116143322.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Dec 2020 00:40:06 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Dec 2020 11:25:43 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.10-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47003b9971cc7c38737f21e07034502ca35ab7af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
