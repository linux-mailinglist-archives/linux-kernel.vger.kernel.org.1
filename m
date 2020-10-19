Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C1C292725
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 14:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgJSMXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 08:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgJSMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 08:23:33 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65602C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 05:23:33 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id j6so733412oot.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 05:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQ/xkg0nub+4PWvL+CKk+B6D0YwCVYzzs73TSH8kNVQ=;
        b=KNNb2quRNLavZKnbq84BN09PddtCjLDKY8l1PyePqN5qML8laC3nwaT4NBr6GPVvbT
         m5hi+ylV5PTV+5yC10AJBXvrs12rCkXvCytqYOrw/J/9HaXCMhs4eCxjzU4NlfxV8OeW
         cT/aBDM00HfqE4piZMdL3Q+G5PdL6mNzRsJK/DPeHuHnZPWgT6veGAueDDLkhswiVsaS
         jdi1wuddVSNiBQFt+EDXt7rX5X/BAJ3eSgnp7hR8du7ENJkT2sdHDVfJvkJtZyvOIXda
         t3PodY9tjcaBiQSD0P3dlMjWpPmRdatAeK8xBAf3ATrED/JrpF04RRRg++k9JCpoiazV
         Em/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQ/xkg0nub+4PWvL+CKk+B6D0YwCVYzzs73TSH8kNVQ=;
        b=AmKxhUjSpttKTMl58PBh6Jqb9bB7wWZaLmwYag0OqQq5pdAXjFMsMJezLY/y9hzVcr
         yWDwdqfoQqLQOa3RpeTCcsER89F6q++sNV9Vnld1lwxy6OFDYMLqVUihOMTCo8LcM9Fz
         gCfluFJ8ybTWPcZEkbGxaiEwpDPKZLlqEi38fkxUCCnKFtN3pGfQ9HEFAfSkh3v22pcC
         vElJ9cxYC/aw2ZyUMoaTYTCj6ue73QaGg7HrytbjQ62H4RNOUa94BTiXxDJgDBSj8caB
         y9K1+ontnbThkI31XFH/i1JJ5mr33uNyhCte0oTXIHLod+pcY/lWSsaAHtVwmxqD/VRa
         3fHQ==
X-Gm-Message-State: AOAM530i74CFK84qXXAJ101P/Sbp2nrB4lDaNlxbIFoN78dzsD7RMjfD
        B8EVVOOfG8TgkKFdfyaYW5dzJovyDo1QpgJBaDCCvQ==
X-Google-Smtp-Source: ABdhPJyzrJGEyTNn3o7Z/7yYsS4rCx6vGVxAMJ4aeGbENvimZAAEsHrHYujEbgneVgAi5nthk0tr5Wqrq/EUItPn75c=
X-Received: by 2002:a4a:b28b:: with SMTP id k11mr11874415ooo.54.1603110212494;
 Mon, 19 Oct 2020 05:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com>
In-Reply-To: <cover.1602708025.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 19 Oct 2020 14:23:20 +0200
Message-ID: <CANpmjNN3Ax2_CfxXixh8-NipXOx7s8vprg23ua-M_tvUKZGq0Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] kasan: hardware tag-based mode for production use
 on arm64
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Serban Constantinescu <serbanc@google.com>,
        Kostya Serebryany <kcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 at 22:44, Andrey Konovalov <andreyknvl@google.com> wrote:
[...]
> A question to KASAN maintainers: what would be the best way to support the
> "off" mode? I see two potential approaches: add a check into each kasan
> callback (easier to implement, but we still call kasan callbacks, even
> though they immediately return), or add inline header wrappers that do the
> same.

This is tricky, because we don't know how bad the performance will be
if we keep them as calls. We'd have to understand the performance
impact of keeping them as calls, and if the performance impact is
acceptable or not.

Without understanding the performance impact, the only viable option I
see is to add __always_inline kasan_foo() wrappers, which use the
static branch to guard calls to __kasan_foo().

Thanks,
-- Marco
