Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C4A1B797C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 17:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgDXPYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 11:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726717AbgDXPYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:24:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38707C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:24:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d17so4793089pgo.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E79cAaOa1jAIKhm0eolCD7xppP0uJP83S6lzC3NSZOM=;
        b=eKG3Hdym6dX90IJpRfeNbZD8YzKxLoNBu2/h/DqaezP+VwDgYrP5R3MNcJFeeEziJ9
         pbkD/KmG+XohqARa9H4E7MJgMbbRakOiUvsmukaooDORSQDMBELfBtf2eb/MzIqLaV1l
         w3andTI7sxJFmh76itc+2YmgOdGpAVx/dXwAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E79cAaOa1jAIKhm0eolCD7xppP0uJP83S6lzC3NSZOM=;
        b=Np5LG8KTzKXIuvwHyuRXcmw0jpbnhAQdVmIWXeMgUnmwykCp6NWhux1uHuOntP10D4
         ZZtzrKXTZSlf5LjHm2jzsfOUB4AJNawLiYcolYe078l/aL25pe1dIaq5qj67mHe7xZZl
         SfZ8xj1CX1pqwrKFOg9wOvurzMs6bnzYa/DmDxAaCRVvhR4x4v13zLgX7H25tWHBIjfJ
         D+MpaDkqDeNIVtLhNr9NZXNZ1cf29Z7Y9GM6IH3kSl2G1lgNlFdeD8nCXh18U/FP4lbx
         xwx1y7cZasHfEfOPEPz35UcHEzX/PI8PNzhC6LQp5Sda9jyx0X1sUEXkhEQuuxES9i8M
         dkPw==
X-Gm-Message-State: AGi0PuZIScPeRcN6dh9KO1tU71nVk74NfIBlnB6+N1aILMjFwPl8izer
        PwUA1I200KEvPF+om7ohEtJJXA==
X-Google-Smtp-Source: APiQypKGW/K2soLIs9eAVY1OOgfXmUJJs+i18+vaEDRglxT5OIHxLWEnESyU5v5FNLGVig4bU6fu5Q==
X-Received: by 2002:a63:1854:: with SMTP id 20mr10113175pgy.257.1587741872728;
        Fri, 24 Apr 2020 08:24:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r128sm6390567pfc.141.2020.04.24.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 08:24:31 -0700 (PDT)
Date:   Fri, 24 Apr 2020 08:24:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: remaining flexible-array conversions
Message-ID: <202004240824.F042AFFBF@keescook>
References: <6342c465-e34b-3e18-cc31-1d989926aebd@embeddedor.com>
 <20200424034704.GA12320@ubuntu-s3-xlarge-x86>
 <20200424121553.GE26002@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424121553.GE26002@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 09:15:53AM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 23, 2020 at 08:47:04PM -0700, Nathan Chancellor wrote:
> > Hi Gustavo,
> > 
> > On Wed, Apr 22, 2020 at 01:26:02PM -0500, Gustavo A. R. Silva wrote:
> > > Hi Linus,
> > > 
> > > Just wanted to ask you if you would agree on pulling the remaining
> > > flexible-array conversions all at once, after they bake for a couple
> > > of weeks in linux-next[1]
> > > 
> > > This is not a disruptive change and there are no code generation
> > > differences. So, I think it would make better use of everyone's time
> > > if you pull this treewide patch[2] from my tree (after sending you a
> > > proper pull-request, of course) sometime in the next couple of weeks.
> > > 
> > > Notice that the treewide patch I mention here has been successfully
> > > built (on top of v5.7-rc1) for multiple architectures (arm, arm64,
> > > sparc, powerpc, ia64, s390, i386, nios2, c6x, xtensa, openrisc, mips,
> > > parisc, x86_64, riscv, sh, sparc64) and 82 different configurations
> > > with the help of the 0-day CI guys[3].
> > > 
> > > What do you think?
> > > 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d496496793ff69c4a6b1262a0001eb5cd0a56544
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=for-next/kspp&id=d783301058f3d3605f9ad34f0192692ef572d663
> > > [3] https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/kernel-ci/kspp-fam0-20200420.md
> > > 
> > > Thanks
> > 
> > That patch in -next appears to introduce some warnings with clang when
> > CONFIG_UAPI_HEADER_TEST is enabled (allyesconfig/allmodconfig exposed it
> > for us with KernelCI [1]):
> 
> Indeed, I've tried these conversions before and run into problems like
> this, and more. Particularly in userspace these structs also get
> embedded in other structs and the warnings explode.
> 
> Please drop changes to ib_user_verbs.h from your series

We might need to make the UAPI changes separately (or not at all).

-- 
Kees Cook
