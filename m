Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DAF279C04
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 21:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgIZTFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 15:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730180AbgIZTFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 15:05:41 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D19C21D7F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 19:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601147140;
        bh=67bbGqnrZpP+z/jSHSAMocksxZlI1NfOMQdsOtoJVaI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ChgCopoLb3Y/YZxQRtKP3P7EC5wdq6b5F4cmSlAuzG59XIIOjIjtRNOUulCYY54vd
         3kCaQItNgjw1DYkzxcTodlUZpfN8ryjKJW55dwrp7EKfSczwSJfOwpUkmGubweE9x9
         1BgBPNtsNLBy+FqZai+o11RNt0ooVIQJXGR9hYxw=
Received: by mail-wr1-f46.google.com with SMTP id z1so7469160wrt.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 12:05:40 -0700 (PDT)
X-Gm-Message-State: AOAM530JhkeeqLofXwQrxMkfiub8Bp3XO3TOSlPHxPtblLqzgGIJWS62
        MVpaxQtWjnWc5voQlIAKJHxnJF2WXnCV7wgrG5UiEA==
X-Google-Smtp-Source: ABdhPJzJpaOJbRmaM/kg50xhOP/aM2DNkAnFDPMKfx+AvI9TEYXSVv+JUSI8+aEOpzpkx2hwQI2Q0hP9d43gDV92rqE=
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr10501074wrb.70.1601147138798;
 Sat, 26 Sep 2020 12:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrUhQjQQa-BqNHPgdDfD9GDJZXJWSQ_M0tDF_ri5RfyTsw@mail.gmail.com>
 <20200925190915.GD31528@linux.intel.com> <CALCETrWDgb_mVPDmKy_7oFg03cOxO-GAUS8kOFrfGiPp9RjboA@mail.gmail.com>
 <20200925222938.GI31528@linux.intel.com>
In-Reply-To: <20200925222938.GI31528@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 26 Sep 2020 12:05:26 -0700
X-Gmail-Original-Message-ID: <CALCETrUV-cx6dii2cOcav01GSdo9qx6+GYeoPH9nHMXwg-geQQ@mail.gmail.com>
Message-ID: <CALCETrUV-cx6dii2cOcav01GSdo9qx6+GYeoPH9nHMXwg-geQQ@mail.gmail.com>
Subject: Re: Can we credibly make vdso_sgx_enter_enclave() pleasant to use?
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Cedric Xing <cedric.xing@intel.com>, linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 3:29 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Sep 25, 2020 at 01:20:03PM -0700, Andy Lutomirski wrote:
> > On Fri, Sep 25, 2020 at 12:09 PM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > > But where would the vDSO get memory for that little data structure?  It can't
> > > be percpu because the current task can get preempted.  It can't be per instance
> > > of the vDSO because a single mm/process can have multiple tasks entering an
> > > enclave.  Per task might work, but how would the vDSO get that info?  E.g.
> > > via a syscall, which seems like complete overkill?
> >
> > The stack.
>
> Duh.
>
> > The vDSO could, logically, do:
> >
> > struct sgx_entry_state {
> >   unsigned long real_rbp;
> >   unsigned long real_rsp;
> >   unsigned long orig_fsbase;
> > };
> >
> > ...
> >
> >   struct sgx_entry_state state;
> >   state.rbp = rbp;  [ hey, this is pseudocode.  the real code would be in asm.]
> >   state.rsp = rsp;
> >   state.fsbase = __rdfsbase();
> >   rbp = arg->rbp;
> >
> >   /* set up all other regs */
> >   wrfsbase %rsp
> >   movq enclave_rsp(%rsp), %rsp
>
> I think this is where there's a disconnect with what is being requested by the
> folks writing run times.  IIUC, they want to use the untrusted runtime's stack
> to pass params because it doesn't require additional memory allocations and
> automagically grows as necessary (obviously to a certain limit).  I.e. forcing
> the caller to provide an alternative "stack" defeats the purpose of using the
> untrusted stack.

I personally find this concept rather distasteful.  Sure, it might
save a couple cycles, but it means that the enclave has hardcoded some
kind of assumption about the outside-the-enclave stack.

Given that RBP seems reasonably likely to be stable across enclave
executions, I suppose we could add a flag and an RSP value in the
sgx_enclave_run structure.  If set, the vDSO would swap out RSP (but
not RBP) with the provided value on entry and record the new RSP on
exit.  I don't know if this would be useful to people.

I do think we need to add at least minimal CFI annotations no matter what we do.
