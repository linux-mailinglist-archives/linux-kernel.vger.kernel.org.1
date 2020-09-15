Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95286269EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIOGqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgIOGqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:46:13 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF69C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:46:12 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z19so1914575lfr.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Arb/NJZf3RvSWdo2XGt0U808ae95hYhvCHxGQOFhAuA=;
        b=TWMi96qFEmbnv+fzUE0tWqbV5DVfrHOErkfMfIFqS5M1qIyGrDe8yY56tUm90f2mt2
         1MfPGLB+0y+IvQ7tQ6g580mq/IxRLgQxsgNiC9hAdasNO6svhNHU3sYcADkA+JlxcUt/
         vcK+eibaxs1EQrdk12O8j9ZpbYquqyKtztHdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Arb/NJZf3RvSWdo2XGt0U808ae95hYhvCHxGQOFhAuA=;
        b=flD2T6tb5WyXa1aePJBJ5+thmONovdJS9O9y76cwpvV8OLMYRS+ct+9LJ4u78twfaw
         T8lxc9uHYs+QvPgzONGXr75qT4KmGzoACmYbs5//I2A0ptpM4sZKGVpM1XdYOnvAEvtk
         ZcPM41LRBFKIl2M7k5Fml0Om4XD8R0OVSTSHPtj7oLYw54917GjVYRz8O4DHs4pSdRUW
         yp/yH/WAPrZ8BBPy5Lqrd0JqNw2z0IUT8MDjokb+x48iIMpOiUlPKKBBAka8psX8lhQj
         BgL9kkzl0pWuYRUO24+9+p0sXhl9SDjfHDR/75SXk0ziui3l9q7J2S085cCbrDyGRIEu
         YnCA==
X-Gm-Message-State: AOAM530ese864eo2eks0wvGOhJARQJIN0AgXyRCM/S4oKg6pkGz/xDxG
        yRCbDwmYnhd9MRwrGxje60HAn7eKplSaMA==
X-Google-Smtp-Source: ABdhPJza2zZZLauXFGW2s6Np+XqbxNO0tMrWXicC0urorC0nvS81hrAVAoN8g6V0g0NCPCdWRbk3oA==
X-Received: by 2002:ac2:5e2a:: with SMTP id o10mr5362528lfg.315.1600152370616;
        Mon, 14 Sep 2020 23:46:10 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id p18sm4483338ljg.26.2020.09.14.23.46.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 23:46:09 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id a22so1748289ljp.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:46:09 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr5804981ljp.314.1600152369175;
 Mon, 14 Sep 2020 23:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <CAHk-=wjOV6f_ddg+QVCF6RUe+pXPhSR2WevnNyOs9oT+q2ihEA@mail.gmail.com> <20200915033024.GB25789@gondor.apana.org.au>
In-Reply-To: <20200915033024.GB25789@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Sep 2020 23:45:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgX=ynJAXYYOAM7J8Tee8acERrGOopNu6ZcLN=SEXdGKA@mail.gmail.com>
Message-ID: <CAHk-=wgX=ynJAXYYOAM7J8Tee8acERrGOopNu6ZcLN=SEXdGKA@mail.gmail.com>
Subject: Re: [PATCH] crypto: lib/chacha20poly1305 - Set SG_MITER_ATOMIC unconditionally
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 8:30 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> There is no reason for the chacha20poly1305 SG miter code to use
> kmap instead of kmap_atomic as the critical section doesn't sleep
> anyway.  So we can simply get rid of the preemptible check and
> set SG_MITER_ATOMIC unconditionally.

So I'd prefer to make SG_MITER_ATOMIC go away entirely, and just
remove the non-atomic case..

A quick grep seems to imply that just about all users set the ATOMIC
bit anyway. I didn't look at everything, but every case I _did_ look
at did seem to set the ATOMIC bit.

So it really did seem like there isn't a lot of reason to have the
non-atomic case, and this flag could go away - not by virtue of the
atomic case going away, but by virtue of the atomic case being the
only actual case.

I mean, I did find one case that didn't set it (cb710-mmc.c), but
pattern-matching to the other mmc cases, that one looks like it
_should_ have set the atomic flag like everybody else did.

Did I miss something?

             Linus
