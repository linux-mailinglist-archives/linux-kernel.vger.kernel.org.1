Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A8B1B4C22
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 19:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgDVRvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 13:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbgDVRvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:51:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5F6C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:51:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 145so1453747pfw.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZF6h4B8lRkEW+PGdoi5ViWh9NdqvBm+plj3edg+BLxs=;
        b=SbiBDMBjNOJtZvz674h6CaZCEGdmafbK0qSIOSSMTCWnqd5jMXbDXqcct8K8mtTChe
         4BmBYx34rurFf5imZkH6NB9jvIu0M0140rWbXixJsCfD/+8yfkJPCm/IHIsm3ZoRWfwb
         VIyeJQzY1bEBF+t0X5Jqa/2kR8k/V4WASdOqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZF6h4B8lRkEW+PGdoi5ViWh9NdqvBm+plj3edg+BLxs=;
        b=VgZwZ1wjHOQ97Rw5kc4m0QaiWWB6BG5+scENnM3w5I/FsWR/NCr0Onk0Z7Xpe22EPG
         vpK7HtdrmXgGvJFYA0xI1d3oV6/osyAT4uwJZKZZWqNU/DE89f3XZDW19X+xZahf4cpv
         PMj5baDq+v06rvf1edNP1MKaod6wuk7UQseeymV/YhJ92/Pa+D3AMu+4CwKpXmzajR+T
         csUv5w+cgSjHRvY9Uw3KiACWFYrqWIPDLh+/TKgP3lpR38SwL/4kWUs5axxiTxBVfbui
         yJLqgCrzRz6l/Mu5t0vw/Q3PPzIJT3/ELmFLkZNdMpYLIR/xFMyppRzli+X44NbCh1hC
         Nweg==
X-Gm-Message-State: AGi0Pub0b8CRynOsCzIyyp831ayzi2BonF7VdtxAQZsOQOD19vo3pZ+l
        +WG/9kVS4v7LabiFS6gmGpPNXA==
X-Google-Smtp-Source: APiQypKgukJRS2MpdwcmV4gR8X/qlLkQhVOoNqLyqZFCT1UTaoEDKt7OxFkygmvQ9SLxUbFYDjP/kg==
X-Received: by 2002:a63:9e54:: with SMTP id r20mr141098pgo.301.1587577864965;
        Wed, 22 Apr 2020 10:51:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e4sm5917509pjv.30.2020.04.22.10.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 10:51:04 -0700 (PDT)
Date:   Wed, 22 Apr 2020 10:51:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 01/12] add support for Clang's Shadow Call Stack (SCS)
Message-ID: <202004221047.3AEAECC1@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-2-samitolvanen@google.com>
 <20200420171727.GB24386@willie-the-truck>
 <20200420211830.GA5081@google.com>
 <20200422173938.GA3069@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422173938.GA3069@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 06:39:47PM +0100, Will Deacon wrote:
> On Mon, Apr 20, 2020 at 02:18:30PM -0700, Sami Tolvanen wrote:
> > On Mon, Apr 20, 2020 at 06:17:28PM +0100, Will Deacon wrote:
> > > > +	 * The shadow call stack is aligned to SCS_SIZE, and grows
> > > > +	 * upwards, so we can mask out the low bits to extract the base
> > > > +	 * when the task is not running.
> > > > +	 */
> > > > +	return (void *)((unsigned long)task_scs(tsk) & ~(SCS_SIZE - 1));
> > > 
> > > Could we avoid forcing this alignment it we stored the SCS pointer as a
> > > (base,offset) pair instead? That might be friendlier on the allocations
> > > later on.
> > 
> > The idea is to avoid storing the current task's shadow stack address in
> > memory, which is why I would rather not store the base address either.
> 
> What I mean is that, instead of storing the current shadow stack pointer,
> we instead store a base and an offset. We can still clear the base, as you
> do with the pointer today, and I don't see that the offset is useful to
> an attacker on its own.
> 
> But more generally, is it really worthwhile to do this clearing at all? Can
> you (or Kees?) provide some justification for it, please? We don't do it
> for anything else, e.g. the pointer authentication keys, so something
> feels amiss here.

It's a hardening step to just reduce the lifetime of a valid address
exposed in memory. In fact, since there is a cache, I think it should be
wiped even in scs_release().

-- 
Kees Cook
