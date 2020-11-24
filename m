Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891122C23E6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgKXLJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732418AbgKXLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:09:08 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5026CC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 03:09:08 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y7so6619519lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 03:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZAwLjr8KspoBjmgRNrm6A/fZBDnUklQGOp47xcRZqg=;
        b=WcfZkfh0eVFoUsipHhn2lIdyQn1PvNhsvhIPb0FasBYXL9/QetbPypJYvKNpVizywP
         bUPURugPlZVNnS7rAvrCG/98igP0I2KoeV2gw/43m4xhABdGXigoUR7kYcqeWFC1zMGP
         H3GnzG7+TRk+q7OyzXU9bc5pGpTzMwNL3qlc8blBhyl8hukuNCGJSd5GbJV1j+V8xefX
         SILZfna+YhM0C8gb85B0IHiHYOAG1OGlSBkaadULkJNfqCL00b/2iNSs1sMaOpj2qIrP
         7+GiAxzoT9d0m8+XPyiYe5ho2F/5P073x+LFX+kpLfLLsHz3282jVkt3hiM+PJ0XcQx7
         8gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZAwLjr8KspoBjmgRNrm6A/fZBDnUklQGOp47xcRZqg=;
        b=HMNQmezpXoTScpA8/dHg8rUAmIh4D2uJNP2d8SRKXGT3/PqSpUE2FP4w4KYgrI0CB6
         6m5pXbzhnRyBUOb3jMN4zi4u8XnFKJE5bcVHsKL2bKkoECDt524yD7TV9b40FYr10KDi
         Z6XLMO35N19UbKwFhvlgFsOKB/xAwGmbLiKRTlC/uqReqpc7SMKFBczuvxLYtqU7iXOa
         fZpj1CYDYcnRQE/VFlsKhF7oGJ+zlZdE4LsujmTASgj+4/MSSjPpWYgPQgLNKl5+ccum
         pa9aE4hnvM9w5szTL8/HQ9DVQh4jz5sgw5j+Ei8HYCHIqfaLsfAjusXM4E+jZr+G6mXj
         u1gQ==
X-Gm-Message-State: AOAM53056U+uM1y5Q9ZwNB9EUAK49nCC8S0KSuKOO5gLMCjlvSwTsimC
        DTTyLdT1KDh98o+3kmNkWNAsIRqjyh4qtNp9kJVejQ==
X-Google-Smtp-Source: ABdhPJw4n9mKvhVyPpmKkDQXwOR/xXy+i3IveAgSpxh0mzd6CvAyL5PNmSCHvq3+ik41UJTjFWRoBD4oIqZN7bgUH30=
X-Received: by 2002:a2e:9d8d:: with SMTP id c13mr1606129ljj.160.1606216146604;
 Tue, 24 Nov 2020 03:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20201124104030.903-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20201124104030.903-1-lukas.bulwahn@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 24 Nov 2020 12:08:40 +0100
Message-ID: <CAG48ez1FqJYay1F=LUt84DVHd+k0=gXohwhTnwv=t1sv=hTSjw@mail.gmail.com>
Subject: Re: [PATCH] zlib: define get_unaligned16() only when used
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-janitors@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:40 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> Since commit acaab7335bd6 ("lib/zlib: remove outdated and incorrect
> pre-increment optimization"), get_unaligned16() is only used when
> !CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
>
> Hence, make CC=clang W=1 warns:
>
>   lib/zlib_inflate/inffast.c:20:1:
>     warning: unused function 'get_unaligned16' [-Wunused-function]
>
> Define get_unaligned16() only when it is actually used.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

AFAICS a nicer option would be to "#include <asm/unaligned.h>" and
then use "get_unaligned", which should automatically do the right
thing everywhere and remove the need for defining get_unaligned16()
and checking CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS entirely?
