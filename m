Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AD721C5BD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 20:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgGKSZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 14:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbgGKSZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 14:25:03 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-6 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594491903;
        bh=oYGvCW3yUBOS6t24P0LEztiJ6EUnBWqM3dyRFnrIBMg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m5px95qyOoXIxZgQ4L3qj8JD+Wsx0KtjxH3JEz7eAEk7EfNGUAUB15p0hEkQKIjvm
         mT9wLMo/3659OgPDe6dsF0aIh/qWIjsyotnfVW4RmyyjG25bN656htHDXhc3MPzYmR
         qsPAyoX2N7+k/fMJMs74WiTHwv+o4bBUA+Sc3Wio=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87v9iuuv7n.fsf@mpe.ellerman.id.au>
References: <87v9iuuv7n.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87v9iuuv7n.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.8-6
X-PR-Tracked-Commit-Id: 4557ac6b344b8cdf948ff8b007e8e1de34832f2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 997c4431f04d8f0d6063bac3bcdceba8d939b879
Message-Id: <159449190315.25373.16727566755171701075.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Jul 2020 18:25:03 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Jul 2020 21:50:20 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.8-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/997c4431f04d8f0d6063bac3bcdceba8d939b879

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
