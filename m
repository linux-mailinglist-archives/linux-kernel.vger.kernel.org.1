Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD0B26B513
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgIOXgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbgIOXgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 19:36:06 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBDCC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 16:36:05 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id e23so4968240otk.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 16:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPIBIQbbpXb5b+E+3fSEaQzi61gRepS0Kzj7VhcTRxw=;
        b=n4d86YrHF/WQAuo/E0fzBxBRTgzGDadWKnl52eKGrx4eTm+BZnjXBwF26cGAchj+Iu
         U3HcSqeD4njaKBABeFq3T6PCWzrKXXoeNikboDU7QXBodvt2UON8O6i4i84wMpX8dGaF
         ACqGZtTMfgX35JNWMezHF4XYHOJaNQuHNFm/hH+F9BaCtmuYHg1JTIXoVJ9+6I4Xyx9e
         oUgBT5edshZ3uHwi0bNlDWURE1wf4xMCgM5eiJaW0vaVicCOu/KazJnigaIV9DYjeaFI
         MPA8jNhM5OGR+XzUKcsomKd3MqRa5gjdMdDqXM+MGs22O2f28H92+Yc1x0XalIBuMjDi
         vn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPIBIQbbpXb5b+E+3fSEaQzi61gRepS0Kzj7VhcTRxw=;
        b=W6G0VgI4NwBVaUHDyB4eASaYZfVZLPPygx8zI+/tcC7k264Adtu9iXoDFyHMQFEi6K
         HzO0w4evM3M7JHOtw2buASgSBcKI9B9iUEtCLnVeKSDtxaWNUzU5X8WGgKelo6dxj43t
         hMFTbj5ccxtiEqK4E37Dx2XtOpDMrMXScjvMnnhnjsY/KsnldL8PlHQq5kEftTE+B2QK
         B+DeEEUmU/Gqv2GpWk4vdqqfzuVHlqqnhBiCHNVkWy2bd3mrgFPJ/aH2qW8f6HXgUSWZ
         RZR6m9Uk9OLzY4fVuvkuADQx++xwbvvmvzHWForWOAO1KA431IMOU5urBZPsBpSpRn5V
         IDhQ==
X-Gm-Message-State: AOAM533MEiRp5/F/CPFXY/ajF3GHVdBfn/heuq813K0lV5qDexWRjLk4
        Gg2tXdrXVRI1SH4YpUZjv6R3CJPVmrtDuZ3VuyAfzA==
X-Google-Smtp-Source: ABdhPJzR/ellVCtnCr18ZyYuoA8Tr5FujGTsbRFahthBlgbjhJAABO5VgJyH06GV11rFf+W3DyjyQNfVVQqjJqvU/SQ=
X-Received: by 2002:a9d:758b:: with SMTP id s11mr13757374otk.251.1600212964087;
 Tue, 15 Sep 2020 16:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
 <CAKwvOdmNzapwEo26m0soAR2OLFxOoERPKbKgvQ0bfoqjNkEVCg@mail.gmail.com> <20200915212804.vvm7ovffqynkvi5a@treble>
In-Reply-To: <20200915212804.vvm7ovffqynkvi5a@treble>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Sep 2020 01:35:52 +0200
Message-ID: <CANpmjNMWtZCUv-yB5eRBXaB=FLZESmtruq56Q3dS7hu2zDr9kQ@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 at 23:28, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Tue, Sep 15, 2020 at 02:13:01PM -0700, Nick Desaulniers wrote:
> > Triple checking what I wrote above; it looks like the randconfig had
> > BOTH CONFIG_KASAN=y and CONFIG_UBSAN=y enabled.  Aren't the sanitizers
> > supposed to be mutually exclusive?  If so, we should ensure that via
> > kconfig these can't be selected together via randconfig.
>
> No idea...

They are not mutually exclusive. The big ones like KASAN/KCSAN/KMSAN
are mutually exclusive (compiler complains if you mix the flags), but
UBSAN can be enabled with other sanitizers (and fsanitize-coverage,
although not strictly a "sanitizer" it's still instrumentation based).
In general, we shouldn't artificially disallow mixing them if it's
supported by the compiler and our runtime can handle it.

I'll have a look at the rest tomorrow (UBSAN_TRAP stuff, which
coincidentally also came up in some other patch).

Thanks,
-- Marco
