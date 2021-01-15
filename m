Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5652F896E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 00:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbhAOXf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 18:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbhAOXfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 18:35:25 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64042C061794
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:34:45 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u11so1203491plg.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M45X1uVUPkAgzVTV1F36XDTKyhVWjHkf+etFM5uHOJs=;
        b=aIx3Nub14MCK6Ayv85Qd7DS3NeDHqNI2lHEyU5eGrWUowDcvNuVy2/an4j5/+207q6
         EsHUAA/Et0cuJjYAOm8qIJY7n220NxZp0yp18RNKAXViuPN4lMtybmXLIJxmtwJqGDKR
         PNOvolEQRZKk/XmMe0BT9hmxXXfmzp0AbpVgJUja6M7QaSzKjKw0DFtTUBcAJ7s3FFA9
         zZ3oGphi2Rk3sLtncvFNTbA7+nH1X4HvgOc0d8r4kqIgnW3OwPdu2ik1PVVrCQy5sDEW
         y1NBbRTFTpCCrJGbxAltfxNi8HpVJpPJ1gloIBkn9Vt5DDmGg2lYfVpmu6VMWYEO2VKN
         2okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M45X1uVUPkAgzVTV1F36XDTKyhVWjHkf+etFM5uHOJs=;
        b=BTBrtEghd/0Tq2kqSUZ7wMXs+mPuMSmo5SpQzLIdCg2K9dRj4ZezVuf4mDQt9uirOL
         NRcml3TNYllLk8n1jG1I96JbD3zy37RhJVQgzSSAXU8RMprn/eQrhxAldvKVHTRD5eb0
         5DHG3vXopnQkLLIzYeErvA5D+CEbjzGIyTJRW6ypBOTYprzk6QdEpbhQTOslv6QyO3Zy
         SygOldM/OZkIVWyruskLs6LFwsW16LCv1cFjeJZva8Vr/O3ry+3QzkfjIK5CcmIQ5gD5
         zYFkOuABdeIlaTQmlzl3t8h5jl4Y2ggpLCEcuS0rc5EXUhVDczSlbKUKdW4sCis7Db8R
         VsWA==
X-Gm-Message-State: AOAM530QiUmQrcXCYnGhjPm9PndSGHDJ2BDDZSUP4v8T/EVRHUOiKio6
        02fblPX5lhAbFyfhyYZ8GTa8KOm6KTHIS6rxn7mv1Q==
X-Google-Smtp-Source: ABdhPJxkSxoT54fsPyvQtLqE50NgLGUdW+qfRdnn9mqxf/4hpJok+NnuJbRhl1zXuiY9UFXdTWTlniFEn3qoaGBjRss=
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr15203377plc.10.1610753684580; Fri, 15
 Jan 2021 15:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com> <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com>
In-Reply-To: <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Jan 2021 15:34:33 -0800
Message-ID: <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Kbuild: DWARF v5 support
To:     Sedat Dilek <sedat.dilek@gmail.com>, Yonghong Song <yhs@fb.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 3:24 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/15/21 1:53 PM, Sedat Dilek wrote:
> > En plus, I encountered breakage with GCC v10.2.1 and LLVM=1 and
> > CONFIG_DEBUG_INFO_DWARF4.
> > So might be good to add a "depends on !DEBUG_INFO_BTF" in this combination.

Can you privately send me your configs that repro? Maybe I can isolate
it to a set of configs?

>
> I suggested not to add !DEBUG_INFO_BTF to CONFIG_DEBUG_INFO_DWARF4.
> It is not there before and adding this may suddenly break some users.
>
> If certain combination of gcc/llvm does not work for
> CONFIG_DEBUG_INFO_DWARF4 with pahole, this is a bug bpf community
> should fix.

Is there a place I should report bugs?

>
> >
> > I had some other small nits commented in the single patches.
> >
> > As requested in your previous patch-series, feel free to add my:
> >
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Yeah, I'll keep it if v6 is just commit message changes.

-- 
Thanks,
~Nick Desaulniers
