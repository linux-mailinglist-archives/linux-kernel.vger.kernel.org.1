Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2612817E1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbgJBQ1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgJBQ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:27:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D405DC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 09:27:29 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s205so1671239lja.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XESAsar1PPbow9QXM6iPAt7dZfh4lXWZnIFR2ENhSp8=;
        b=dQd4p/GwRMxd2rF8gBrN78ey6p2K8zuzTy3s9sWMNAin9xHfUCuyFLi919lpEWk9Dc
         zCAWOHW6ysQaFQHfncwjPw8GtCF9mIdVDdsTyJBxdGYxPtsWb34P9+jGkQhhAkEUnrzR
         +hu0t3g2U6uMrarSu3VT/dg6iysw2VK0TvQ0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XESAsar1PPbow9QXM6iPAt7dZfh4lXWZnIFR2ENhSp8=;
        b=HbJ43yYg7gDjnXp9PL4A6uwcTh+t2Hc6usezkIMiR1wP+00ha9QLDrskotturGe0zD
         9FsfpuNfrULEKnC3IPm+xPmWCfXQtTToEc8eNs209D2kw6U4nL8w7TL+UFedyjp8P1sa
         Op1kK6BMye8ZVuepOXHf7uO/xn9i+rc68ZnE9xRhUnJadOq4HJv56q3auDS6aObbbaJ1
         S2ZOPZ5/ERu+MlQeEqg5rIJKtx6LAMJDEnQEAXBSAS8I0F8f2AwwjUEsGXWKpTl+hpjp
         WZdtzy9lelgVnu/VCjY4B1/uYidUowE2AuRs9UomHrY1Oz7JUu0nnkmBmRLVTZ9Yl3gE
         j/Fw==
X-Gm-Message-State: AOAM5319lKjD3fk3/n9PRJ254P3KYHIu/O8XSMwXpbIjogc1RONB8ITb
        9aPuA1PMPCMUFyNMUGtOozhrD8OoBrczYA==
X-Google-Smtp-Source: ABdhPJxaGQE4TuXGRYeNkb7UL8b1SmnDsWyu+mwxRW+0bP4XEndxPORoct+J4F1vI3F9ux7wrYlLmw==
X-Received: by 2002:a2e:964e:: with SMTP id z14mr928656ljh.86.1601656047758;
        Fri, 02 Oct 2020 09:27:27 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 73sm372689lfi.229.2020.10.02.09.27.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 09:27:26 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id z19so2590520lfr.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 09:27:26 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr1257887lfg.344.1601656045931;
 Fri, 02 Oct 2020 09:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de> <20200903142242.925828-6-hch@lst.de>
 <20201001223852.GA855@sol.localdomain> <20201001224051.GI3421308@ZenIV.linux.org.uk>
In-Reply-To: <20201001224051.GI3421308@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Oct 2020 09:27:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
Message-ID: <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
Subject: Re: [PATCH 05/14] fs: don't allow kernel reads and writes without
 iter ops
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 3:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Better
>         loff_t dummy = 0;
> ...
>                 wr = __kernel_write(file, data, bytes, &dummy);

No, just fix __kernel_write() to work correctly.

The fact is, NULL _is_ the right pointer for ppos these days.

That commit by Christoph is buggy: it replaces new_sync_write() with a
buggy open-coded version.

Notice how new_sync_write does

        kiocb.ki_pos = (ppos ? *ppos : 0);
,,,
        if (ret > 0 && ppos)
                *ppos = kiocb.ki_pos;

but the open-coded version doesn't.

So just fix that in linux-next. The *last* thing we want is to have
different semantics for the "same" kernel functions.

               Linus
