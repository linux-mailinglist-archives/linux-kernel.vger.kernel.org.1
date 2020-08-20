Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F57C24AC0A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 02:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHTAT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 20:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgHTAT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:19:56 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A7F521775
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597882795;
        bh=UoSSzOiBrRe7iK+l82T6x0wDhJm6VA4v7CJw4aj4dxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gWrlU/kpNE4mcIOu6IQxKmPZHQlr/iVoka4LgMeu/UTnBe7ElH+6QTk8bVOukXqs5
         a+1fMbb2C5APS9xljnSx+HU1iUr9hIoCi11wtAcpsc5Iz1zM04gZkMeRoX7Ch7he5l
         /cVWSwq19hhhElKyCs/vR3/9/fHovzCHoy3pBcaw=
Received: by mail-wr1-f43.google.com with SMTP id r4so417671wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 17:19:55 -0700 (PDT)
X-Gm-Message-State: AOAM533zWVP8y0pIFTbtg2tM74TnCBK0wmj9iTnCbT9LOHVItLWje0nh
        yCVGuWtEIMAGCKn7Ua2r9lKjcyQ8VofMLqFiWBA+yw==
X-Google-Smtp-Source: ABdhPJxInbWFJqe1ieCcvWc2d/gwkZXQYpryrROje/AuDGXpq1KmCR/aZOFVgMv/+HHmYN60m8lQIaqRMCz8YnK30Sg=
X-Received: by 2002:a5d:5712:: with SMTP id a18mr497294wrv.184.1597882793738;
 Wed, 19 Aug 2020 17:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200716135303.276442-1-jarkko.sakkinen@linux.intel.com>
 <20200716135303.276442-22-jarkko.sakkinen@linux.intel.com>
 <CAOASepOqRfUafSv_qjUv-jW_6n8G7kZ9yh-2z_Z9sjL_2zqNCg@mail.gmail.com>
 <CALCETrVch_XW-oc_-LR8Dbgat9DpSKtCYTV9YZaU7tfu61FHEw@mail.gmail.com> <20200818151524.GE132200@linux.intel.com>
In-Reply-To: <20200818151524.GE132200@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 19 Aug 2020 17:19:42 -0700
X-Gmail-Original-Message-ID: <CALCETrWHfL6_BOuVAi=ucB8N=pQiWV_dF3YpWndEq5LWaUD9tw@mail.gmail.com>
Message-ID: <CALCETrWHfL6_BOuVAi=ucB8N=pQiWV_dF3YpWndEq5LWaUD9tw@mail.gmail.com>
Subject: Re: [PATCH v36 21/24] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        X86 ML <x86@kernel.org>, linux-sgx@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Cedric Xing <cedric.xing@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asapek@google.com, Borislav Petkov <bp@alien8.de>,
        chenalexchen@google.com, Conrad Parker <conradparker@google.com>,
        cyhanish@google.com, Dave Hansen <dave.hansen@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Keith Moyer <kmoy@google.com>,
        Christian Ludloff <ludloff@google.com>,
        Neil Horman <nhorman@redhat.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 8:15 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Aug 10, 2020 at 04:08:46PM -0700, Andy Lutomirski wrote:
> > On Thu, Aug 6, 2020 at 7:55 AM Nathaniel McCallum <npmccallum@redhat.com> wrote:
> > >
> > > In a past revision of this patch, I had requested a void *misc
> > > parameter that could be passed through vdso_sgx_enter_enclave_t into
> > > sgx_enclave_exit_handler_t. This request encountered some push back
> > > and I dropped the issue. However, I'd like to revisit it or something
> > > similar.
> >
> > Why do you need an exit handler at all?  IIRC way back when I
> > suggested that we simply not support it at all.  If you want to
> > call__vdso_sgx_enter_enclave() in a loop, call it in a loop.  If you
> > want to wrap it intelligently in Rust, you don't want a callback
> > anyway -- that forces you have an FFI (or non-Rust, anyway) frame on
> > the stack, which interacts poorly with panic handling and prevents you
> > from using await in your Rust callback handler.  If, on the other
> > hand, you just call __vdso_sg_enter_enclave() in a loop, all these
> > problems go away and, if you really want, you can pass in a callback
> > in Rust and call the callback from Rust.
>
> How would Intel SDK be able to do its stack manipulation?

The same as now.  The enclave would see a pointer to a stack-like
writable area in USER_RSP, but it just wouldn't be the actual stack.

I suppose that the caller of the vdso can play these games just as
well as the vdso itself, though, so maybe this is not helpful.

--Andy
