Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15B01E9373
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 21:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgE3TfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 15:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbgE3TfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 15:35:02 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.7-6 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590867302;
        bh=ng4f9RxzP/Ig0BQgTaS6OyObrPJMyf+7HgLX1sLIp6Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dJJG5mseTFFXjgCcCtJ8ItTnyMqVDYOBIT/peUoA+St05YHa98ilcIXeQP7s5rjZa
         q/LaDV70AqIUxZREYUfhTXfZMjg8dGOaKusGvSeF0jACnxdSOJqHQvadwBa0vRg3Ml
         n1IGIX36cFeTKMXjrCIinoLhAUNuRYLR+fwzwBIg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87lfl9ikmp.fsf@mpe.ellerman.id.au>
References: <87lfl9ikmp.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87lfl9ikmp.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.7-6
X-PR-Tracked-Commit-Id: 2f26ed1764b42a8c40d9c48441c73a70d805decf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffeb595d84811dde16a28b33d8a7cf26d51d51b3
Message-Id: <159086730247.6123.12368301949308597060.pr-tracker-bot@kernel.org>
Date:   Sat, 30 May 2020 19:35:02 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, ajd@linux.ibm.com,
        dja@axtens.net, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 May 2020 00:05:02 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.7-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffeb595d84811dde16a28b33d8a7cf26d51d51b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
