Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D18826E407
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIQSkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726543AbgIQSje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600367973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s8/ARKLQp0M0HyDLCLKuWSzwoxVAsS/APQ6NuiD3MNU=;
        b=MxgcqBmfoL55kXzMxVKa8ElPitFjArTK3zcge1FM2E8kClMQyAqh6FqRKBEcOf0tVQs27b
        zfxTskc27y+nVtrLJJ/hJqIHxiNIIs1ARkeG800EDJNqSTy7WC42VF1XRomxKTS5PaaYSx
        FLwH3x0huYEU3SgOjeUoJjGfO4NLQxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-I6O1PZQ6O7yXfGqmLvj70w-1; Thu, 17 Sep 2020 14:39:29 -0400
X-MC-Unique: I6O1PZQ6O7yXfGqmLvj70w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CC6D10A7AE1;
        Thu, 17 Sep 2020 18:39:27 +0000 (UTC)
Received: from treble (ovpn-112-136.rdu2.redhat.com [10.10.112.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E159819D6C;
        Thu, 17 Sep 2020 18:39:24 +0000 (UTC)
Date:   Thu, 17 Sep 2020 13:39:23 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Daniel Kiss <daniel.kiss@arm.com>, momchil.velikov@arm.com
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200917183923.b5b2btxt26u73fgx@treble>
References: <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <20200915172152.GR14436@zn.tnic>
 <CAKwvOdkh=bZE6uY8zk_QePq5B3fY1ue9VjEguJ_cQi4CtZ4xgw@mail.gmail.com>
 <CANpmjNPWOus2WnMLSAXnzaXC5U5RDM3TTeV8vFDtvuZvrkoWtA@mail.gmail.com>
 <20200916083032.GL2674@hirez.programming.kicks-ass.net>
 <CANpmjNOBUp0kRTODJMuSLteE=-woFZ2nUzk1=H8wqcusvi+T_g@mail.gmail.com>
 <CAKwvOd=T3w1eqwBkpa8_dJjbOLMTTDshfevT3EuQD4aNn4e_ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=T3w1eqwBkpa8_dJjbOLMTTDshfevT3EuQD4aNn4e_ZQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:22:02AM -0700, Nick Desaulniers wrote:
> I looked into this a bit, and IIRC, the issue was that compiler
> generated functions aren't very good about keeping track of whether
> they should or should not emit framepointer setup/teardown
> prolog/epilogs.  In LLVM's IR, -fno-omit-frame-pointer gets attached
> to every function as a function level attribute.
> https://godbolt.org/z/fcn9c6 ("frame-pointer"="all").
> 
> There were some recent LLVM patches for BTI (arm64) that made some BTI
> related command line flags module level attributes, which I thought
> was interesting; I was wondering last night if -fno-omit-frame-pointer
> and maybe even the level of stack protector should be?  I guess LTO
> would complicate things; not sure it would be good to merge modules
> with different attributes; I'm not sure how that's handled today in
> LLVM.
> 
> Basically, when the compiler is synthesizing a new function
> definition, it should check whether a frame pointer should be emitted
> or not.  We could do that today by maybe scanning all other function
> definitions for the presence of "frame-pointer"="all" fn attr,
> breaking early if we find one, and emitting the frame pointer setup in
> that case.  Though I guess it's "frame-pointer"="none" otherwise, so
> maybe checking any other fn def would be fine; I don't see any C fn
> attr's that allow you to keep frame pointers or not.  What's tricky is
> that the front end flag was resolved much earlier than where this code
> gets generated, so it would need to look for traces that the flag ever
> existed, which sounds brittle on paper to me.

For code generated by the kernel at runtime, our current (x86) policy is
"always use frame pointers for non-leaf functions".

A lot of this compiler talk is over my head, but if *non-leaf* generated
functions are rare enough then it might be worth considering to just
always use frame pointers for them.

-- 
Josh

