Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41943234957
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 18:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbgGaQpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 12:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728898AbgGaQpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:45:07 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-8 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596213906;
        bh=LaIi1BSiais+SLlKpJ4mptmm+tkvapu4ni7O2++jyQA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FLFPhVzX+ZYUuB9eaCWkHXHtzk9CbFurFwB/jF06nV1lbfTm1oNOIXjiFM/txosWq
         V0kN14wUs+NJ1yaGL4Bm10UIla/NdrxnzWigBtjJphlQksTLsvR9Nrs0Xif18AchVT
         LI7q8Mt9h8N/upbX+9znoBg33zdkjYgfdJ6EAhtk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ime34yya.fsf@mpe.ellerman.id.au>
References: <87ime34yya.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ime34yya.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.8-8
X-PR-Tracked-Commit-Id: 909adfc66b9a1db21b5e8733e9ebfa6cd5135d74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: deacdb3e3979979016fcd0ffd518c320a62ad166
Message-Id: <159621390668.29129.4273158907807544036.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jul 2020 16:45:06 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 Jul 2020 23:05:17 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.8-8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/deacdb3e3979979016fcd0ffd518c320a62ad166

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
