Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9570926C7B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgIPSdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgIPS3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:29:47 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECB8C061756
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:28:38 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g29so4406973pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+hNBdZ8eBcNPHlpjzcCHTGcOrY0T16QrOvnANJBRf5g=;
        b=UJn3OxXsgeR+LsCuSfNvXya9vhUOiyVdyMak20SRdAJqfk4AROUrO28wc/DqxY8j7R
         CD4QVJWEtv/kXlII7emMwzIFLCimmiU/Bapwbn+Y0W+d6n4ErcWsunM0nJESM9l5QcOZ
         ZB0pT/qSF4Jq4eNKZGM2L3Q3Sk6E57zTnnlsciK2u2iCT5eOIqhuhvEvFnJjavicYMRa
         eMy3Z/w+8uL8SXMPdBkmVcwGekPw16ASzESxcOzCWKvYctse2wso8g/x5vAuDfm2O5r9
         jEHE5+FtbNdSCayMdpS9h7lg0eboE2dQWDFev3WbXUyTMwAuyoMk3X7V9m09RabM4Gl/
         dUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+hNBdZ8eBcNPHlpjzcCHTGcOrY0T16QrOvnANJBRf5g=;
        b=p4Xq2FQaPad015qsBr1YfvgsA2rdYejFT/tUFCXPdRLfbYyMTEKj2a53PX+sAIeJ8Q
         7bMNrPjteQKfaQeFGqZcPOJpFB6JrPuQsdJawhGbcvJhiZkLC7qNv9KlivqqY65wsv2u
         fCg0xlxmeml2WFF9AhE7anVT7ows9841hvAyQDk2DNTGXWcOz50gcdVz0HGZtRasQ9lY
         /3tmxzGYtCQJpO1Lv5mSR54mJDFv01Dvegfxv1PuJ0RLdk3+6ZWloR+BUgkjywtzTWxo
         4TK8wB0ZGHvtL3pW7agfLCWkDDpqzW3TtOvu6i6HPPAuRtF192sJVBNcbPVr2Hz/HY8D
         ehsA==
X-Gm-Message-State: AOAM532SDE0If+UIX13z6hnUEbLMxLErtNcDhghbK965azXmn17poStN
        CTbFahQ+naXE4G1MXM+XLMW93jKUU76CRnc8OC5u9g==
X-Google-Smtp-Source: ABdhPJzT0dEfcc/QV2EgegMA+KZ3+WWSPKOX0k0yoo8D1el0gfNIR0iFf5qhJmmlBD59oyTGhPuueUT9fSR1EVV0R6A=
X-Received: by 2002:a63:5d57:: with SMTP id o23mr3347261pgm.263.1600280918024;
 Wed, 16 Sep 2020 11:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
 <20200915204912.GA14436@zn.tnic> <20200915215054.GA1104608@rani.riverdale.lan>
 <20200916113449.GH2643@zn.tnic>
In-Reply-To: <20200916113449.GH2643@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 16 Sep 2020 11:28:26 -0700
Message-ID: <CAKwvOdkjAHv_=+167x6paXpO6QsEEPivZd=tj+WGpzg+pKjgtg@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 4:34 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Sep 15, 2020 at 05:50:54PM -0400, Arvind Sankar wrote:
> > On Tue, Sep 15, 2020 at 10:49:12PM +0200, Borislav Petkov wrote:
> > >
> > > (Btw, clang doesn't need to add that "xor %eax,%eax" - panic() should=
 not be
> > >  returning, ever. :-))
> > >
> >
> > I think this is because panic() is varargs, and clang doesn't support
> > gcc's -mskip-rax-setup. The normal ABI requires the caller to set RAX t=
o
> > the number of arguments in vector registers.
> >
> > https://patchwork.ozlabs.org/project/gcc/patch/20141218131150.GA32638@i=
ntel.com/
>
> Ah, good point. Found this in the ABI doc:
>
> "For calls that may call functions that use varargs or stdargs
> (prototype-less calls or calls to functions containing ellipsis (...) in
> the declaration) %al is used as hidden argument to specify the number of
> vector registers used. The contents of %al do not need to match exactly
> the number of registers, but must be an upper bound on the number of
> vector registers used and is in the range 0=E2=80=938 inclusive."

pt. 3 https://nickdesaulniers.github.io/blog/2014/04/18/lets-write-some-x86=
-64/

...2014, jesus...

"But you never can tell exactly what the compiler is doing. It doesn=E2=80=
=99t
always come out the way you want. Like a dusty pane or warped mirror."
Seems I'd learn more about that than I'd could have ever envisioned...
--=20
Thanks,
~Nick Desaulniers
