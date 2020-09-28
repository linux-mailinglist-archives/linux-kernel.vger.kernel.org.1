Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D6327ABD8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgI1KeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1KeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:34:10 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A529C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:34:10 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c18so312989qtw.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UdVN0rrYz23qDEhgShYkCgw3PoQ861jSenFQlndrMFY=;
        b=QhnOwDpFSJWcMYu6CIJ0WcdAcvySQFGX0dG2YE2oo2pOKFpwHOVDIf8wo1JvEzLDza
         2sdw/L9iCWaKMxcK/f70JzMtxBbdXaevsHXXcVp1yhkgNWMXx5FV3yOLDwuKSK+g1mYT
         E+FmvEuqidd5KQTTsm+KQSvYzyDChveVStbhL1uIHh37/ZQ+iSzQi0yy3SE6GgiYNPe5
         EuD+zWyh5lwCLhY7zaBqmuiVA3xsUIL83oniMLGDa8yCHra1sxyrIRVGNdk7hbpmAE5j
         oCXmXYXMl8jRmtmjfgORCBV03r03qq1YJPZkatoJOBW04Y+UQvxntEBOGgScECETgTWQ
         7lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UdVN0rrYz23qDEhgShYkCgw3PoQ861jSenFQlndrMFY=;
        b=azX90T/wG1TO4YdvCP/kFLMLffvMutVvqKnLwEdgXP+M4RfGSzhEJSlYB8/GAzcbjE
         KQkQWBUGaIaClwIqiT4PNOZAopt1sPQW1sZLozyh84Nz/g9HtjqFW5Pi9TYqM6xboZ8V
         RtTfbN85dna/dgwR4HooDj8fuRNPj5gvYIlIKWC1MmVNoj6wCsvyOpz2qqzxyUG7Jq7t
         lKPA5uyzhrGXhCRsyvZN4ZfXigD11HqNc+oyw0RX0LGUAeeVFIFdTzwaYlFvYrgwolIc
         fRDZ+7gBFtXPCZVQeYSc0e8XGWeqV/rVhR9Iwp7bIXmXdFq2A+4ZLsoPbPE27xLlQN4B
         igPA==
X-Gm-Message-State: AOAM530A2aw+PypZkZrELu/0t9IJGU+Ir9AMxsf+8S8WRCs4EUn5814A
        J9CIcGUpSo92FpIEJ3xirL1MkPZtVUyXX++cON8kgw==
X-Google-Smtp-Source: ABdhPJxZ1L/37BBkc7oktblE+tt5CQJRPLIrRGMsSQ4cQGR3S5hIk0+8gbLXS0StObalhWKgmRO+JhEQPmE4OzT8EPk=
X-Received: by 2002:ac8:5215:: with SMTP id r21mr784396qtn.257.1601289249260;
 Mon, 28 Sep 2020 03:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200927145737.GA4746@zn.tnic>
 <CACT4Y+Zxt3-Dj6r53mEkwv24PazPzTxQ7usV1O+RB0bk2FzO8g@mail.gmail.com>
 <CACT4Y+ZZH76qg810RzGp6FDLTxJWVqZgkrXSxqgq7AjpPYG9XQ@mail.gmail.com>
 <20200928083819.GD1685@zn.tnic> <CACT4Y+bPFASnmFRKpQ=KY1z+RnTbGmkPU3aikzdXZpKkV03D9A@mail.gmail.com>
 <20200928085401.GE1685@zn.tnic>
In-Reply-To: <20200928085401.GE1685@zn.tnic>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 28 Sep 2020 12:33:57 +0200
Message-ID: <CACT4Y+Z4Y6SJJ6iYBhVRiknrWBAD6gGhQXiXLhxPniDNBFJGsA@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:54 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Sep 28, 2020 at 10:40:19AM +0200, Dmitry Vyukov wrote:
> > I meant the kernel self-corrupts itself, that just wasn't detected by
> > KASAN, page protections, etc.
>
> Well, Nick already asked this but we're marking all kernel text RO early
> during boot. So it either is happening before that or something else
> altogether is going on.
>
> And if that is a kernel issue, I believe we should've heard by now from
> others. Or maybe this happens only in VMs.
>
> Questions over questions...

I don't have answers to all of the questions, but syzkaller produces a
pretty unique workload. It has found thousands of bugs that you have
not heard from others:
https://syzkaller.appspot.com/upstream#open
https://syzkaller.appspot.com/upstream/fixed
In particular there are hundreds of known and active potential memory
corruption bugs.

It may be related to VMs, but also may well not be related to VMs.
