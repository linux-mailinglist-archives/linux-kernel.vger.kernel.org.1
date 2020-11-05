Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CCD2A886D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbgKEUzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbgKEUzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:55:35 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56866C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 12:55:35 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 72so2280835pfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 12:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6qIMVqiA2Fxo2S0U5vENxe+8wBYBu+gcLv3Ol2uQO4=;
        b=V1EWY2qTv2l6096lUSNRlOgEeBCihHnbEFwhdnN4vryIF9UytRj2f37ptBwgumQ2ia
         /j5o6He7bvTZf7rnwGip5MgAaixxTTu55jK/cC1iBuqCIllSMqBk+gUt8vliaGLt2RlU
         5e6CD52XoSwJUFT7LhqED7PNN+I94Z6nFqBP1RpcE/vhXMO57yVFupdHwfyfqJvL9vTl
         sQUGXTd8ApguqjJmVNSzGjSi54gC/P2KhuIHXZVQi1KQftuDEVSKbOaex3Ax6PSACFsY
         iOOe9sB87m4rLF+VMqJUqInxIxlgGsrPCYpOm4ylOb6ZO7tpoa12up6i/BF0qbzlY2da
         WcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6qIMVqiA2Fxo2S0U5vENxe+8wBYBu+gcLv3Ol2uQO4=;
        b=R1giIS2hOxpAk1j2vhtvD0PspCBz6w8GLWzq3XZorwsCnhY2S6hJ5/8v0wwUfZ0chs
         7GO5vEH41jvgR6a2MmyfHjvtkCxlWnsIEiEc0zWD1k40iCa/y3bdvLaPXJ7zFXt9Bs99
         rUAkZCVittWTgvpVPSXhSMF5Ck4snjCCXlq+eL2tO6f1ZEI99GqWy4f7Dm9VWOlS5w1u
         hEoCDlqb0PXG8jFnYjpkaziDHvsPXJzeP8qjidWYyRhgopo0fMDA9bfmmSfejjEj76Gn
         b1xO+FFdeIvvVAt782giPd3RM8sKgllrH4MyjWXVUMVw2M6g8UubMQboCnMVRdBhO3/h
         9WLw==
X-Gm-Message-State: AOAM5329aM1s4ADzG5rGGRR22oCWMlgwBp+/TIA5jVkDzMFdDsMqSypY
        U0LxZ4zryXt3/Co9pN4fHjcftJxUrWNxkYNZFyxDPg==
X-Google-Smtp-Source: ABdhPJzSyP7bQ6RX14EmWp5JMfkGxRUx2wR4AdVgmfDwnE/vKYHccrQS+qlbfJN7TsMFCIx+kkr+RG/z4D9aRaBBYIg=
X-Received: by 2002:a63:1f53:: with SMTP id q19mr4123898pgm.286.1604609734699;
 Thu, 05 Nov 2020 12:55:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com> <CAFKCwrgCfx_DBf_b0bJum5Y6w1hp_xzQ_xqgMe1OH2Kqw6qrxQ@mail.gmail.com>
In-Reply-To: <CAFKCwrgCfx_DBf_b0bJum5Y6w1hp_xzQ_xqgMe1OH2Kqw6qrxQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 5 Nov 2020 21:55:23 +0100
Message-ID: <CAAeHK+zHpfwABe2Xj7U1=d2dzu4NTpBsv7vG1th14G7f=t7unw@mail.gmail.com>
Subject: Re: [PATCH 00/20] kasan: boot parameters for hardware tag-based mode
To:     Evgenii Stepanov <eugenis@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 9:49 PM Evgenii Stepanov <eugenis@google.com> wrote:
>
> > The chosen mode provides default control values for the features mentioned
> > above. However it's also possible to override the default values by
> > providing:
> >
> > - kasan.stack=off/on - enable stacks collection
> >                    (default: on for mode=full, otherwise off)
>
> I think this was discussed before, but should this be kasan.stacktrace
> or something like that?
> In other places "kasan stack" refers to stack instrumentation, not
> stack trace collection.
> Ex.: CONFIG_KASAN_STACK

Forgot to update it here, but it's kasan.stacks now (with an s at the
end). kasan.stacktrace might be better, although it's somewhat long.
WDYT?
