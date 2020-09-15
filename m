Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8576A26B7DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgIPAbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgIONpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:45:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481CDC061225
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:45:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so3366063wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jFlH2Mb4PbicIWoSy/doLle0e/no7tiKAYBIFeeMPlE=;
        b=cmL+DxSQG5LinAgNudybg6vutCW3d525J8bCTa5zQRsM1+6+9u7btw251f1MR5sX39
         Kn/qOa17Cl5qvCihyI9tkcM8WGn9vqBjwld//Cam6u5a3lqBnRxOS4kPFMaM2+Wh9lia
         Dn+7EZImyLJIgW00vBvwynPEbNYZ0mpBabcIzIYm5h5992MwZNrWy+feXgrdqpRfjP7c
         KnbtFJAXCexsAwnXmW5KKgDj9dLqg13gTmbXS8r66cb9GGwEJGnYYoGLIzVkjlffojzc
         WyHU31DfYADP/TjbzvIKu9VPGeBim2GV59AVMSdRiTBRMbmZklS6/f5SMPDIgQUCdwVb
         r2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jFlH2Mb4PbicIWoSy/doLle0e/no7tiKAYBIFeeMPlE=;
        b=DLu1D2YtNp1ljfTygkpPE+KV/vVj9GO2lSjb3QjJMOE4p2/ub1kov3MgqXp3t33Jjh
         ma8UONpjXcx/lSnT2ZhGaXPaqbinZSbyTAifpK7w/rBhNIX45LUkRWc0LPxwNQeMEIJP
         IjvMq4gu0lwDTOvdrc9qdTrV/Ep9PdCejGyL0x1QWfEJ4ghSPtm0BeaW3qLiV1x3bLQD
         NagjhnURuqUswFCnQwdrrrNK8F8y9dgE7jpEH8Is6V36AQrKX/F8ys1mDNpRZSMiGVqa
         lUA3N/9twmPfM98bzjb5v6fGCilKbD39vKLgrTteBfBXH0IlTdDCkbq8uhrG7bdVCOmb
         /8eQ==
X-Gm-Message-State: AOAM531Xn95j+1xYMKiSEvqSFEatTo5y2Te569EXN/DB8F8vqHFfiorn
        OxIWlnUnuDHoo0t9I81JOzWMaMHtMB1sPw==
X-Google-Smtp-Source: ABdhPJzE0F+7GcnPcOMiYkTxRx7ha2dm7bcywWCpIi540WqHfOagDSepgNDSVCDmhfeZeRYs9Zjwrw==
X-Received: by 2002:adf:f0c7:: with SMTP id x7mr21149017wro.315.1600177523578;
        Tue, 15 Sep 2020 06:45:23 -0700 (PDT)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id x2sm26804404wrl.13.2020.09.15.06.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:45:22 -0700 (PDT)
Date:   Tue, 15 Sep 2020 14:45:20 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Subject: Re: [PATCH v3 3/3] kernel: debug: Centralize
 dbg_[de]activate_sw_breakpoints
Message-ID: <20200915134520.jgbxallmksifrg2x@holly.lan>
References: <20200914130143.1322802-1-daniel.thompson@linaro.org>
 <20200914130143.1322802-4-daniel.thompson@linaro.org>
 <CAD=FV=VUPXdHoPaQg=Pp=bH-iORicO+1LjBZ0PNu0=SumC5tYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VUPXdHoPaQg=Pp=bH-iORicO+1LjBZ0PNu0=SumC5tYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 05:13:28PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Sep 14, 2020 at 6:02 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > During debug trap execution we expect dbg_deactivate_sw_breakpoints()
> > to be paired with an dbg_activate_sw_breakpoint(). Currently although
> > the calls are paired correctly they are needlessly smeared across three
> > different functions. Worse this also results in code to drive polled I/O
> > being called with breakpoints activated which, in turn, needlessly
> > increases the set of functions that will recursively trap if breakpointed.
> >
> > Fix this by moving the activation of breakpoints into the debug core.
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  kernel/debug/debug_core.c       | 2 ++
> >  kernel/debug/gdbstub.c          | 1 -
> >  kernel/debug/kdb/kdb_debugger.c | 2 --
> >  3 files changed, 2 insertions(+), 3 deletions(-)
> 
> I like the idea, but previously the kgdb_arch_handle_exception() was
> always called after the SW breakpoints were activated.  Are you sure
> it's OK to swap those two orders across all architectures?

Pretty sure, yes.

However, given the poor attention to detail I demonstrated in patch 2/3,
I figure I'd better write out the full chain of reasoning if I want
you to trust me ;-) .

kgdb_arch_handle_exception() is already called frequently with
breakpoints disabled since it is basically a fallback that is called
whenever the architecture neutral parts of the gdb packet processing
cannot cope.

So your question becomes more specific: is it OK to swap orders when the
architecture code is handling a (c)ontinue or (s)tep packet[1]?

The reason the architecture neutral part cannot cope is because it
because *if* gdb has been instructed that the PC must be changed before
resuming then the architecture neutral code does not know how to effect
this. In other words the call to kgdb_arch_handle_exception() will
boil down to doing whatever the architecture equivalent of writing to
linux_regs->pc actually is (or return an error).

Updating the PC is safe whether or not breakpoints are deactivated
and activating the breakpoints if the architecture code actually
censors the resume is a bug (which we just fixed).


Daniel.


[1]
   The fallthroughs aren't a whole lot of fun to read but
   if gdb_cmd_exception_pass() provokes a fallthrough then it will
   have rewritten the packet as a (c)ontinue.
