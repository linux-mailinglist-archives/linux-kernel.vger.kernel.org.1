Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8302CFE4E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 20:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgLETWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 14:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbgLETWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 14:22:17 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.10-5 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607196096;
        bh=6eyBkcMPMeqlM83jdEBCrZVIfNyg0S8EsBP2WDZLCZs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G4+DE28OPk3cylqUnozlGeypcjMv3H97I+cm1FMGOo3mV5/HioKTbkZTfObtjpBAP
         5ux/Iz8ZA6E7tLDuL5Tnk/+GJ/DCJOx7pZXoLofTrdEo7Z7rvCE2sCaGyATmHc7JxN
         EFsNozCWNSUDde4/Z+txgMtv4VIh/Sl22ht7ri3rQiIg5i8no6t0OvVwEvr0cG5AgY
         mFcuqsCBsz3z1wutIcCJs0sDCyEhr8VP8YXDDxd//dW68bZP3x70yHlWQHYSvMUzin
         y+v+5czEWEp0qir4N5o/SFVbXCyViMILrS6Pa+ieuC0G7rfBJdjbgWRH7abtW5ml3H
         nSb9QRdmp6fNw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87im9gtpge.fsf@mpe.ellerman.id.au>
References: <87im9gtpge.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87im9gtpge.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.10-5
X-PR-Tracked-Commit-Id: a1ee28117077c3bf24e5ab6324c835eaab629c45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32f741b02f1a84dd15cdaf74ea3c8d724f812318
Message-Id: <160719609666.18711.2227466213357171756.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Dec 2020 19:21:36 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        srikar@linux.vnet.ibm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mahesh@linux.ibm.com,
        npiggin@gmail.com, groug@kaod.org, linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 05 Dec 2020 23:19:45 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.10-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32f741b02f1a84dd15cdaf74ea3c8d724f812318

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
