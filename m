Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB942FC2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbhASWHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbhASWGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 17:06:22 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3DAC061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:05:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id my11so2062000pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3VDFmCkUMNPKmHsspsc2TmeFVZbcyk9WVcGlmL8bi5c=;
        b=gHAO+OhWy4XWUPe1e+eFCec1GdQz1h3qg6HQdZkm26CnELouSOxaLmGiwcBXiZdzDR
         lOLCIxcuu+b2Yf3fh1yWr0nhNNiZxM32pcT7Mzbxt39Fn7XUqzzo25HarEjEs3jZOygL
         TbHfp+u2uB19rAJoTmwKvbkcEMtgUkQ/XIgc1yXYeu7L0TU2LHOi+VStCX6HBN9Fj4TY
         AZI7tsSMRpYi86eXYfKbDOAXiv39VvVCz3bZ7zkmnHhicrtrWLJP9gaW5q5BYgmSsBgM
         L8WgMtZhcippL53HQ3XDti9k4DQnTo5Nl5kms4irTjGytZkOTTa8BEnBt4QGK/McxKUk
         CRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3VDFmCkUMNPKmHsspsc2TmeFVZbcyk9WVcGlmL8bi5c=;
        b=RoZx4ObnP7/6wmizLJGch/lCeSXGbUyzRmTThQ1Vl+7dfrp95N3pQXUKZLAES3gQjf
         UU0mToAbrUHxiyzmfc0aCOWZhGjyQbiFB7S58t85LSaCy4V8zDo3E2nCHODiEVbQy4uc
         zuYYY1o1/BFdqUGDhx9F3NzQX/kE0OLvMdIHoyURmWGRBG4HsZRdKeONSp8iImfJzuG5
         Fdkv1h76fYGDoLvN8RWFAKchbhpVzyY3avhRbD2NagTNyK8/XS0yAk5xMgnlICTITPYM
         9KkTkc0hZmSrRneLYl6mOKMAFSoBWiyxCETT0MAxKwlYL6A8j8BCyorBQukI2WuGO850
         SP4Q==
X-Gm-Message-State: AOAM533k++vgyUEPGCnQxSLemctttdRDZPLYqqf7gI8Nekl0FiCCKQ7c
        YpvKoCgX5jxngxeXAQE7p0QxZzUbkC+5zeygMNhPMA==
X-Google-Smtp-Source: ABdhPJyl0R8PgmqarNl2t4igF3LEJ4gwkvBDXyl4xe37wUbPOGONHDFIitO7ItUlwR8Q7YbheNvLfXmyDLIoCbrn89I=
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr6951605plc.10.1611093941955; Tue, 19 Jan
 2021 14:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20210119131724.308884-1-adrian.ratiu@collabora.com>
 <20210119131724.308884-2-adrian.ratiu@collabora.com> <3dbc2ce713e44e3a9a913db5446506a8@AcuMS.aculab.com>
In-Reply-To: <3dbc2ce713e44e3a9a913db5446506a8@AcuMS.aculab.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Jan 2021 14:05:30 -0800
Message-ID: <CAKwvOdkicQtiY13ey7uUgF9PsHGMYQbaWzYTUcY7GhYWL=xb3w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning
To:     David Laight <David.Laight@aculab.com>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 2:04 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Adrian Ratiu
> > Sent: 19 January 2021 13:17
> > To: linux-arm-kernel@lists.infradead.org
> >
> > Drop warning because kernel now requires GCC >= v4.9 after
> > commit 6ec4476ac825 ("Raise gcc version requirement to 4.9")
> > and clarify that -ftree-vectorize now always needs enabling
> > for GCC by directly testing the presence of CONFIG_CC_IS_GCC.
> ...
> > -#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
> > +#ifdef CONFIG_CC_IS_GCC
> >  #pragma GCC optimize "tree-vectorize"
> > -#else
>
> I thought that #pragma optimise was very likely to remove
> a random subset of the command line parameters leading to
> incorrect/unexpected code.
>
> As such the extra option needs to passed in as a per source
> file compiler option.

Yes, patch 2 in the series removes it from .c source, and passes
-ftree-vectorize during Kbuild.

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>


-- 
Thanks,
~Nick Desaulniers
