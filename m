Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69F2241496
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 03:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgHKBhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 21:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgHKBhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:37:33 -0400
Subject: Re: [GIT PULL] GFS2 changes for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597109852;
        bh=Yz5YP2XtdbTmxpXE0niL6xoeL8qZqqFnWA6Bxbp/1A4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=U3Xjq2hy1CBTYUskBc9ry5HlKjl3iAItjEuYPRbLWG0Bvd+SuJlMfXwUBNsHlPDhc
         ZofuJAMgO7/I6j/5PnP0KK2d/ot6gfMX85N+OCc6wzBG4l6GhdR4k+Ev2MNZrH1DKb
         ftFz8HmVcRkebxbyeJY6fASJoPsWvuvaX3tzHU0o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200810183634.617307-1-agruenba@redhat.com>
References: <20200810183634.617307-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200810183634.617307-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.9
X-PR-Tracked-Commit-Id: e28c02b94f9e039beeb5c75198caf6e17b66c520
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c2618a6d0f7b08e2b41575a87cf568745c8860e
Message-Id: <159710985283.12600.12795236097768733682.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Aug 2020 01:37:32 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Aug 2020 20:36:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c2618a6d0f7b08e2b41575a87cf568745c8860e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
