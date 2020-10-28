Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21629D82A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbgJ1WaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733237AbgJ1WaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:30:08 -0400
Subject: Re: [GIT PULL] tracing, synthetic events: Replace buggy strcat() with
 seq_buf operations
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603924208;
        bh=Nmiw3GK3nD0EDAr4oHWj4CvtCEtFWx+EzHmRGEVMkc0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PVf/2+LdG2gMpsWVCLFUb9gzASsH7LBfbShac+yCv9tFWne0I5pM0VNpadcEmgaCk
         JODxYRunT+jvGyBsJUGO+kQB3/cBlU2oyj71uE4Z+C5IAvkkrRN13ajUBfQcYMwImJ
         taXg3ejJ+suZDKdpVdomO4GDtOOyK2DIUmVaJnbc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201028074735.67b2ccf4@oasis.local.home>
References: <20201028074735.67b2ccf4@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201028074735.67b2ccf4@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.10-rc1
X-PR-Tracked-Commit-Id: 761a8c58db6bc884994b28cd6d9707b467d680c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23859ae44402f4d935b9ee548135dd1e65e2cbf4
Message-Id: <160392420797.3598.17782423717511677349.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Oct 2020 22:30:07 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Oct 2020 07:47:35 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23859ae44402f4d935b9ee548135dd1e65e2cbf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
