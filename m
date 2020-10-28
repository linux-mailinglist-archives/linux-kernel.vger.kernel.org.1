Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534ED29D9D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390108AbgJ1XDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731811AbgJ1XDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:03:08 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245A9C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:03:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z24so763048pgk.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VQ0lxcZI2VSkmnyejXrJrCJPTsroIKzTjhtbv3VJ5c0=;
        b=P3/Fwh+91ubVJLYVjWHbNwLHLNeUym8Fjm0EcQA8mAYu50Oa0lbjwGt6m+XoPAQtYO
         C4pwBLv89fuW84K7fOliXTKfbMRz4620TELFBuxaKJSolGc3lhqWbGWugnYVBqDapezm
         v/KEtCrWM5jj2DST1v/kaG+fudNkMQIremMnRLOr6uxvH77P1x6bjjQ0POPcRpxX+fqh
         E7AfbrwgrcbiiQd/rzyGGTHGkAOxavVdRV23RDgy+B+AXiUVeaD8+PAf1/PaCo3Bnuup
         H4iJBm/HV07ECAZGID612lUt0Q86gBIt4Id5UBbbpGsQZsMe5tM++dXKE7/swhkQgSbl
         XULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VQ0lxcZI2VSkmnyejXrJrCJPTsroIKzTjhtbv3VJ5c0=;
        b=jQgSpjovHBcCiEa8ycejUVRyMyyeMMHIW+0lLBs4ipPtpENGI/SFHXH2w+Vk7Gugfi
         X6DqKBIW0wpNXOFsRVRF6V1ZucGFhwjRMC39bvM2W5OIkN9Ahz8ecG2w72v5S6hZD0Gt
         mP8vqstySReEg9lsDlL8G8m5biHnmVsKPMXhpQ12mlgVGF5JnOqzOo6DOVEfNASnXZJb
         XKK47kjHBSdKQXpz+/0Nkee2zTENMk041eR/XJliorYULIGVKkP71xD1kV3GN6c+QIwO
         eTbV1HljsYzfrK4RGuwJCfGpoeMIurf4NQjtr5js4l1e3+XV8du/C4Dz2wrSFdlim187
         Jlow==
X-Gm-Message-State: AOAM531neCwSJQLWhpeUpSapqV4ZlGcu0ACtMt6j/4H+7xRerDtmx6mt
        9EkgEMSTQwCK/AfNToe3GPw=
X-Google-Smtp-Source: ABdhPJx0MvXtkx3MydLr80XlySPM7Ui7Add+tOGsJTh9XT5R+p8/eY1PYZJnMFDsz9i5YN367VJjtg==
X-Received: by 2002:a63:74d:: with SMTP id 74mr1398053pgh.389.1603926187664;
        Wed, 28 Oct 2020 16:03:07 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::4:1c8])
        by smtp.gmail.com with ESMTPSA id ca5sm457035pjb.27.2020.10.28.16.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 16:03:06 -0700 (PDT)
Date:   Wed, 28 Oct 2020 16:03:05 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC][PATCH 0/2] ftrace: Add access to function arguments for
 all callbacks
Message-ID: <20201028230305.zhtpwektsehh54bv@ast-mbp.dhcp.thefacebook.com>
References: <20201028131542.963014814@goodmis.org>
 <20201028213303.shosfclmhxkai2ir@ast-mbp.dhcp.thefacebook.com>
 <20201028180753.238335d1@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028180753.238335d1@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 06:07:53PM -0400, Steven Rostedt wrote:
> On Wed, 28 Oct 2020 14:33:03 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > I don't have strong opinion on this feature, but if you want to have it
> > please add a giant disclaimer that this is going to be x86-64 and, may be arm64,
> > feature _forever_. On x86-32 and other architectures there is no way
> > to provide sane regs_get_kernel_argument(regs, n) semantics by blindly
> > saving registers. The kernel needs to know types and calling convention
> > of the architecture. That's the reason bpf side has btf_func_model concept.
> > To make sure that bpf trampoline can support all architectures in the future.
> 
> The trampoline is to only provide the information to get the arguments.
> Yes, it is up to the callback that registered it that knows how to get them.
> 
> What does the bpf trampoline need to get an argument if it already
> knows the type. If it has access to a subset of necessary registers and
> the stack pointer of when the function was called, is it possible to
> figure out the arguments?
> 
> This code is not about a "regs_get_kernel_argument(regs, n)", that was
> only used to show that *that* could be done. Because currently, there's
> *no* way to get those arguments without setting the SAVE_REGS flag,
> which saves way more than necessary. I only used that to test the code
> in a generic way. Ideally, ftrace could use btf to figure out the
> actual arguments of the function if it had a mapping.
> 
> I believe the reason you gave up on using ftrace was because of the
> overhead of the REGS code. If that wasn't the case, and you didn't see
> that overhead, would you have used ftrace?
> 
> In fact, did you look at all to see if you could modify the current
> infrastructure to make it work for you? Or did you just give up to
> write your own from scratch?

I don't understand what you're trying to say.
Are we still discussing your patch or something else?
If your patch then, I said, I'm not against it. I just don't see
a value in it. Since you're agree that regs_get_kernel_argument()
is misleading then what's the point of the patch?
To make mini-SAVE_REGS version? For what kind of use case?
