Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF612F2A72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392430AbhALI6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbhALI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:58:19 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463B0C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:57:39 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id w79so1245989qkb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hebm0dWwRuXQzzZ6zng4XzueSgh0hzQ/w7cKVtFlvCM=;
        b=bPcct8nvOJRy9LwnufMdK38h7PmniTBrPsjeZyv33adIK10glCWRhU1wyr6VQIQIc0
         iXCF7cBlivX1A8n/quXSY9Vg15nSBo/Qy++qGGWTOuw4ExCYdBLPlhNSxN84jb8Dw4RH
         yCZvbnoPrdlW2t80zer6fh31qGEmQ54WhExLE8Br6TyfJRu98+wHhVd5n2O5mS6/Kqpv
         I98LjZ+TznIMk7Q5wQrBXUsKK0wO5NCc86SfJI0MDXVuLfmrCV8XJyCaYj6EnmfEdom1
         pVUNgImDXqSyYNDmM57iot/L9ywwnKttozy6B+sr5pwWly8ITylVz8UeOrAcM7L18Jbx
         1neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hebm0dWwRuXQzzZ6zng4XzueSgh0hzQ/w7cKVtFlvCM=;
        b=E9iUdEfrGba0JGu6sGcs/oTQ92VtgSIDa7IocGlYXM3ebWovkL05SjYMMWjkxT1LFN
         JPL0JfWW2tzpZI1UrzoPaqgmbpCo+Jz3YaqWajLZTxlO4h8AnDmX6YQqz7bh71wt98k2
         W4XU/Z6pkw1CkFh+uhGR8+QTVfg0JiyihO+2IB3p3k7Z8e/8RC5pp0eF6VT3qdUz1qYI
         Qi0zL6IiPcycvsQMw0xzJYr+3cRoZZnwhNZcBd2DTpAxScZO+D5paB9A6T68Mvhk2nuB
         flmOPLkKy45B+onogwfMoQKwRq1eE0xGquCN3tmTfC3pwZpAq7cEN33pjIavgOmIaNt+
         cGng==
X-Gm-Message-State: AOAM533ZkkPElIJLtxJocBiAVXuNLE+wTYRKtmN1GjGgyja6JrXRaK3k
        irNPpyu0Rurj6XUK1T78f5zCZAuFKNC0VlajgoUzPg==
X-Google-Smtp-Source: ABdhPJzb5I0HxtY6ms9ty7il73wvL5i1E6U0GUhqgIUB/bnIrVz4CVtF/g/QZWOLmqWfqwG1Qy9uudInPSdRsFQf9EA=
X-Received: by 2002:a37:70d:: with SMTP id 13mr3424840qkh.326.1610441858281;
 Tue, 12 Jan 2021 00:57:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <15ca1976b26aa9edcec4a9d0f3b73f5b6536e5d0.1609871239.git.andreyknvl@google.com>
In-Reply-To: <15ca1976b26aa9edcec4a9d0f3b73f5b6536e5d0.1609871239.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 12 Jan 2021 09:57:27 +0100
Message-ID: <CAG_fn=UiqTFkrDz=0vPdWgjvVA8702oYXxvUh5fDadgC1cm0MQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] kasan: add proper page allocator tests
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> The currently existing page allocator tests rely on kmalloc fallback
> with large sizes that is only present for SLUB. Add proper tests that
> use alloc/free_pages().
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ia173d5a1b215fe6b2548d814ef0f4433cf983570
Reviewed-by: Alexander Potapenko <glider@google.com>
