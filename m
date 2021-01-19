Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90092FC1B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbhASU6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbhASU5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:57:41 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CA2C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:57:01 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j12so709204pjy.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3o3M1xuSeBDnr/2NRBnrOChpur5nQMVpX1X5cQHNno=;
        b=CqXMEVK5EzIRvJm2xMihoO8IDSMKtBKt6C3UP/z/z3sT4PlW3ySgXsyykoI8gs5EpS
         pnmreTGQQv5tsexAYUxAdea/V5RtLrPd8OaiopiTZpjyS7AaeQC2JdZs4YFpEZsBjabT
         J8Nj0vzYrljoYlhBdQNlAmodL/IbNRAvfQE6zBbOu3f5skBjwgzHtAAX9tgViO8enLgK
         R5jvcukHUE64H44Wr1NnxMHAoaqaQ/EZAFHYa8x/dJUDGYcXBokuT8FZktgh/2SBDPJL
         niWc0hqi8Sp7+uMiGGhkTQ4rwKffl6RaHEdpvu31+lmgIGzUqs2Cxn21cmEz0Ouosysb
         mihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3o3M1xuSeBDnr/2NRBnrOChpur5nQMVpX1X5cQHNno=;
        b=dDbSvp/lrfCukffh3IgB8ahtpLMTyr4+OS0EYmfBhQVtean+lFTGY8t9L4DIZTeeFU
         +w/5u+ByHBIHNayAjcvPZswvk5onuHj+g+17127oA20QJwHSvNM7MEXf67jDyUifgHJg
         5Os0fT6RR+y9O6K9k7CHSxSAI52jwJjxS2gGXomzXb9Vo8T/ELoAbHJd7ZqCJGXpwadu
         JGz4v7bgBMYlczbuUEMNwCoesGgT/642M2e9z7sPtiTbezfNqYzhRGwwgqjpxvUyNVTS
         PAtwuRIaowQ44cyQiswgLKp4O+0+Zo+m6w0Prsxd3WcGeV9En92GAqQb6luR/idPDK32
         EiZA==
X-Gm-Message-State: AOAM5321gRERlvICJEIgn2S97SLefir9Veq6c9jf0PBJqBcmcr98hKl5
        B8c53qHkcwARrwXplNpXCLkHiTwgCzDBvVP0RKWMcQ==
X-Google-Smtp-Source: ABdhPJzCOtu5iMV1uVucF78AT17AmcBbgaum0b8mArJ65rahfgu6D+0BzAC8FRXxjDQKBDA8Z3Vhz3J/nkveGEd0sHk=
X-Received: by 2002:a17:903:31d1:b029:de:8361:739b with SMTP id
 v17-20020a17090331d1b02900de8361739bmr6643756ple.85.1611089820931; Tue, 19
 Jan 2021 12:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20210119172607.18400-1-vincenzo.frascino@arm.com>
 <CAAeHK+zpB6GZcAbWnmvKu5mk_HuNEaXV2OwRuSNnVjddjBqZMQ@mail.gmail.com>
 <20210119185206.GA26948@gaia> <418db49b-1412-85ca-909e-9cdcd9fdb089@arm.com>
In-Reply-To: <418db49b-1412-85ca-909e-9cdcd9fdb089@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Jan 2021 21:56:49 +0100
Message-ID: <CAAeHK+yrPEaHe=ifhhP2BYPCCo1zuqsH-in4qTfMqNYCh-yxWw@mail.gmail.com>
Subject: Re: [PATCH] kasan: Add explicit preconditions to kasan_report()
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Alexander Potapenko <glider@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 9:32 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> This seems not working on arm64 because according to virt_addr_valid 0 is a
> valid virtual address, in fact:
>
> __is_lm_address(0) == true && pfn_valid(virt_to_pfn(0)) == true.
>
> An option could be to make an exception for virtual address 0 in
> addr_has_metadata() something like:
>
> static inline bool addr_has_metadata(const void *addr)
> {
>         if ((u64)addr == 0)
>                 return false;

This sounds good to me, but we need to check for < PAGE_SIZE or
something like that, right? There's some limit below which accesses
are considered null-ptr-derefs.

>         return (is_vmalloc_addr(addr) || virt_addr_valid(addr));

Do we need is_vmalloc_addr()? As we don't yet have vmalloc support for HW_TAGS.
