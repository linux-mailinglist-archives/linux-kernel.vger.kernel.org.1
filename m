Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF4228D58B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 22:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgJMUoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 16:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgJMUoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 16:44:08 -0400
Subject: Re: [GIT PULL] x86/asm updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602621848;
        bh=F1LDYllFMaVnLcJCxyDYq/JiDfdD18BBp3SopEh27rM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uPiBZvdCQwZp0bpj21cekWh35cp3fhNOhmR++0JhUJATu8Df5aASIqYdYRcX0JM4p
         NDel+uhudGCl9MH63rgDhr2yHaTmHUCC8OabtBKNEXRzousQdMU6XY3gb/VXMjMCgi
         iZBee+ZIG3g/3hmaHkI5Y/ihh0b40VZpWBRUhx00=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012110557.GK25311@zn.tnic>
References: <20201012110557.GK25311@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012110557.GK25311@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_asm_for_v5.10
X-PR-Tracked-Commit-Id: aa5cacdc29d76a005cbbee018a47faa6e724dd2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 029f56db6ac248769f2c260bfaf3c3c0e23e904c
Message-Id: <160262184850.28380.14398269600502049034.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 20:44:08 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 13:05:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_asm_for_v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/029f56db6ac248769f2c260bfaf3c3c0e23e904c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
