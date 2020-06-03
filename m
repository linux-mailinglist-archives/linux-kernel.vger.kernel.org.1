Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6FA1EC7F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 05:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgFCDuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 23:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgFCDuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:50:11 -0400
Subject: Re: [GIT PULL] JFS fix for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591156210;
        bh=YegEQP6qj9Vlub60a8t9aZljVdBvzmx+glkc3E0v2io=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yoNzSfdLEJj55DdJtQj3WCLLu9yy28lsdpTvEegSrLARr30Dg7HIlCHAo2rsaRnQZ
         ZStWlNYIH9EtSw7h07MR/aGdNbp2cjgvbMw+MiXFDi22qDcVaIfSLZ+OpDcpOC3wE7
         Zjs5SXMJ8d1f8b5QZoZ86DrTBXKoDi3EJYbvIU5I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3be89f81-68af-3520-56f6-f4a34b823a38@oracle.com>
References: <3be89f81-68af-3520-56f6-f4a34b823a38@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3be89f81-68af-3520-56f6-f4a34b823a38@oracle.com>
X-PR-Tracked-Remote: git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.8
X-PR-Tracked-Commit-Id: 7aba5dcc234635b44b2781dbc268048cfba388ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cadf32234b6f6dd96a0892bf915e3ee8c438cf07
Message-Id: <159115621062.30123.17117180689561684595.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 03:50:10 +0000
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Jun 2020 10:22:02 -0500:

> git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cadf32234b6f6dd96a0892bf915e3ee8c438cf07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
