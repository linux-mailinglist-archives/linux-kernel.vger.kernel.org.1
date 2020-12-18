Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2942DEA95
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 21:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgLRUzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 15:55:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgLRUzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 15:55:24 -0500
Subject: Re: [PULL] drm-next, part 2 + fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608324883;
        bh=rFgjNHcOzIJuLv9eomZVjZNNrmvZ0Y/cDPu3XzoiFD0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mZB/tZmFESEE1ap18MJlACsqeGAcGnJeL9Utwwbs+6RJCI/qpk/auYIWIk6qbJ+15
         0kN5MIMNZPOB/vRH0Yv9C6vG+QdLbV3RNzWz/b1Xaob1we2frMgN+7ijhk1n/cqi4R
         mltx74+q0Tpw558jB/yhO3IdP9qBN8CFePYaDlKySTHuJ/PFYJCTKhA1zgY58yUlKS
         L0TbFN+87Zc7LZ3zSxmK1JAp1pxAavSbjL1lPi8ZHnURyU4Qc6qHspII+AGzhaGiBC
         m5b35bYW8/a3AZuegS+I9FwW9FvrDz+6pBNyAvbS029oQcp0n1Eh0Rkva1epmKLjNb
         VZp8TyVgZt2vw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X9zdOXnqo6hzR5wu@phenom.ffwll.local>
References: <X9zdOXnqo6hzR5wu@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X9zdOXnqo6hzR5wu@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-12-18
X-PR-Tracked-Commit-Id: 4efd7faba5e0687ae9143b7e6a19547ede20a7dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c59c7588fc922e27c378a7e2a920b889bd6bf872
Message-Id: <160832488371.19372.4100865497261367725.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Dec 2020 20:54:43 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>, Linux MM <linux-mm@kvack.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Dec 2020 17:47:53 +0100:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-12-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c59c7588fc922e27c378a7e2a920b889bd6bf872

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
