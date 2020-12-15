Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC8D2DA511
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 01:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgLOAul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 19:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgLOAuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 19:50:25 -0500
Subject: Re: [GIT PULL] m68k updates for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607993385;
        bh=6+Rw+qjzbahoRiX3dc+7SKTSmk+CqpJg1igXjG2nfIA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MOBENHyOFPUtsYz+R4FkbWgJ+xKljmtjkyCdyg3VyXk7+4zGDjx5BywjV7o7rYQk5
         Sd3iwUXIkopXHYpYLkcKlJmmggDOv/xWUSLN5OA0yYIJQmU1fSAobmVmD8FI1P/Dme
         SXNTz47DmSdyao7GSFptaRSG11lMbwZ4GWc6NJsBBwznTPElcx0uvvosE9rkhkADwz
         WtdJzirDkJmWqv553zAjEwKXIUeKLYqA2MdzGShKjaCOV0ss42Z5eyiwxqIrNb0A62
         33aUAPRRjlFxoSw4sHl0nyRDMQr8j/SrY39Xnv8P3tgBb+b0fN9GiZVSEiAiIMjW5j
         PtvHXPDshmeJw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214093237.824639-1-geert@linux-m68k.org>
References: <20201214093237.824639-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214093237.824639-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.11-tag1
X-PR-Tracked-Commit-Id: 2ae92e8b9b7eb042ccb7e9fc7ea9431f211a1bd3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b03beface02d519693edb8020f9811c67d5c88f
Message-Id: <160799338494.8612.16925069399567596094.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 00:49:44 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 10:32:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.11-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b03beface02d519693edb8020f9811c67d5c88f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
