Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82072B65E5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbgKQN6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbgKQNSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:18:45 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353F9C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:18:45 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 79so19295598otc.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pa0dw+2YDpQA3Ip7yWMCpwDF+q2V8p/vPHE4K5vOsWU=;
        b=kHpe6ZacvQalxImqYZ7Y/Tk8Xjw4k5FGX1UY3t/LRIwWRZmd9vBOLAnRtGqkYTNV/8
         N1tM1Z4t15cJ3hI03/Fqy/u766FH2Q7C8ibXnQH7ygnlt6SoY516fehJgltRw4Tdf5ou
         /MIP8VoxRk3+7pMZiBxotFbBZH69xaXFxn/P770IbhdeB8US1QVd5wwWZSv2TGMJMdDq
         q1vj0z/gj/AVe8F1on0J3RXV2WEidKxliEvz9jYscGMLWveMr31Z1FwxwYoWb4MwZ8K7
         RXBTdRlJRkRk6umlo+RJd4UAY9lxe5infHlR0AznIXeW8P+2ovCZb7vlhoqecEma65s+
         4xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pa0dw+2YDpQA3Ip7yWMCpwDF+q2V8p/vPHE4K5vOsWU=;
        b=iqvinht+A6PFyOzxQeBXemCalYC1SdWqFMok2D6pz0s3Bix3hUCdJBT1e2r8/pDlnt
         2B+7X8i+4vByMMYlvpPQUSHlNR7EuAuEN9tTcJ/LNQ/FqxQ+mt5JN+GvrkMhwDXgOj3X
         YXC2V7bS8tUIBNoD7c8zl8VN6hJDYXjLXYFw1t/i8XhCltDgP0SKVJLLeDKKz0HNubWh
         FCp49Y3SKKlUByllckIROfD8VkC3NScbtDwu1RaH1d6lAG6+46ilsdWflPQ+J1+0286o
         xnyiThGuJFq/RXSI/mYRs6Y/kUzV5Bixw05v+nbV9Z11Rojgm887B08bk7nSqRGB4/2j
         LBlA==
X-Gm-Message-State: AOAM532Jzeied+6LoP/P43tJo4ih7Ui4HrtxUXIf+sE87XD/hO8D22BS
        M1LiWLWMVkpZ3MD7zWMQgpJsRaR2OwDhqtyEkb3YKA==
X-Google-Smtp-Source: ABdhPJzceQV4pvLQZoRKoQlzVJPrNglPcBp5aH4wjBQUCmugGSRGSwyeI7fnJHOFVn7ftcB1JSeqjD1Y2otDtNStrlc=
X-Received: by 2002:a9d:f44:: with SMTP id 62mr3111227ott.17.1605619124327;
 Tue, 17 Nov 2020 05:18:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com> <52518837b34d607abbf30855b3ac4cb1a9486946.1605305978.git.andreyknvl@google.com>
 <CACT4Y+ZaRgqpgPRe5k5fVrhd_He5_6N55715YzwWcQyvxYUNRQ@mail.gmail.com>
In-Reply-To: <CACT4Y+ZaRgqpgPRe5k5fVrhd_He5_6N55715YzwWcQyvxYUNRQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 17 Nov 2020 14:18:32 +0100
Message-ID: <CANpmjNN6=5Vy5puLbhOQxSNUNptFA9jKKqnU4RXRcLb4JT=hJg@mail.gmail.com>
Subject: Re: [PATCH mm v3 17/19] kasan: clean up metadata allocation and usage
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 at 14:12, Dmitry Vyukov <dvyukov@google.com> wrote:

> > +        */
> >         *(u8 *)kasan_mem_to_shadow(object) = KASAN_KMALLOC_FREE;
> > +
> >         ___cache_free(cache, object, _THIS_IP_);
> >
> >         if (IS_ENABLED(CONFIG_SLAB))
> > @@ -168,6 +173,9 @@ void quarantine_put(struct kmem_cache *cache, void *object)
> >         struct qlist_head temp = QLIST_INIT;
> >         struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
> >
> > +       if (!meta)
> > +               return;
>
> Humm... is this possible? If yes, we would be leaking the object here...
> Perhaps BUG_ON with a comment instead.

If this is possible in prod-mode KASAN, a WARN_ON() that returns would be safer.
