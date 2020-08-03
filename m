Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4D723AFA1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 23:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgHCVZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 17:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgHCVZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:25:04 -0400
Subject: Re: [GIT PULL] m68k updates for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596489904;
        bh=rzcF+Z/MiwV25HBEJOEPs1esfo8Iq7rlrL15bRK7JUM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fehVNMCxrVlquFy+mtBj53kbHIpDKgWhNlUJYB0L3zj4Cn5UQAAklYqtaxqiLrcxf
         DoH7h3cf685f+yKdGi7KnESyBpUB8VXQ3jH1YiWQ+D/1rnQ6TihUw07glPMk9kILYx
         l/rRB9G87gkQ7AzAYOi35IB5L+iw9E3ELUw33zPU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803113004.10098-1-geert@linux-m68k.org>
References: <20200803113004.10098-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803113004.10098-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
 tags/m68k-for-v5.9-tag1
X-PR-Tracked-Commit-Id: 382f429bb559fe991b1ece2e5e58c812e28b3ad8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c4e1c027ae63c67c523d695e4e8565ff78af1ba
Message-Id: <159648990427.7765.17159688440444568581.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 21:25:04 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  3 Aug 2020 13:30:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.9-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c4e1c027ae63c67c523d695e4e8565ff78af1ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
