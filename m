Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9603B302F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 23:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbhAYWr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 17:47:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732773AbhAYWqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 17:46:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8ECF221E7;
        Mon, 25 Jan 2021 22:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1611614737;
        bh=YCaeAwfzY25KrbGYNz7RDomLYi8Q+7EPQfK8l7udhMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WJx98ur0n4TlQUVCNMFhPsP7M/XNiVJbGcCmbPbWK3DBXVDYt9vesfxTRU7O57njm
         bYl/670ukflbJM+CAJd1b+q4jj6XjfQqUCtGE8fz+yhy28Pg4R073R49y4XZ/uvMFG
         Vivz8g4LOITPnj1+gm1qw4qRkqn1DJVLP/LctPhU=
Date:   Mon, 25 Jan 2021 14:45:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>, glider@google.com,
        dvyukov@google.com, catalin.marinas@arm.com, will@kernel.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org, david@redhat.com
Subject: Re: [PATCH] kfence: fix implicit function declaration
Message-Id: <20210125144536.4544d9fca3b4cda8a6e42517@linux-foundation.org>
In-Reply-To: <X8otwahnmGQGLpge@elver.google.com>
References: <20201204121804.1532849-1-anders.roxell@linaro.org>
        <X8otwahnmGQGLpge@elver.google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 13:38:25 +0100 Marco Elver <elver@google.com> wrote:

> On Fri, Dec 04, 2020 at 01:18PM +0100, Anders Roxell wrote:
> > When building kfence the following error shows up:
> > 
> > In file included from mm/kfence/report.c:13:
> > arch/arm64/include/asm/kfence.h: In function ‘kfence_protect_page’:
> > arch/arm64/include/asm/kfence.h:12:2: error: implicit declaration of function ‘set_memory_valid’ [-Werror=implicit-function-declaration]
> >    12 |  set_memory_valid(addr, 1, !protect);
> >       |  ^~~~~~~~~~~~~~~~
> > 
> > Use the correct include both
> > f2b7c491916d ("set_memory: allow querying whether set_direct_map_*() is actually enabled")
> > and 4c4c75881536 ("arm64, kfence: enable KFENCE for ARM64") went in the
> 
> Note that -mm does not have stable commit hashes.
> 
> > same day via different trees.
> > 
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> 
> Ack, we need this patch somewhere but we should probably fix the patch
> that does the move, otherwise we'll have a build-broken kernel still.
> 
> > I got this build error in todays next-20201204.
> > Andrew, since both patches are in your -mm tree, I think this can be
> > folded into 4c4c75881536 ("arm64, kfence: enable KFENCE for ARM64")
> 
> I don't think that's the right way around. This would result in a
> build-broken commit point as well.
> 
> Looking at current -next, I see that "set_memory: allow querying whether
> set_direct_map_*() is actually enabled" is after "arm64, kfence: enable
> KFENCE for ARM64".
> 
> I think the patch that introduces set_memory.h for arm64 simply needs to
> squash in this patch (assuming the order is retained as-is in -mm).
> 

OK, I requeued this patch as
set_memory-allow-querying-whether-set_direct_map_-is-actually-enabled-fix.patch, part of Mike's secretmem patch series.
