Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CCF2E322D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 18:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgL0R22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 12:28:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgL0R20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 12:28:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 011912255F;
        Sun, 27 Dec 2020 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609090027;
        bh=fgJ5BMphikLk9OEiGYCwqNSs6AiAw2yuNZpGm23NDbQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kohpFiyPyQ/Z+fhkmEb2bSfTMBGXLklB7eYToz57yq8LMDo+jUKS1+nuNncTuMKNK
         cCYy9ohjIZf57LA2aEKvY8X9eIAhlbh8HQPGc5DmAQc8cXMo0xuWAAY0NbKa+VkI+U
         RaDDIgUh1N+/4Vv4hl3HZ0wMxb5RGzWMFL/XQq79JUbr1r8JNOZTNIMh3/bz+diBx+
         ntUSEPWHGXL0CtY+q5k1ntPyHbN7C6ZOMIBlsOx13YMJQ1pB0e+dxxL++8ti7AqCva
         T3aGBnFQiHV73CtheKu72N5XIuL54yk8zUU4ZHki4pIod1XyCV0X42IKEAppyhojNQ
         y9Bu/U3GrJ+JQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id EFE4C600D9;
        Sun, 27 Dec 2020 17:27:06 +0000 (UTC)
Subject: Re: [GIT PULL] NTB bug fixes for v5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201227141638.GA11393@athena.kudzu.us>
References: <20201227141638.GA11393@athena.kudzu.us>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201227141638.GA11393@athena.kudzu.us>
X-PR-Tracked-Remote: git://github.com/jonmason/ntb tags/ntb-5.11
X-PR-Tracked-Commit-Id: 75b6f6487cedd0e4c8e07d68b68b8f85cd352bfe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52cd5f9c22eeef26d05f9d9338ba4eb38f14dd3a
Message-Id: <160909002697.19416.15922891293514853862.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Dec 2020 17:27:06 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Dec 2020 09:16:38 -0500:

> git://github.com/jonmason/ntb tags/ntb-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52cd5f9c22eeef26d05f9d9338ba4eb38f14dd3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
