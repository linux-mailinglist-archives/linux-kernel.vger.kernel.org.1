Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A62E2E69E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 19:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgL1SAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 13:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgL1SAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 13:00:36 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC4FC061793
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:59:55 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id hk16so33027pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=to42pGGVOJ+ZHbSQnvMl6SbDZ48NqHf36EwZEcYqevY=;
        b=u/MC5Xc0Z319Tg13jvXwiqOVjUrdO41IgE0fz8EtUKap+NSp9QjcORGaG6hYBnB48f
         n/+bdQ5yok3UIFJEqc8z1O5PB5dQJR7ab756CETj5r37CsLwYh7SeAhxOL9yZGhUZhnY
         /eWImF/dKkmDtOQxEq/cg0Dk16FnzpeNwTEcxfOd9Vvl2OKT6xxbGoN9Hou+TNXBUtQW
         mNi/c8paNDX0uMtNOAMk9cRXRZB+8BKeQ5NK+R1OxM1AByfU39c3HFS8TUdIwwazJjIZ
         d9WuA10IMkiGK95/VutWFaZ7j5IHg1WlmrTz1Zr01jee2wPxspUKlFB4Qxth0a5N3CmY
         vJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=to42pGGVOJ+ZHbSQnvMl6SbDZ48NqHf36EwZEcYqevY=;
        b=f52EABnkwR+6xpJ5BCp2MydV4o3x3RBagcO2UdOs8Jgn4nx32/Ytqogt2WvS/ijNND
         lxWlsRGsvkShf2qVJm+Vp20H0OPlm1ey2butljuPF8QfRFEgpHOO/vvHGkdlye56PUuN
         kd2J8PPZVgCvR0RV6I4rh+Ko4XY03+GDWjkSJYERxorJBHRUY65Otv1dVX2Bak1Arels
         Xe+2P0CD6tuVDoWzjK86MSlKg+6nWDnfb2iV/zPlSBXOlf/5qlO5XOGLW1kbNxgbbXXU
         M9HV07lBZQEVQr6JUe6kRBm8hM/YLi32C1MMrbDj9oCP90FHWz7yyohZYCaKvHCyGkOu
         o/VA==
X-Gm-Message-State: AOAM533BEkW38m4GEKM2vn8Nsl+qXIJKYJnFFQ7NVA2MCod/v83Q02So
        qikK3JYAqg4fJT8tp4SU+yE+e19OyUMeew==
X-Google-Smtp-Source: ABdhPJwSU2aXUdixhzC/IzdBZB18qzOYudMZOhNlFvmPKRc2ngmmUw4sKd5W7cbVMIaiVG3sEN2klw==
X-Received: by 2002:a17:902:443:b029:dc:1aa4:28f0 with SMTP id 61-20020a1709020443b02900dc1aa428f0mr46428293ple.4.1609178395329;
        Mon, 28 Dec 2020 09:59:55 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id m13sm35660200pff.21.2020.12.28.09.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 09:59:54 -0800 (PST)
Date:   Mon, 28 Dec 2020 09:59:48 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Add blurb about
 backtraces in commit messages
Message-ID: <X+odFBu+smuDiOcO@google.com>
References: <20201217183756.GE23634@zn.tnic>
 <20201221095425.6da68163@lwn.net>
 <20201222130555.GA13463@zn.tnic>
 <X+JCCqTJkgZASj7T@google.com>
 <20201222192517.GE13463@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222192517.GE13463@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020, Borislav Petkov wrote:
> On Tue, Dec 22, 2020 at 10:59:22AM -0800, Sean Christopherson wrote:
> > On Tue, Dec 22, 2020, Borislav Petkov wrote:
> > > +Backtraces help document the call chain leading to a problem. However,
> > > +not all backtraces are helpful. For example, early boot call chains are
> > > +unique and obvious.
> > 
> > I'd argue that there is still value in the backtrace though, e.g. I find them
> > very helpful when doing git archaeology.  A backtrace is an easily recognizable
> > signature (don't have to read a bunch of text to understand there was a splat of
> > some kind), and the call stack is often helpful even if it is unique, e.g. for
> > unfamiliar code (including early boot chains) and/or code that is substantially
> > different from the current upstream.
> 
> I think the intent of the text is to say not to include callchains which
> are *really* obvious. As in, there's no ambiguity as to how one has
> landed here.
> 
> Also, sometimes people paste backtraces from a WARN* which are almost
> always superfluous - only the warn's address is important. This is at
> least how I go about debugging those.

Obvious and superfluous for people that are intimately familiar with the code,
but explicit call stacks are extremely helpful when (re)learning code.  Using
the boot code as an example, until one fully understands all the function
pointer shenanigans for the real mode trampoline, initial_code, CPU HP, etc...,
even 100% unambiguous call chains may not be immediately obvious.  IMO, a few
"unnecessary" lines in the changelog is a worthwhile tradeoff if it's helpful to
even one person, now or in the future.

> Maybe the text should be made more precise.
> 
> > I'd prefer not to encourage people to strip the info after the function name,
> > though I do agree it's somewhat distracting (especially the offset/size).
> 
> Yes. Especially since they don't make any sense on another system or
> even on the same system but with a different .config.
>
> > The module, call site in the function, exact file/line if available,
> > etc... provides context that I find helpful for building a mental
> > model of what went wrong.
> 
> File/line is more useful, yes, but only for the current code snapshot.
> When time passes and stuff gets changed, those file/line things are not
> correct anymore so one would have to checkout the tree on which the
> splat happened.

I don't think that's a reason to encourage stripping that info though, e.g. I'll
often checkout the relevant tree when I'm deep down the blame rabbithole.
Similar to my above argument regarding call stacks, the cost of including the
may-be-stale file/line info is outweighed by the potential benefits for readers
and/or future archaeologists.

> I guess I need to make that aspect more precise too.
