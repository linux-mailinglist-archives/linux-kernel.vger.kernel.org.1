Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC5F28E908
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 01:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbgJNXCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 19:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730991AbgJNXCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 19:02:14 -0400
Subject: Re: [GIT PULL] Devicetree updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602716533;
        bh=GzhuZjhmlGjjIsxQPtT+zNJkmPR3avhhAFcQEBb3NiY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NqbQmqq1VIgox20SkKZoY9oZ+WnBM/P9zrua7BeUceZsaFaD+QVylX9L31YtN3OpH
         n/uMORr/6dyYO/dQb4LSubfSWicvDQjYTjN9iR/LxPxoNT575F7DGSaCYsdZedPNuD
         00x2A40q8PCBv/tzeuEfskQGGP+2CxlaDSwKk6Vg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201014155304.GA1778149@bogus>
References: <20201014155304.GA1778149@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201014155304.GA1778149@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.10
X-PR-Tracked-Commit-Id: bd36e51d10e7c2b7d39ffa7d075aed98a8e7473c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f888bdf9823c85fe945c4eb3ba353f749dec3856
Message-Id: <160271653351.18101.3576475241040276818.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 23:02:13 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Oct 2020 10:53:04 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f888bdf9823c85fe945c4eb3ba353f749dec3856

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
