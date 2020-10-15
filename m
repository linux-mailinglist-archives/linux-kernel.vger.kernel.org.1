Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D48728F7E6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgJOR4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgJOR4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:56:14 -0400
Subject: Re: [git pull] drm next pull for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602784574;
        bh=zpYP0y+N0AmWkcDFA4cNMNIMCTnvhZfotWi7K9kXgYM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uVMRmc4kTCYIZtNUbdPq33bcU0no/fB8I1JWfS1PIcLbBnq/iKkVajHTtpjdsIrha
         fEalTXPGbHYluzDaSoztoDmaCc4oTTqS/TSrNa+uoJvS/GN9OkpFTKl5ObP3Nb+546
         GJh5ntZDBjXHPby5BmmCj59xxr853c240mKlU/N4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-10-15
X-PR-Tracked-Commit-Id: 640eee067d9aae0bb98d8706001976ff1affaf00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93b694d096cc10994c817730d4d50288f9ae3d66
Message-Id: <160278457423.2336.16076988857270497801.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 17:56:14 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 11:33:08 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-10-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93b694d096cc10994c817730d4d50288f9ae3d66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
