Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869332D3086
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbgLHRFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbgLHRFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:05:16 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327D3C061794
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 09:04:36 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r3so16991295wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 09:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RE0ZyDjS9csHRr+SxXqoIyxGXkIUMbwk5h1vfdVY/Jo=;
        b=sHlLDbSAF1DHYdjAU2pYOuCdGNMyW0m8wRXesU4XKzdY7L8cOA7KxxWcIyncPuP/Rf
         J5BMIUU1VUeu7dJep3IeI4J1P7fWgkWZfiN9lpjieRsuVKTRBxIXDFl82TdM3yestIgI
         thpEfYzDr+j8vl8CJgOhItUm8gw0FDjF8yeTypCo6xsHJhelJRzl4ecDaybLPmkiQiGR
         e/q/jZRaRfzLCm+kaQzRjA2tBOQGX3p//WfiweKUZzk9/4O05taoof1qznyXp35Yd6TG
         /bAN33zHiuwKk1KFHRqIgDE+XsR/G/d4m50ymoIf6GxU4KdAnbszijyDW0JgPxDv7wWW
         8IlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RE0ZyDjS9csHRr+SxXqoIyxGXkIUMbwk5h1vfdVY/Jo=;
        b=FskJDswPBDC0xNTcTkI6SRDUiksM00YehAR0Rhb9CKMBlRtD74SX4MSMfx1kAkwINQ
         9VCGeKm0yROC1A9KiwXRnnp5wI++6+fR7o39UvcAON2NwXnnmO521Dk8+7aQLstkX/DU
         TwYJp4kxyxwuyCV4Vm+ADOHsZKz4ie3TBRp2Yq+53HdeNkZz6DaAcR0OAaVh9qm2Hmar
         r1IrDG5YTyJwMG8etlEe/Mmq6FdoWzsAMxnWJak9drEDCcTG9sNgdiImUlKYMkBLGHkZ
         8Pv7gQ7uIs042lukWDuxqmGu6Sf6UYLdsj3BCpcwM+8ThdLZs3qx+xV+SPM2J5NdQPCr
         GO/Q==
X-Gm-Message-State: AOAM531a1xGdmdcvuePEI3OW3nnlYaxeVsL2vCmMZmSJIN4n0LcHBP8n
        Alou6Wx6DW+Axa6TRICYty+Zfw==
X-Google-Smtp-Source: ABdhPJyIqFaUGn8WR2vjV5uSHTLO4k57M1T9jQtvOKXr26z8FICzPerdL4TvpBshQfn1WT/csPmoJQ==
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr2533857wrx.76.1607447074798;
        Tue, 08 Dec 2020 09:04:34 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 35sm20913983wro.71.2020.12.08.09.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 09:04:33 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:04:29 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v3 12/14] bpf: Pull tools/build/feature biz into
 selftests Makefile
Message-ID: <X8+yHRxv2g7dXeNP@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-13-jackmanb@google.com>
 <CAEf4BzbEfPScq_qMVJkDxfWBh-oRhY5phFr=517pam80YcpgMg@mail.gmail.com>
 <X8oEOPViOhR8XdH6@google.com>
 <CAEf4BzaEystdQ3PbaZXhmpTfqbs410BVCEToHfKLgx-3wAm-KA@mail.gmail.com>
 <X84LPVp3PqfESx9U@google.com>
 <CAEf4BzbQyyN620oOaK4Tc=0tju0-NuOQYESCrsOLPAmBjRD9Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbQyyN620oOaK4Tc=0tju0-NuOQYESCrsOLPAmBjRD9Zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 06:19:12PM -0800, Andrii Nakryiko wrote:
> On Mon, Dec 7, 2020 at 3:00 AM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > On Fri, Dec 04, 2020 at 11:00:24AM -0800, Andrii Nakryiko wrote:
> > > On Fri, Dec 4, 2020 at 1:41 AM Brendan Jackman <jackmanb@google.com> wrote:
> > > >
> > > > On Thu, Dec 03, 2020 at 01:01:27PM -0800, Andrii Nakryiko wrote:
> > > > > On Thu, Dec 3, 2020 at 8:07 AM Brendan Jackman <jackmanb@google.com> wrote:
> > > > > >
[...]
> >
> > Ah right gotcha. Then yeah I think we can do this:
> >
> >  BPF_ATOMICS_SUPPORTED = $(shell \
> >         echo "int x = 0; int foo(void) { return __sync_val_compare_and_swap(&x, 1, 2); }" \
> >         | $(CLANG) -x cpp-output -S -target bpf -mcpu=v3 - -o /dev/null && echo 1 || echo 0)
> 
> Looks like it would work, yes.
/
> Curious what "-x cpp-output" does?

That's just to tell Clang what language to expect, since it can't infer
it from a file extension:

  $ echo foo | clang -S -
  clang-10: error: -E or -x required when input is from standard input

Yonghong pointed out that we can actually just use `-x c`.
