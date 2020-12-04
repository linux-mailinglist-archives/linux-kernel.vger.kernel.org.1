Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02C42CF324
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgLDRcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:32:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgLDRcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:32:22 -0500
Subject: Re: [git pull] drm fixes for 5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607103101;
        bh=kdIV6qg0v0kiZPoBanSMJB+t0VBdncQDDFz02bw9yK8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JSFb9xWqy01RN7dA8kaAN3HFhqAPi3zNGSICcVJ/bifokveYcv6fib3PJDmEsTEv1
         MGilnBByafrBp+o3c/C7tpWsjLqrKhLRdaQoJHy0DRYgQgpOQutMmjDpBURgCQE6WC
         Jare1SBF9wcMctg6hQICGPyX+WWN4+2A/lGPt+yDIIkwb5FPmhTtN5pQbCT3u9y37k
         hQ/HgjYH1gZmIYsw6Y4iyHytwB2wKOSluUZ2fIP0ZzZpDxHn4vjcgO181/dVw+Dttq
         zgODtaACfUADboSpuaS4d+gjzNhj+IZsb8H9onDh0QHKNpAb69f+03RHtlH3oVfiBq
         aYHbsZiO45AMA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twdEoUbczSb9v0vAFD7w1qfB8-89tP-xjAEq5P=uBezCw@mail.gmail.com>
References: <CAPM=9twdEoUbczSb9v0vAFD7w1qfB8-89tP-xjAEq5P=uBezCw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twdEoUbczSb9v0vAFD7w1qfB8-89tP-xjAEq5P=uBezCw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-12-04
X-PR-Tracked-Commit-Id: de9b485d1dc993f1fb579b5d15a8176284627f4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e87297fa080a7ed6b431873c771b3801cab573f5
Message-Id: <160710310160.1431.7995360012238947510.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Dec 2020 17:31:41 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Dec 2020 12:25:35 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-12-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e87297fa080a7ed6b431873c771b3801cab573f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
