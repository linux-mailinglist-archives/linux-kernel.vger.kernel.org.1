Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331B726DA61
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgIQLgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:36:11 -0400
Received: from foss.arm.com ([217.140.110.172]:44974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgIQLaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:30:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB5BE30E;
        Thu, 17 Sep 2020 04:04:37 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.19.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F33673F68F;
        Thu, 17 Sep 2020 04:04:33 -0700 (PDT)
Date:   Thu, 17 Sep 2020 12:04:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Kiss <Daniel.Kiss@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
        Momchil Velikov <Momchil.Velikov@arm.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200917110427.GA98505@C02TD0UTHF1T.local>
References: <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <20200915172152.GR14436@zn.tnic>
 <CAKwvOdkh=bZE6uY8zk_QePq5B3fY1ue9VjEguJ_cQi4CtZ4xgw@mail.gmail.com>
 <CANpmjNPWOus2WnMLSAXnzaXC5U5RDM3TTeV8vFDtvuZvrkoWtA@mail.gmail.com>
 <20200916083032.GL2674@hirez.programming.kicks-ass.net>
 <CANpmjNOBUp0kRTODJMuSLteE=-woFZ2nUzk1=H8wqcusvi+T_g@mail.gmail.com>
 <CAKwvOd=T3w1eqwBkpa8_dJjbOLMTTDshfevT3EuQD4aNn4e_ZQ@mail.gmail.com>
 <CANpmjNPGZnwJVN6ZuBiRUocGPp8c3rnx1v7iGfYna9t8c3ty0w@mail.gmail.com>
 <333D40A0-4550-4309-9693-1ABA4AC75399@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <333D40A0-4550-4309-9693-1ABA4AC75399@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:30:42PM +0100, Daniel Kiss wrote:
> 
>     Thanks for the summary -- yeah, that was my suspicion, that some
>     attribute was being lost somewhere. And I think if we generalize this,
>     and don't just try to attach "frame-pointer" attr to the function, we
>     probably also solve the BTI issue that Mark still pointed out with
>     these module_ctor/dtors.
> 
>     I was trying to see if there was a generic way to attach all the
>     common attributes to the function generated here:
>     https://github.com/llvm/llvm-project/blob/master/llvm/lib/Transforms/Utils/
>     ModuleUtils.cpp#L122
>     -- but we probably can't attach all attributes, and need to remove a
>     bunch of them again like the sanitizers (or alternatively just select
>     the ones we need). But, I'm still digging for the function that
>     attaches all the common attributes…
> 
> 
> We had the problem with not just the sanitisers.  Same problem pops with
> functions 
> that created elsewhere in clang (e.g _clang_call_terminate ) or llvm.
> 
> In case of BTI the flag even controllable by function attributes which makes it
> more trickier so
> the module flags found the only reliable way to pass this information down. 
> Scanning existing functions is fragile for data only compilation units for
> example.
> 
> Our solution, not generic enough but might help.
> https://reviews.llvm.org/D85649 

Thanks for the pointer -- I've subscribed to that now.

Just to check my understanding, is the issue that generated functions
don't implicitly get function attributes like
"branch-target-enforcement", and so the BTI insertion pass skips those?

I'm guessing that it's unlikely this'll be fixed for an LLVM 11 release?
On the kernel side I guess we'll have to guard affected features as
being incompatible with BTI until there's a viable fix on the compiler
side. :/

Thanks,
Mark.
