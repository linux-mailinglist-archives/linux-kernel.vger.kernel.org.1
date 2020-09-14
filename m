Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A8D268B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgINMmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgINMhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:37:12 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BF8C061352
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:37:12 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a12so17364563eds.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w96GNiyWqug9hy/q6WUukVDjU2hTwIhreDsYM9bYsO4=;
        b=XF6MpACCNZ8VeLazppUefQsSFQQx21vZiHlOr8qLLvNfvxafRU/C4srGv6aw5vuu4+
         MjDDrEMMVv+1xLqcBLR1MvnD2mTT7YP+YR/bUTGRf0AkfKE0LFgQUNkwKV3HS5jtslzC
         Dinb/CJFYQXrAufFqsU3JHWTxQtOOTY1A4vYC8U65+zP3v+M2jn5oF7R7ef2UD/H6yDJ
         PTEykxDEJ6c/wavCPyeamUB3aN8rjXg4ItCDkxWHVRNgwkoNCka15myMFzwBsXYdbrhh
         EHusW0PVtMEdNMDrCHaURAjRaRwuBnlMxPk/ZH9sUhj0H3CWDgcxM23PrzOEjB52Ugwf
         +C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=w96GNiyWqug9hy/q6WUukVDjU2hTwIhreDsYM9bYsO4=;
        b=AHVHJWzzqATnv01haHmMqS8k+7idXXCFY9HTeau+/M4lciJ1u5pTBd5ifSACTN/dZy
         OfonyW62e7P/GFkX6CPpSh0YwzqY3kY/Q6yQLextx+xGLc0+Ih3ab4k2sq6QzhsbayxC
         7mTBHjOgSyIrG4SjzrYMyYMvo9flGBKrOxeqdU2dM+TZPXAwEcEwyg93WGlH6IrpGp+I
         TrmTSKPh6qeq1IIwdy5JexTGESYuXEm/L+kRivVGk5nQzvey6vXsE8d+qHJb8wqnQS0s
         EGNW4bQCJB541uIswNV5k4AXDEEnrgU66yaxe/THk+kNbG5GQP8mB6zBJ7pAe8QPp8Wm
         +Vbg==
X-Gm-Message-State: AOAM532t9sY3pjgyvIQDRHKPtB5hbwHUsQ2ImhrSKVug/yrUMmrhp40o
        jZ05RGbLUJ+KcdC5KMOK1jLZ3Brjvcs=
X-Google-Smtp-Source: ABdhPJwcXhdxeYD/WOSgpvYilAfrsyXX/sMKZD8EmdymNIRN4jXJaVAdNXpcdjSUxGjCTxmKYZaFuA==
X-Received: by 2002:aa7:d606:: with SMTP id c6mr17287894edr.370.1600087030727;
        Mon, 14 Sep 2020 05:37:10 -0700 (PDT)
Received: from gmail.com (5400A980.dsl.pool.telekom.hu. [84.0.169.128])
        by smtp.gmail.com with ESMTPSA id q23sm3432898edw.41.2020.09.14.05.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 05:37:10 -0700 (PDT)
Date:   Mon, 14 Sep 2020 14:37:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] kbuild: Run syncconfig with -s
Message-ID: <20200914123708.GA603584@gmail.com>
References: <20200820063526.GA3278096@gmail.com>
 <CAK7LNATs3qEjTE-=FWP9Srf3Ys30T7h+PL6MLgHoBPxJLSx4VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATs3qEjTE-=FWP9Srf3Ys30T7h+PL6MLgHoBPxJLSx4VA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masahiro Yamada <masahiroy@kernel.org> wrote:

> On Thu, Aug 20, 2020 at 3:35 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > On every kernel build that runs --syncconfig, there's an output of the following line:
> >
> >   scripts/kconfig/conf  --syncconfig Kconfig
> >
> > This is the only non-platform build message the kbuild system emits that isn't
> > prefixed by at least a space, or is a build warning.
> >
> > Run it under -s - if there's any problem it will emit messages anyway.
> >
> > With this change the following simple grep filter will show all build warnings
> > and errors of a kernel build:
> >
> >    make | grep -v '^ '
> 
> 
> 
> I do want to see something when syncconfig is invoked.
> 
> I will apply this instead:
> https://patchwork.kernel.org/patch/11727445/

BTW., there's another, rather spurious bug I recently triggered in kbuild.

Occasionally when I Ctrl-C a kernel build on a system with a lot of CPUs, 
the .o.cmd file gets corrupted:

  mm/.pgtable-generic.o.cmd:5: *** unterminated call to function 'wildcard': missing ')'.  Stop.
  make: *** [Makefile:1788: mm] Error 2
  make: *** Waiting for unfinished jobs....

The .o.cmd file is half-finished:

    $(wildcard include/config/shmem.h) \
    $(wildcard include/config/hugetlb/page.h) \
    $(wildcard include/config/zone/device.h) \
    $(wildcard include/config/dev/pagemap/ops.h) \
    $(wildcard include/config/device/private.h) \
    $(wildcard include/config/pci/p2pdma.h) \
    $(wildcard include/config/sparsemem.h) \
    $(wildcard include/config/sparsemem/vmemmap.h) \
    $(wildcard include/config/numa/balancing.h) \
    $(wildcard i
    [premature EOF]

Instead of the regular rules that end in:

    $(wildcard include/config/memory/hotplug/sparse.h) \

    mm/pgtable-generic.o: $(deps_mm/pgtable-generic.o)

    $(deps_mm/pgtable-generic.o):
    [regular EOF]

Manually removing the corrupted .o.cmd dot file solves the bug.

There's no reproducer other than Ctrl-C-ing large build jobs a couple of times.

Thanks,

	Ingo
