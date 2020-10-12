Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C796828BF9F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391385AbgJLSWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390876AbgJLSVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:04 -0400
Subject: Re: [GIT PULL] x86/cpu updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526864;
        bh=/TPzf2PA07afYBMpi9tPrxh7Y2pHV/cHQbl5TRXLSLE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Lsv7t+O9l+FnrvG3OVf6/9LW0316ri3VRXf2uXqtDmR0s08M6iDZOFj3c54badR9R
         kd1dl58J3ZtMacp6/EyFjRBhPPBLBV71tS2I/gJ1Rrdaa+v2XgsFKwvpCWf+IlMo3G
         kvNtnnHs9DYqEY0wgMffqA2wgODR5qdYt9CY5TdQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012095756.GC25311@zn.tnic>
References: <20201012095756.GC25311@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012095756.GC25311@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.10
X-PR-Tracked-Commit-Id: e1ebb2b49048c4767cfa0d8466f9c701e549fa5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92a0610b6acd3bfdc977b612853ba6711447e887
Message-Id: <160252686447.3643.11909134581740203675.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:04 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 11:57:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92a0610b6acd3bfdc977b612853ba6711447e887

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
